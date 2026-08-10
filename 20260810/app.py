from flask import Flask
import socket
import datetime

app = Flask(__name__)

@app.route('/')
def hello():
    hostname = socket.gethostname()
    ahora = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return f"""
    <h1>🚀 Proyecto Docker 20260810</h1>
    <p>Contenedor: {hostname}</p>
    <p>Fecha: {ahora}</p>
    <p style='color:blue;'>✅ Versión 2.0 - Modificado exitosamente</p>
    <hr>
    <p><small>Modificado: 10 de Agosto 2026</small></p>
    """
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

