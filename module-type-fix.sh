#!/bin/bash

# Этот скрипт автоматически выполнится в Railway на этапе сборки
# Он удаляет строку "type": "module" из package.json для исправления проблемы с CommonJS

echo "Removing 'type: module' from package.json to fix module system issues..."

# Создаем временный файл с новым содержимым, исключая строку с type: module
grep -v '"type": "module"' package.json > package.json.tmp

# Проверяем, что временный файл был создан успешно
if [ -s package.json.tmp ]; then
    # Заменяем оригинальный файл временным
    mv package.json.tmp package.json
    echo "Successfully removed 'type: module' from package.json"
else
    echo "ERROR: Failed to process package.json"
    exit 1
fi

echo "Module type fix completed successfully"