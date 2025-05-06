FROM node:20-alpine

WORKDIR /app

# Установка зависимостей
COPY package*.json ./
RUN npm ci --omit=dev

# Копирование исходного кода
COPY . .

# Сборка приложения
RUN npm run build

# Настройка переменных среды
ENV NODE_ENV=production
ENV PORT=8080

# Открытие порта
EXPOSE 8080

# Запуск приложения
CMD ["node", "dist/index.js"]