FROM node:20-alpine AS build

WORKDIR /app

# Установка зависимостей (включая dev)
COPY package*.json ./
RUN npm ci

# Копирование исходного кода
COPY . .

# Сборка приложения
RUN npm run build

# Вторая стадия - production без dev-зависимостей
FROM node:20-alpine

WORKDIR /app

# Копирование только package.json и lock
COPY package*.json ./

# Установка только production зависимостей
RUN npm ci --omit=dev --production

# Копирование собранных файлов из первой стадии
COPY --from=build /app/dist ./dist
COPY --from=build /app/client/dist ./client/dist
COPY --from=build /app/public ./public
COPY --from=build /app/start.sh ./

# Настройка переменных среды
ENV NODE_ENV=production
ENV PORT=8080

# Открытие порта
EXPOSE 8080

# Сделать скрипт запуска исполняемым
RUN chmod +x ./start.sh

# Запуск приложения
CMD ["./start.sh"]