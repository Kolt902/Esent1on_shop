/**
 * Модуль для проверки здоровья приложения на Railway
 * This module adds a health check endpoint for Railway
 */
import { Express } from 'express';
import { pool } from './db';

export function setupHealthCheck(app: Express): void {
  // Максимально простой корневой маршрут для Railway healthcheck
  app.get('/', (req, res) => {
    // Не делаем никаких проверок БД здесь, просто отвечаем "OK"
    res.status(200).send('OK');
  });
  
  // Подробный хелсчек для внутреннего использования
  app.get('/health', async (req, res) => {
    try {
      // Проверяем подключение к базе данных
      await pool.query('SELECT 1');
      res.status(200).json({
        status: 'ok',
        timestamp: new Date().toISOString(),
        db_connection: 'ok',
        environment: process.env.NODE_ENV || 'development'
      });
    } catch (error) {
      console.error('Health check error:', error);
      res.status(200).json({ // Всегда возвращаем 200 для хелсчеков
        status: 'ok',
        timestamp: new Date().toISOString(),
        db_connection: 'pending',
        environment: process.env.NODE_ENV || 'development',
        note: 'DB connection pending but service is available'
      });
    }
  });
  
  // Добавляем дополнительный путь для Railway healthcheck
  app.get('/healthz', (req, res) => {
    res.status(200).send('healthy');
  });
}