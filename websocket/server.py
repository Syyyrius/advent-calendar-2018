import logging
from websocket_server import WebsocketServer

def new_client(client, server):
	server.send_message(client, "Hey all, a new client has joined us")

def message(client, server, message):
        if message == "XMAS2018":
            success = open("./success", "rb").read()
            server.send_message(client, success)
        else:
            server.send_message(client, "Oh oh you didn´t said the magic word XMAS2018")

def client_left(client, server):
	print("Client(%d) disconnected" % client['id'])

server = WebsocketServer(15, host='0.0.0.0', loglevel=logging.INFO)
server.set_fn_new_client(new_client)
server.set_fn_client_left(client_left)
server.set_fn_message_received(message)
server.run_forever()
