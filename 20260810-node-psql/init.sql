CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    edad INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nombre, email, edad) VALUES 
    ('Juan Pérez', 'juan@ejemplo.com', 28),
    ('María García', 'maria@ejemplo.com', 32),
    ('Carlos López', 'carlos@ejemplo.com', 24)
ON CONFLICT (email) DO NOTHING;
