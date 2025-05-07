FROM node:18-alpine

WORKDIR /app

# Копируем только необходимые файлы для установки зависимостей
COPY package*.json ./

# Устанавливаем только production зависимости
RUN npm ci --only=production

# Копируем приложение
COPY ./standalone-express-app/app.js .
COPY ./standalone-express-app/run.sh .
COPY ./standalone-express-app/package.json .

# Проверяем наличие клиентских файлов и копируем их если они есть
COPY ./client-build ./client-build

# Создаем пользователя для безопасности
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chmod +x ./run.sh && \
    chown -R nodejs:nodejs /app

# Переключаемся на непривилегированного пользователя
USER nodejs

# Используем порт из переменной окружения Railway или 3000 по умолчанию
ENV PORT=3000
EXPOSE $PORT

# Запускаем с помощью скрипта, который проверяет соединение с базой данных
CMD ["./run.sh"]