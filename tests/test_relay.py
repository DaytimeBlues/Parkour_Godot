import asyncio,copy,json,pathlib,sys,unittest
sys.path.insert(0,str(pathlib.Path(__file__).resolve().parents[1]/'tools'))
from relay import Relay,validate_state
STATE={'position':[-5,2.055,8],'yaw':0,'grounded':True,'gliding':False,'speed':0}
class Validation(unittest.TestCase):
 def test_valid_copy(self):
  value=validate_state(STATE);self.assertEqual(value,STATE);self.assertIsNot(value['position'],STATE['position'])
 def test_reject_nonfinite(self):
  for invalid in [float('nan'),float('inf'),True,'1',101]:
   with self.subTest(invalid=invalid):
    value=copy.deepcopy(STATE);value['position'][0]=invalid
    with self.assertRaises(ValueError):validate_state(value)
 def test_reject_keys_and_types(self):
  for value in [{},dict(STATE,teacher=True),dict(STATE,speed=-1),dict(STATE,speed=26),dict(STATE,grounded=1),dict(STATE,position=[0,0])]:
   with self.assertRaises(ValueError):validate_state(value)
class FakeSocket:
 def __init__(self,messages):self.messages=messages;self.sent=[];self.closed=None
 async def recv(self):return self.messages.pop(0)
 async def send(self,value):self.sent.append(json.loads(value))
 async def close(self,*args):self.closed=args
 def __aiter__(self):return self
 async def __anext__(self):
  if not self.messages:raise StopAsyncIteration
  return self.messages.pop(0)
class Flow(unittest.IsolatedAsyncioTestCase):
 async def test_join_state_cleanup(self):
  relay=Relay();ws=FakeSocket([json.dumps({'type':'hello','version':1,'room':'FOREST'}),json.dumps({'type':'state','state':STATE})]);await relay.handle(ws)
  self.assertEqual(ws.sent[0]['type'],'welcome');self.assertEqual(ws.sent[1]['peers'][0]['state'],STATE);self.assertEqual(relay.rooms,{})
 async def test_reject_production_and_bad_room(self):
  for hello in [{'type':'join','seatToken':'no'}, {'type':'hello','version':4,'room':'FOREST'},{'type':'hello','version':1,'room':'../private'}]:
   relay=Relay();ws=FakeSocket([json.dumps(hello)]);await relay.handle(ws);self.assertEqual(ws.closed[0],1008);self.assertEqual(relay.rooms,{})
 async def test_room_cap(self):
  from relay import Room
  relay=Relay();relay.rooms['FOREST']=Room(peers={str(i):FakeSocket([]) for i in range(8)})
  ws=FakeSocket([json.dumps({'type':'hello','version':1,'room':'FOREST'})]);await relay.handle(ws);self.assertEqual(ws.closed[0],1008);self.assertEqual(len(relay.rooms['FOREST'].peers),8)
if __name__=='__main__':unittest.main()
