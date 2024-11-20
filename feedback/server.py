# SERVER
import socket

server = socket.socket()
server.bind(('127.0.0.1', 8000))
server.listen()
print('run')
while True:
    conn, addr = server.accept()
    data = conn.recv(1024).decode('utf-8')
    print(data)
