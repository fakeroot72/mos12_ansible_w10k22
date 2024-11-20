# CLIENT
import socket
sock = socket.socket()
sock.connect(('127.0.0.1', 8000))
sock.send('Text'.encode('utf-8'))
sock.close()
