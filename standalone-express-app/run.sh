#!/bin/sh

# Скрипт для запуска Express-приложения с проверкой базы данных
echo "Starting application..."

# Проверяем подключение к базе данных, если указана переменная DATABASE_URL
if [ -n "$DATABASE_URL" ]; then
  echo "Database URL is set, checking connection..."
  
  # Простая проверка соединения без дополнительных зависимостей
  # Просто выводим сообщение об успехе или ошибке, но в любом случае продолжаем запуск
  node -e "
    const url = process.env.DATABASE_URL;
    console.log('Attempting to connect to database...');
    try {
      const { Pool } = require('pg');
      const pool = new Pool({ connectionString: url });
      pool.query('SELECT 1').then(() => {
        console.log('Database connection successful!');
        pool.end();
      }).catch(err => {
        console.error('Database connection failed:', err.message);
        console.log('Continuing without database...');
      });
    } catch (err) {
      console.error('Error connecting to database:', err.message);
      console.log('Continuing without database...');
    }
  " &
  
  # Не ждем завершения проверки, чтобы не блокировать запуск приложения
else
  echo "No DATABASE_URL provided, skipping database check."
fi

# Запускаем приложение
echo "Starting Express server..."
exec node app.js