from websocket import create_connection, WebSocketException
import socket

URL = "ws://127.0.0.1:9080"  # or wss:// if using TLS

try:
    ws = create_connection(URL, timeout=5)
except (ConnectionRefusedError, socket.timeout, WebSocketException) as e:
    print("connect error:", repr(e))
else:
    try:
        ws.send("hello from sender")
        try:
            reply = ws.recv()         # optional; will block until a message or close
            print("recv:", reply)
        except Exception as e:
            print("recv error (maybe no reply):", repr(e))
    except Exception as e:
        print("send error:", repr(e))
    finally:
        ws.close()
        print("closed")
