FROM node:20-alpine AS build

WORKDIR /app

# Установка зависимостей (включая dev)
COPY package*.json ./
RUN npm ci

# Копирование всего кода
COPY . .

# Показать структуру проекта для диагностики
RUN find . -type d | sort

# Сборка приложения
RUN npm run build

# Проверка созданных файлов после сборки
RUN ls -la dist || echo "Директория dist не создана"
RUN ls -la client/dist || echo "Директория client/dist не создана"

# Вторая стадия - production без dev-зависимостей
FROM node:20-alpine

WORKDIR /app

# Копирование package.json
COPY package*.json ./

# Установка только production зависимостей
RUN npm ci --omit=dev

# Копирование собранных файлов и статичных ресурсов
COPY --from=build /app/dist ./dist
COPY --from=build /app/client ./client
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