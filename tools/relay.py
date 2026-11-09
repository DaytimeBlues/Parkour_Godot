"""Local-only, display-only multiplayer experiment. No production Skybound protocol.
Never run on a public interface without a separate security/hosting review.
"""
from __future__ import annotations
import asyncio,json,math,re,secrets,time
from dataclasses import dataclass,field
from typing import Any
VERSION=1
MAX_PEERS=8
MAX_BYTES=2048
ROOM=re.compile(r'^[A-Z][A-Z0-9_]{0,11}$')
@dataclass
class Room:
    peers:dict[str,Any]=field(default_factory=dict)
    states:dict[str,dict]=field(default_factory=dict)

def validate_state(value):
    if not isinstance(value,dict) or set(value)!={'position','yaw','grounded','gliding','speed'}:raise ValueError('invalid state keys')
    p=value['position']
    if not isinstance(p,list) or len(p)!=3:raise ValueError('invalid position')
    if any(type(x) not in (int,float) or not math.isfinite(x) or abs(x)>100 for x in p):raise ValueError('position out of bounds')
    for key,limit in [('yaw',100000),('speed',25)]:
        x=value[key]
        if type(x) not in (int,float) or not math.isfinite(x) or abs(x)>limit:raise ValueError('invalid '+key)
    if value['speed']<0 or type(value['grounded']) is not bool or type(value['gliding']) is not bool:raise ValueError('invalid pose')
    return {**value,'position':list(p)}

class Relay:
    def __init__(self):self.rooms={};self.last_sent=0
    async def handle(self,ws):
        code=None;identity=None
        try:
            raw=await asyncio.wait_for(ws.recv(),timeout=5)
            hello=json.loads(raw)
            if set(hello)!={'type','version','room'} or hello['type']!='hello' or hello['version']!=VERSION or not ROOM.fullmatch(hello['room']):raise ValueError('invalid hello')
            code=hello['room'];room=self.rooms.setdefault(code,Room())
            if len(room.peers)>=MAX_PEERS:raise ValueError('room full (8 maximum)')
            identity=secrets.token_hex(4)
            room.peers[identity]=ws
            await ws.send(json.dumps({'type':'welcome','version':VERSION,'id':identity,'room':code}))
            last=0.0
            async for raw in ws:
                if not isinstance(raw,str) or len(raw.encode())>MAX_BYTES:raise ValueError('packet too large')
                message=json.loads(raw)
                if set(message)!={'type','state'} or message['type']!='state':raise ValueError('invalid message')
                state=validate_state(message['state'])
                now=time.monotonic()
                if now-last<0.025:continue
                last=now
                room.states[identity]=state
                await self.broadcast(room)
        except (ValueError,TypeError,KeyError,asyncio.TimeoutError,json.JSONDecodeError):
            try:await ws.send(json.dumps({'type':'error','message':'Invalid prototype message or room capacity reached.'}));await ws.close(1008,'Invalid prototype message')
            except Exception:pass
        finally:
            if code in self.rooms and identity:
                room=self.rooms[code];room.peers.pop(identity,None);room.states.pop(identity,None)
                if room.peers:await self.broadcast(room)
                else:self.rooms.pop(code,None)
    async def broadcast(self,room):
        packet=json.dumps({'type':'snapshot','peers':[{'id':key,'state':state} for key,state in room.states.items()]},separators=(',',':'))
        await asyncio.gather(*(peer.send(packet) for peer in tuple(room.peers.values())),return_exceptions=True)
