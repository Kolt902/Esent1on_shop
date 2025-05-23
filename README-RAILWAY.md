# Esention Store - Деплой на Railway

Этот файл содержит инструкции по деплою супер минимального сервера на Railway, который будет работать даже в самых сложных условиях.

## Файлы для деплоя

Для успешного деплоя на Railway вам понадобятся следующие файлы:

1. `index.cjs` - минимальный CommonJS сервер, не использующий внешних модулей
2. `railway.toml` - конфигурация для Railway
3. `Procfile` - инструкция для запуска приложения
4. `package-railway.json` - переименуйте в `package.json` на Railway

## Шаги по деплою на Railway

1. Создайте новый проект на Railway
2. Загрузите следующие файлы:
   - `index.cjs`
   - `railway.toml`
   - `Procfile`
   - Переименуйте `package-railway.json` в `package.json`

3. В настройках проекта на Railway:
   - Убедитесь, что установлены все необходимые переменные окружения
   - Проверьте, что проект настроен на использование Node.js

## Особенности решения

- Сервер использует только встроенные модули Node.js без зависимостей от Express или других фреймворков
- Реализован эндпоинт `/healthcheck`, который Railway использует для проверки работоспособности
- Все API эндпоинты реализованы с поддержкой CORS для работы с Telegram Mini App
- Сервер минимизирован для обеспечения максимальной производительности и стабильности

## Возможные проблемы и их решения

### Если сервер не запускается

1. Проверьте логи на Railway
2. Убедитесь, что файл `index.cjs` правильно загружен
3. Убедитесь, что `Procfile` настроен на запуск `node index.cjs`

### Если API не работает

1. Убедитесь, что API запросы идут на правильный URL (с доменом Railway)
2. Проверьте, что запросы в Telegram Mini App правильно настроены на работу с CORS

## Тестирование локально

Вы можете протестировать сервер локально, запустив:

```bash
node index.cjs
```

Затем проверьте, работает ли API, открыв в браузере:
- http://localhost:3000/healthcheck
- http://localhost:3000/api/categories
- http://localhost:3000/api/brands

## Поддержка Telegram Webhook

Если вы хотите использовать webhook для бота, добавьте в переменные окружения:
- `TELEGRAM_BOT_TOKEN` - токен бота Telegram
- `WEBHOOK_URL` - URL для webhook (обычно это https://ваш-проект.up.railway.app/telegram/webhook)