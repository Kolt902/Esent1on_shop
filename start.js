// Простой скрипт-обертка для Railway, чтобы запустить приложение с нужными переменными окружения
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || '8080';

// Явно отображаем окружение
console.log(`Starting in ${process.env.NODE_ENV} mode on port ${process.env.PORT}`);
console.log('DATABASE_URL available:', !!process.env.DATABASE_URL);
console.log('TELEGRAM_BOT_TOKEN available:', !!process.env.TELEGRAM_BOT_TOKEN);

// Запуск сервера
require('./dist/index.js');