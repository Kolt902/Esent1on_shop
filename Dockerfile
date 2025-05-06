FROM node:20-alpine

WORKDIR /app

# Установка зависимостей (включая dev-зависимости для сборки)
COPY package*.json ./
RUN npm ci

# Копирование исходного кода
COPY . .

# Сборка приложения
RUN npm run build

# Очистка dev-зависимостей после сборки для уменьшения размера образа
RUN npm ci --omit=dev --prefer-offline

# Настройка переменных среды
ENV NODE_ENV=production
ENV PORT=8080

# Открытие порта
EXPOSE 8080

# Запуск приложения
CMD ["node", "dist/index.js"]