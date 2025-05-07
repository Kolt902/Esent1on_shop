/**
 * Custom Express server for Next.js
 * This server will serve the built Next.js app and provide API endpoints
 */

const express = require('express');
const next = require('next');
const path = require('path');
const fs = require('fs');

const dev = process.env.NODE_ENV !== 'production';
const nextApp = next({ dev });
const handle = nextApp.getRequestHandler();

const PORT = process.env.PORT || 3000;

// Tracking server startup time
const START_TIME = new Date();

// API stub data
const API_DATA = {
  categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'],
  brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'],
  styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'],
  products: []
};

// Initialize the Next.js app and then start the Express server
nextApp.prepare().then(() => {
  const app = express();

  // Logging middleware
  app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next();
  });

  // CORS headers for Telegram
  app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    
    if (req.method === 'OPTIONS') {
      return res.sendStatus(204);
    }
    next();
  });

  // Health check endpoint for Railway
  app.get('/healthcheck', (req, res) => {
    res.json({
      status: 'ok',
      uptime: Math.floor((new Date() - START_TIME) / 1000),
      environment: process.env.NODE_ENV || 'development'
    });
  });

  // API endpoints
  app.get('/api/categories', (req, res) => {
    res.json({ categories: API_DATA.categories });
  });

  app.get('/api/brands', (req, res) => {
    res.json({ brands: API_DATA.brands });
  });

  app.get('/api/styles', (req, res) => {
    res.json({ styles: API_DATA.styles });
  });

  app.get('/api/products', (req, res) => {
    res.json({ products: API_DATA.products });
  });

  app.get('/api/admin/check', (req, res) => {
    res.json({ isAdmin: false });
  });

  // Let Next.js handle all other routes
  app.all('*', (req, res) => {
    return handle(req, res);
  });

  // Error handling middleware
  app.use((err, req, res, next) => {
    console.error(`Error: ${err.message}`);
    console.error(err.stack);
    res.status(500).json({
      error: 'Internal Server Error',
      message: dev ? err.message : 'Something went wrong'
    });
  });

  // Start the server
  app.listen(PORT, '0.0.0.0', (err) => {
    if (err) throw err;
    console.log(`> Server ready on http://localhost:${PORT}`);
  });
}).catch(err => {
  console.error('Error preparing Next.js app:');
  console.error(err);
  process.exit(1);
});