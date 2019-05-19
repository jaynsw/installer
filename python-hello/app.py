from flask import Flask
import socket
app = Flask(__name__)

@app.route('/')
def hello_world():
    s = socket.gethostbyname(socket.gethostname())
    return 'Hello, World! server ip:' + s