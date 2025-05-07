#!/usr/bin/env node

// Вывод информации о текущей директории и файлах при запуске
console.log('===== RAILWAY STARTUP DIAGNOSTICS =====');
console.log('Working directory: ' + process.cwd());
const fs = require('fs');
const path = require('path');

// Выводим список файлов в текущей директории для диагностики
console.log('Files in current directory:');
try {
  const files = fs.readdirSync(process.cwd());
  files.forEach(file => {
    const stats = fs.statSync(path.join(process.cwd(), file));
    if (stats.isDirectory()) {
      console.log(`[DIR] ${file}`);
    } else {
      console.log(`[FILE] ${file} (${stats.size} bytes)`);
    }
  });
} catch (err) {
  console.error('Error listing directory:', err);
}

console.log('Files in /app directory (if exists):');
try {
  if (fs.existsSync('/app')) {
    const files = fs.readdirSync('/app');
    files.forEach(file => {
      const stats = fs.statSync(path.join('/app', file));
      if (stats.isDirectory()) {
        console.log(`[DIR] /app/${file}`);
      } else {
        console.log(`[FILE] /app/${file} (${stats.size} bytes)`);
      }
    });
  } else {
    console.log('/app directory does not exist');
  }
} catch (err) {
  console.error('Error listing /app directory:', err);
}

// Для диагностики показываем переменные окружения (без значений)
console.log('\nAvailable environment variables:');
Object.keys(process.env).forEach(key => {
  // Показываем только имена переменных, без их значений, для безопасности
  console.log(`- ${key}`);
});
console.log('===== END DIAGNOSTICS =====\n');

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
    
    // Пытаемся найти требуемый файл в разных расположениях
    const possiblePaths = [
      './dist/index.js',             // Стандартный путь
      '/app/dist/index.js',          // Путь в Railway контейнере
      '../dist/index.js',            // Относительный альтернативный путь
      '/app/index.js',               // Альтернативный Railway путь
      './index.js'                   // Прямой путь
    ];
    
    let serverStarted = false;
    for (const possiblePath of possiblePaths) {
      try {
        console.log(`Trying to load server from: ${possiblePath}`);
        if (fs.existsSync(possiblePath)) {
          console.log(`Found server module at: ${possiblePath}`);
          require(possiblePath);
          console.log(`Server started from: ${possiblePath}`);
          serverStarted = true;
          break;
        }
      } catch (err) {
        console.error(`Failed to load from ${possiblePath}:`, err.message);
      }
    }
    
    if (!serverStarted) {
      console.error('Could not find server module in any expected location!');
      console.error('Attempting direct import of dist/index.js as fallback...');
      // Последняя попытка - жесткий прямой импорт
      require('./dist/index.js');
    }
  } catch (error) {
    console.error('Ошибка при подключении к базе данных:', error);
    
    // В случае ошибки подключения, запускаем сервер в режиме без базы данных
    console.warn('Запуск сервера в режиме БЕЗ базы данных. Некоторые функции будут недоступны!');
    
    // Прямой запуск сервера с обработкой ошибок
    try {
      console.log('Пробуем запустить из ./dist/index.js...');
      require('./dist/index.js');
    } catch (err) {
      console.error('Ошибка при загрузке ./dist/index.js:', err);
      try {
        console.log('Пробуем запустить из /app/dist/index.js...');
        require('/app/dist/index.js');
      } catch (err) {
        console.error('Ошибка при загрузке /app/dist/index.js:', err);
        try {
          console.log('Последняя попытка - запуск из /app/index.js...');
          require('/app/index.js');
        } catch (err) {
          console.error('Все попытки запуска сервера завершились неудачей:', err);
          console.error('Критическая ошибка - не удается запустить сервер!');
          process.exit(1);
        }
      }
    }
  }
}

// Запускаем проверку базы данных перед стартом приложения
checkDatabase();