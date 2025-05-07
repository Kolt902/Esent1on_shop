FROM node:20-slim

WORKDIR /app

# Копируем файлы, необходимые для установки зависимостей
COPY package*.json ./
COPY module-type-fix.sh ./
COPY docker-server.js ./

# Делаем скрипт исполняемым
RUN chmod +x module-type-fix.sh

# Запускаем скрипт для удаления "type": "module" из package.json
RUN ./module-type-fix.sh

# Устанавливаем зависимости
RUN npm ci

# Копируем все остальные файлы проекта
COPY . .

# Выполняем сборку клиентской части
RUN npx vite build

# Устанавливаем переменные окружения
ENV PORT=8080
ENV NODE_ENV=production
ENV STATIC_DIR=dist

# Добавляем метку здоровья для Railway
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT}/healthcheck || exit 1

# Запускаем сервер
CMD ["node", "docker-server.js"]