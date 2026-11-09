class_name WoodlandNetwork
extends Node
## Isolated display-only relay. Never speaks Skybound wire v4 or holds teacher/seat credentials.
signal status_changed(text: String)
signal snapshot_received(peers: Array)
var socket := WebSocketPeer.new()
var connected := false
var joining := false
var room := "FOREST"
var local_id := ""
var latest_state: Dictionary = {}
var send_clock := 0.0
var join_clock := 0.0
var state_was := WebSocketPeer.STATE_CLOSED

func join_local(url: String, code: String) -> void:
	disconnect_local()
	room = code.strip_edges().to_upper()
	if room.length() < 1 or room.length() > 12 or not room.is_valid_identifier():
		status_changed.emit("Room: 1–12 letters, numbers or underscore; start with a letter.")
		return
	if not (url.begins_with("ws://127.0.0.1:") or url.begins_with("ws://localhost:") or url.begins_with("wss://")):
		status_changed.emit("Use loopback ws:// or a separately approved secure relay.")
		return
	socket = WebSocketPeer.new()
	socket.inbound_buffer_size = 65536
	socket.outbound_buffer_size = 8192
	socket.max_queued_packets = 16
	var result := socket.connect_to_url(url)
	if result != OK:
		status_changed.emit("Relay unavailable (%s). Solo remains playable." % result)
		return
	joining = true
	join_clock = 0
	status_changed.emit("Connecting local prototype relay…")

func disconnect_local() -> void:
	if socket.get_ready_state() != WebSocketPeer.STATE_CLOSED:
		socket.close(1000, "Leaving prototype")
	connected = false
	joining = false
	local_id = ""
	snapshot_received.emit([])
	status_changed.emit("Solo · local relay disconnected")

func _process(dt: float) -> void:
	socket.poll()
	var state := socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		if joining and state_was != WebSocketPeer.STATE_OPEN:
			socket.send_text(JSON.stringify({"type": "hello", "version": 1, "room": room}))
		while socket.get_available_packet_count() > 0:
			var packet := socket.get_packet()
			if packet.size() > 60000:
				continue
			var message = JSON.parse_string(packet.get_string_from_utf8())
			if not message is Dictionary:
				continue
			if message.get("type") == "welcome" and message.get("version") == 1:
				local_id = str(message.get("id", ""))
				connected = not local_id.is_empty()
				joining = false
				status_changed.emit("Local relay · %s · visual peers only" % room)
			elif message.get("type") == "snapshot" and message.get("peers") is Array and message.peers.size() <= 8:
				snapshot_received.emit(message.peers)
			elif message.get("type") == "error":
				status_changed.emit("Relay: %s" % str(message.get("message", "error")).left(120))
		if connected:
			send_clock += dt
			if send_clock >= 0.05:
				send_clock = 0
				socket.send_text(JSON.stringify({"type": "state", "state": latest_state}))
	elif state == WebSocketPeer.STATE_CLOSED:
		if connected or joining:
			connected = false
			joining = false
			snapshot_received.emit([])
			status_changed.emit("Relay closed (%s). Solo remains playable." % socket.get_close_code())
	if joining:
		join_clock += dt
		if join_clock > 6:
			disconnect_local()
			status_changed.emit("Relay timed out. Start tools/serve.py; solo remains playable.")
	state_was = state
