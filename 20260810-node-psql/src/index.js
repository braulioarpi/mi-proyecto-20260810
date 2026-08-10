const express = require('express');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 3000;

// Configurar conexión a PostgreSQL
const pool = new Pool({
    host: process.env.DB_HOST || 'postgres',
    user: process.env.DB_USER || 'admin',
    password: process.env.DB_PASSWORD || 'admin123',
    database: process.env.DB_NAME || 'mi_app',
    port: process.env.DB_PORT || 5432,
});

app.use(express.json());
app.use(express.static('public'));

// Ruta principal
app.get('/', (req, res) => {
    res.send(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Node.js + PostgreSQL</title>
            <style>
                body { font-family: Arial; max-width: 900px; margin: 0 auto; padding: 20px; background: #f5f5f5; }
                .container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
                h1 { color: #336699; }
                .user { background: #f0f8ff; padding: 10px; margin: 5px 0; border-radius: 5px; border-left: 4px solid #336699; }
                form { background: #f9f9f9; padding: 15px; border-radius: 8px; }
                input, button { padding: 10px; margin: 5px; border: 1px solid #ddd; border-radius: 4px; }
                button { background: #336699; color: white; border: none; cursor: pointer; }
                button:hover { background: #254a6b; }
                .success { color: green; }
                .info { background: #e3f2fd; padding: 10px; border-radius: 5px; margin: 10px 0; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>🚀 Proyecto Docker 20260810</h1>
                <h2>Node.js + PostgreSQL</h2>
                <div class="info">
                    <strong>📦 Estado:</strong> Conectado a PostgreSQL ✅
                </div>
                
                <h3>📋 Lista de Usuarios</h3>
                <div id="usuarios">
                    <p>Cargando...</p>
                </div>
                
                <h3>➕ Agregar Usuario</h3>
                <form id="formUsuario">
                    <input type="text" id="nombre" placeholder="Nombre" required>
                    <input type="email" id="email" placeholder="Email" required>
                    <input type="number" id="edad" placeholder="Edad">
                    <button type="submit">Guardar</button>
                </form>
                <div id="mensaje" style="margin-top: 10px;"></div>
            </div>

            <script>
                async function cargarUsuarios() {
                    try {
                        const res = await fetch('/api/usuarios');
                        const usuarios = await res.json();
                        if (usuarios.length === 0) {
                            document.getElementById('usuarios').innerHTML = '<p>No hay usuarios registrados</p>';
                        } else {
                            document.getElementById('usuarios').innerHTML = usuarios.map(u => 
                                \`<div class="user">👤 <strong>\${u.nombre}</strong> - \${u.email} (Edad: \${u.edad})</div>\`
                            ).join('');
                        }
                    } catch (error) {
                        document.getElementById('usuarios').innerHTML = '<p style="color:red;">Error al cargar usuarios</p>';
                    }
                }
                cargarUsuarios();

                document.getElementById('formUsuario').onsubmit = async (e) => {
                    e.preventDefault();
                    const data = {
                        nombre: document.getElementById('nombre').value,
                        email: document.getElementById('email').value,
                        edad: parseInt(document.getElementById('edad').value) || null
                    };
                    try {
                        const res = await fetch('/api/usuarios', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify(data)
                        });
                        if (res.ok) {
                            document.getElementById('mensaje').innerHTML = '<p class="success">✅ Usuario creado exitosamente</p>';
                            cargarUsuarios();
                            e.target.reset();
                        } else {
                            document.getElementById('mensaje').innerHTML = '<p style="color:red;">❌ Error al crear usuario</p>';
                        }
                    } catch (error) {
                        document.getElementById('mensaje').innerHTML = '<p style="color:red;">❌ Error de conexión</p>';
                    }
                };
            </script>
        </body>
        </html>
    `);
});

// API: Obtener usuarios
app.get('/api/usuarios', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM usuarios ORDER BY id');
        res.json(result.rows);
    } catch (err) {
        console.error('Error en GET /api/usuarios:', err);
        res.status(500).json({ error: 'Error al obtener usuarios' });
    }
});

// API: Crear usuario
app.post('/api/usuarios', async (req, res) => {
    const { nombre, email, edad } = req.body;
    try {
        const result = await pool.query(
            'INSERT INTO usuarios (nombre, email, edad) VALUES ($1, $2, $3) RETURNING *',
            [nombre, email, edad]
        );
        res.json(result.rows[0]);
    } catch (err) {
        console.error('Error en POST /api/usuarios:', err);
        res.status(500).json({ error: 'Error al crear usuario' });
    }
});

// Iniciar servidor
app.listen(PORT, () => {
    console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
    console.log(`📦 Conectado a PostgreSQL en ${process.env.DB_HOST || 'postgres'}`);
});

