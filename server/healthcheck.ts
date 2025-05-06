/**
 * Модуль для проверки здоровья приложения на Railway
 * This module adds a health check endpoint for Railway
 */
import { Express } from 'express';

export function setupHealthCheck(app: Express): void {
  // Root path health check for Railway
  app.get('/', (req, res) => {
    res.status(200).send('Esention Shop API is running');
  });
  
  // Additional health check endpoint
  app.get('/health', (req, res) => {
    res.status(200).json({
      status: 'ok',
      timestamp: new Date().toISOString()
    });
  });
}