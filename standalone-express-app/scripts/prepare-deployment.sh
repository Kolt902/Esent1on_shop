#!/bin/bash

# Script to prepare the deployment files for Railway
# Copies important files from the main project to the client-build directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
APP_DIR="${PROJECT_ROOT}/standalone-express-app"
CLIENT_BUILD_DIR="${PROJECT_ROOT}/client-build"

echo "Preparing deployment for Railway..."
echo "Project root: ${PROJECT_ROOT}"
echo "App dir: ${APP_DIR}"

# Ensure client-build directory exists
mkdir -p "${CLIENT_BUILD_DIR}"

# Check if we have a Vite build available
VITE_DIST="${PROJECT_ROOT}/dist"
if [ -d "$VITE_DIST" ]; then
  echo "Found Vite build at ${VITE_DIST}, copying to client-build..."
  cp -r "${VITE_DIST}/"* "${CLIENT_BUILD_DIR}/"
else
  echo "No Vite build found, creating a simple index.html..."
  cat > "${CLIENT_BUILD_DIR}/index.html" << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Esention Store</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      text-align: center;
    }
    .container {
      max-width: 800px;
      margin: 0 auto;
      background-color: #f8f9fa;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    h1 {
      color: #28a745;
      margin-bottom: 20px;
    }
    p {
      font-size: 18px;
      line-height: 1.6;
      margin-bottom: 15px;
    }
    .endpoint {
      display: inline-block;
      margin: 5px;
      padding: 8px 15px;
      background-color: #007bff;
      color: white;
      border-radius: 5px;
      text-decoration: none;
    }
    .status {
      margin-top: 30px;
      font-size: 16px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>✅ Esention Store - Сервер запущен!</h1>
    <p>
      Этот сервер настроен для работы с Telegram Mini App.
      Он предоставляет API для взаимодействия с приложением.
    </p>
    <p>Доступные API-эндпоинты:</p>
    <div>
      <a href="/api/categories" class="endpoint">Categories</a>
      <a href="/api/brands" class="endpoint">Brands</a>
      <a href="/api/styles" class="endpoint">Styles</a>
      <a href="/api/products" class="endpoint">Products</a>
      <a href="/healthcheck" class="endpoint">Health Check</a>
    </div>
    <div class="status">
      <p>Статус: <strong>Онлайн</strong></p>
      <p id="time">Время: <strong>-</strong></p>
    </div>
  </div>
  <script>
    // Обновление времени
    function updateTime() {
      document.getElementById('time').innerHTML = 'Время: <strong>' + new Date().toLocaleString() + '</strong>';
    }
    updateTime();
    setInterval(updateTime, 1000);
  </script>
</body>
</html>
EOL
fi

echo "Deployment preparation completed successfully!"