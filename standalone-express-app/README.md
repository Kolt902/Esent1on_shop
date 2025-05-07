# Esention Store - Standalone Express App для Railway

Эта папка содержит автономную версию сервера для деплоя на Railway. Сервер разработан для максимальной стабильности при работе на Railway.

## Особенности

- Минимальный Express сервер без зависимостей от Vite
- Docker контейнеризация для стабильного запуска
- Автоматическая проверка здоровья сервера
- Обслуживание статических файлов из билда
- Поддержка API запросов от Telegram Mini App

## Подготовка к деплою

1. Запустите скрипт подготовки к деплою:
   ```
   chmod +x standalone-express-app/scripts/prepare-deployment.sh
   ./standalone-express-app/scripts/prepare-deployment.sh
   ```

2. Скопируйте файлы в репозиторий для Railway:
   - `standalone-express-app/app.js`
   - `standalone-express-app/package.json`
   - `standalone-express-app/Dockerfile`
   - `standalone-express-app/run.sh`
   - `standalone-express-app/railway.toml`
   - Папка `client-build` с статическими файлами

3. Загрузите проект на Railway, выбрав Dockerfile как метод деплоя

## API эндпоинты

- `/healthcheck` - проверка здоровья сервера
- `/api/brands` - список брендов
- `/api/categories` - список категорий
- `/api/styles` - список стилей
- `/api/products` - список продуктов

## Переменные окружения

- `PORT` - порт для сервера (по умолчанию 3000)
- `DATABASE_URL` - URL для подключения к базе данных (необязательно)
- `NODE_ENV` - окружение (`production` или `development`)

## Информация о структуре

Сервер построен как полностью автономное приложение, которое не зависит от Vite или других инструментов разработки. Это делает его идеальным для Railway.

Для деплоя мы используем Docker, который обеспечивает стабильную изолированную среду для запуска приложения.