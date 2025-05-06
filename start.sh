#!/bin/bash
set -e

echo "Starting production server..."

# Проверяем, существует ли скомпилированная версия
if [ ! -d "./dist" ]; then
  echo "Dist directory not found, running build..."
  npm run build
fi

# Запускаем сервер
echo "Starting server from dist/index.js"
node dist/index.js