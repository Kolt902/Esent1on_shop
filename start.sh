#!/bin/bash
set -e

echo "Starting production server..."

# Позволяем Node.js импортировать модули из shared
export NODE_PATH="./dist"

# Использование значения PORT из окружения или 8080 по умолчанию
export PORT="${PORT:-8080}"

# Проверяем, существует ли скомпилированная версия
if [ ! -d "./dist" ]; then
  echo "Dist directory not found, running build..."
  npm run build
fi

# Запускаем сервер
echo "Starting server from dist/index.js"
NODE_OPTIONS="--experimental-specifier-resolution=node" node dist/index.js