// Простой скрипт-обертка для Railway, чтобы запустить приложение с нужными переменными окружения
process.env.NODE_ENV = 'production';
process.env.PORT = process.env.PORT || '8080';

// Явно отображаем окружение
console.log(`Starting in ${process.env.NODE_ENV} mode on port ${process.env.PORT}`);
console.log('DATABASE_URL available:', !!process.env.DATABASE_URL);
console.log('TELEGRAM_BOT_TOKEN available:', !!process.env.TELEGRAM_BOT_TOKEN);

// Проверяем доступность базы данных перед запуском сервера
const { Pool } = require('@neondatabase/serverless');
const ws = require('ws');

// Функция для проверки подключения к базе данных
async function checkDatabase() {
  try {
    // Настраиваем конфигурацию для Neon
    require('@neondatabase/serverless').neonConfig.webSocketConstructor = ws;
    
    if (!process.env.DATABASE_URL) {
      console.error('DATABASE_URL не задан. Приложению требуется база данных PostgreSQL.');
      process.exit(1);
    }
    
    // Тестовое подключение к базе
    console.log('Проверка подключения к базе данных...');
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    
    const client = await pool.connect();
    console.log('Подключение к базе данных успешно!');
    
    // Проверка существования таблиц
    const tableCheck = await client.query(`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'users'
      );
    `);
    
    if (tableCheck.rows[0].exists) {
      console.log('Таблица users найдена в базе данных.');
    } else {
      console.warn('Внимание: таблица users не найдена в базе данных!');
    }
    
    client.release();
    
    // Запуск основного приложения
    console.log('Запуск основного приложения...');
    require('./dist/index.js');
  } catch (error) {
    console.error('Ошибка при подключении к базе данных:', error);
    
    // В случае ошибки подключения, запускаем сервер в режиме без базы данных
    console.warn('Запуск сервера в режиме БЕЗ базы данных. Некоторые функции будут недоступны!');
    require('./dist/index.js');
  }
}

// Запускаем проверку базы данных перед стартом приложения
checkDatabase();