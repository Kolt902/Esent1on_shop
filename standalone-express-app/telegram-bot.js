/**
 * Модуль для работы с Telegram Bot API
 * Упрощенная версия для работы на Railway
 */

const https = require('https');

class TelegramBot {
  constructor(token) {
    this.token = token;
    this.apiUrl = `https://api.telegram.org/bot${token}`;
  }

  /**
   * Выполняет запрос к Telegram Bot API
   */
  async apiRequest(method, params = {}) {
    return new Promise((resolve, reject) => {
      // Преобразуем параметры в JSON
      const data = JSON.stringify(params);
      
      // Настройки запроса
      const options = {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': data.length
        }
      };
      
      // Создаем запрос
      const req = https.request(`${this.apiUrl}/${method}`, options, (res) => {
        let responseData = '';
        
        // Собираем данные ответа
        res.on('data', (chunk) => {
          responseData += chunk;
        });
        
        // Обрабатываем завершение запроса
        res.on('end', () => {
          try {
            const result = JSON.parse(responseData);
            resolve(result);
          } catch (err) {
            reject(new Error(`Failed to parse Telegram API response: ${err.message}`));
          }
        });
      });
      
      // Обрабатываем ошибки запроса
      req.on('error', (err) => {
        reject(new Error(`Telegram API request failed: ${err.message}`));
      });
      
      // Отправляем данные
      req.write(data);
      req.end();
    });
  }

  /**
   * Устанавливает меню бота
   */
  async setMyCommands(commands) {
    try {
      const result = await this.apiRequest('setMyCommands', { commands });
      console.log('Bot commands set successfully', result);
      return result;
    } catch (error) {
      console.error('Failed to set bot commands:', error);
      return { ok: false, error: error.message };
    }
  }

  /**
   * Устанавливает WebHook
   */
  async setWebhook(url, options = {}) {
    try {
      const params = {
        url,
        ...options
      };
      const result = await this.apiRequest('setWebhook', params);
      console.log(`Webhook set to ${url}`, result);
      return result;
    } catch (error) {
      console.error('Failed to set webhook:', error);
      return { ok: false, error: error.message };
    }
  }

  /**
   * Удаляет WebHook
   */
  async deleteWebhook(dropPendingUpdates = true) {
    try {
      const result = await this.apiRequest('deleteWebhook', { drop_pending_updates: dropPendingUpdates });
      console.log('Webhook deleted', result);
      return result;
    } catch (error) {
      console.error('Failed to delete webhook:', error);
      return { ok: false, error: error.message };
    }
  }

  /**
   * Получает информацию о WebHook
   */
  async getWebhookInfo() {
    try {
      return await this.apiRequest('getWebhookInfo');
    } catch (error) {
      console.error('Failed to get webhook info:', error);
      return { ok: false, error: error.message };
    }
  }

  /**
   * Отправляет сообщение пользователю
   */
  async sendMessage(chatId, text, options = {}) {
    try {
      const params = {
        chat_id: chatId,
        text,
        parse_mode: 'HTML',
        ...options
      };
      return await this.apiRequest('sendMessage', params);
    } catch (error) {
      console.error('Failed to send message:', error);
      return { ok: false, error: error.message };
    }
  }
}

module.exports = TelegramBot;