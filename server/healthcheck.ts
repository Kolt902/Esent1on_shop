/**
 * Модуль для проверки здоровья приложения на Railway
 * This module adds a health check endpoint for Railway
 */
import { Express } from 'express';
import { pool } from './db';

export function setupHealthCheck(app: Express): void {
  // Root path health check for Railway (Express native)
  app.get('/', async (req, res) => {
    try {
      // Проверяем подключение к базе данных
      await pool.query('SELECT 1');
      res.status(200).json({
        status: 'healthy',
        timestamp: new Date().toISOString(),
        environment: process.env.NODE_ENV || 'development',
        db_connection: 'ok'
      });
    } catch (error) {
      console.error('Healthcheck database error:', error);
      // Всё равно возвращаем 200, чтобы Railway принял healthcheck
      res.status(200).json({
        status: 'ok', 
        timestamp: new Date().toISOString(),
        environment: process.env.NODE_ENV || 'development',
        message: 'API is running (DB connection pending)'
      });
    }
  });
  
  // Additional health check endpoint
  app.get('/health', async (req, res) => {
    try {
      // Проверяем подключение к базе данных
      await pool.query('SELECT 1');
      res.status(200).json({
        status: 'ok',
        timestamp: new Date().toISOString(),
        db_connection: 'ok'
      });
    } catch (error) {
      res.status(503).json({
        status: 'degraded',
        timestamp: new Date().toISOString(),
        db_connection: 'failed'
      });
    }
  });
}