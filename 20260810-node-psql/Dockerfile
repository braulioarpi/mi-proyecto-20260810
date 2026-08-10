FROM node:18-alpine

# Crear directorio de trabajo
WORKDIR /app

# Copiar package.json primero (mejor para caché)
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código
COPY . .

# Exponer puerto
EXPOSE 3000

# Comando para producción (será sobrescrito en desarrollo)
CMD ["node", "src/index.js"]
