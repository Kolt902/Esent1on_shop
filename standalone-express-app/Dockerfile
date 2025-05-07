FROM node:20-slim

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем код приложения
COPY . .

# Устанавливаем порт
ENV PORT=8080
ENV NODE_ENV=production

# Проверка здоровья
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT}/healthcheck || exit 1

# Запускаем приложение
CMD ["node", "app.js"]