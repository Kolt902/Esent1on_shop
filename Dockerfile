FROM node:20-slim

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci

# Копируем все файлы проекта в рабочую директорию
COPY . .

# Собираем клиентскую часть приложения
RUN npx vite build

# Открываем порт, на котором будет работать приложение
EXPOSE 8080

# Определяем переменные окружения для production
ENV NODE_ENV=production \
    PORT=8080

# Запускаем приложение
CMD ["node", "index.cjs"]