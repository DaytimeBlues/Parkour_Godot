#!/usr/bin/env python3
"""Serve the Godot export and optional isolated relay, strictly on loopback.
python tools/serve.py  (requires websockets==15.0.1 for peer connections)
"""
import argparse,asyncio,functools,http.server,pathlib,threading
from relay import Relay

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--http-port',type=int,default=49236);parser.add_argument('--relay-port',type=int,default=49237);parser.add_argument('--solo',action='store_true');args=parser.parse_args()
    root=pathlib.Path(__file__).resolve().parents[1]/'web'
    if not (root/'index.html').is_file():raise SystemExit('First export Web/index.html from Godot. See README.md.')
    class Handler(http.server.SimpleHTTPRequestHandler):
        def end_headers(self):
            self.send_header('Cache-Control','no-store');self.send_header('X-Content-Type-Options','nosniff');super().end_headers()
    server=http.server.ThreadingHTTPServer(('127.0.0.1',args.http_port),functools.partial(Handler,directory=str(root)))
    print(f'PRIVATE LOOPBACK PREVIEW http://127.0.0.1:{args.http_port} — {root}',flush=True)
    if args.solo:
        try:server.serve_forever()
        finally:server.server_close()
    else:
        from websockets.asyncio.server import serve
        threading.Thread(target=server.serve_forever,daemon=True).start()
        async def run():
            relay=Relay()
            async with serve(relay.handle,'127.0.0.1',args.relay_port,max_size=2048,max_queue=8,ping_interval=10,ping_timeout=10,origins=[f'http://127.0.0.1:{args.http_port}',f'http://localhost:{args.http_port}',None]):
                print(f'DISPLAY-ONLY RELAY ws://127.0.0.1:{args.relay_port} — no production protocol',flush=True)
                await asyncio.Future()
        try:asyncio.run(run())
        finally:server.shutdown();server.server_close()
if __name__=='__main__':main()
