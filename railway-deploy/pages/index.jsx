import React, { useEffect, useState } from 'react';
import Head from 'next/head';

// Стили добавляем инлайн, чтобы соответствовать оригинальному дизайну
const styles = {
  container: {
    fontFamily: 'Arial, sans-serif',
    maxWidth: '1200px',
    margin: '0 auto',
    padding: '20px',
    color: '#333',
  },
  header: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '20px',
  },
  logo: {
    fontSize: '24px',
    fontWeight: 'bold',
  },
  nav: {
    display: 'flex',
    gap: '15px',
  },
  navItem: {
    cursor: 'pointer',
    padding: '5px 10px',
    borderRadius: '5px',
    transition: 'background-color 0.3s',
  },
  banner: {
    backgroundColor: '#f8f9fa',
    borderRadius: '10px',
    padding: '40px 20px',
    marginBottom: '30px',
    textAlign: 'center',
  },
  bannerTitle: {
    fontSize: '32px',
    marginBottom: '15px',
  },
  bannerText: {
    fontSize: '18px',
    marginBottom: '20px',
  },
  button: {
    backgroundColor: '#007bff',
    color: 'white',
    border: 'none',
    padding: '10px 20px',
    borderRadius: '5px',
    cursor: 'pointer',
    fontSize: '16px',
    transition: 'background-color 0.3s',
  },
  categoriesSection: {
    marginBottom: '30px',
  },
  sectionTitle: {
    fontSize: '24px',
    marginBottom: '15px',
  },
  categoryGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fill, minmax(160px, 1fr))',
    gap: '15px',
  },
  categoryCard: {
    backgroundColor: '#f8f9fa',
    borderRadius: '10px',
    padding: '15px',
    textAlign: 'center',
    cursor: 'pointer',
    transition: 'transform 0.3s',
  },
  productGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))',
    gap: '20px',
    marginBottom: '30px',
  },
  productCard: {
    border: '1px solid #eee',
    borderRadius: '10px',
    overflow: 'hidden',
    transition: 'transform 0.3s, box-shadow 0.3s',
  },
  productImage: {
    width: '100%',
    height: '200px',
    objectFit: 'cover',
  },
  productInfo: {
    padding: '15px',
  },
  productTitle: {
    fontSize: '18px',
    fontWeight: 'bold',
    marginBottom: '5px',
  },
  productBrand: {
    color: '#666',
    marginBottom: '5px',
  },
  productPrice: {
    fontSize: '18px',
    fontWeight: 'bold',
  },
  statusContainer: {
    textAlign: 'center',
    padding: '40px',
    borderRadius: '10px',
    backgroundColor: '#f8f9fa',
    marginTop: '30px'
  },
  statusSuccess: {
    color: '#28a745',
    fontSize: '24px',
    marginBottom: '15px',
  },
  statusInfo: {
    fontSize: '18px',
    marginBottom: '10px',
  },
  apiLink: {
    display: 'inline-block',
    margin: '5px',
    padding: '8px 15px',
    backgroundColor: '#007bff',
    color: 'white',
    borderRadius: '5px',
    textDecoration: 'none',
  }
};

export default function Home() {
  const [status, setStatus] = useState('loading');
  const [apiEndpoints, setApiEndpoints] = useState([
    { name: 'Categories', url: '/api/categories' },
    { name: 'Brands', url: '/api/brands' },
    { name: 'Styles', url: '/api/styles' },
    { name: 'Products', url: '/api/products' },
    { name: 'Health Check', url: '/healthcheck' }
  ]);
  
  useEffect(() => {
    // Проверяем статус сервера
    fetch('/healthcheck')
      .then(response => {
        if (response.ok) return response.json();
        throw new Error('Server health check failed');
      })
      .then(data => {
        setStatus('online');
      })
      .catch(error => {
        console.error('Health check error:', error);
        setStatus('error');
      });
  }, []);

  return (
    <div style={styles.container}>
      <Head>
        <title>Esention Store</title>
        <meta name="description" content="Esention Store - Telegram Mini App" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <header style={styles.header}>
        <div style={styles.logo}>Esention Store</div>
      </header>

      <div style={styles.statusContainer}>
        <h1 style={styles.statusSuccess}>
          {status === 'online' 
            ? '✅ Сервер успешно запущен!' 
            : status === 'loading' 
              ? '⏳ Проверка состояния сервера...' 
              : '❌ Ошибка проверки сервера'}
        </h1>
        
        <p style={styles.statusInfo}>
          Этот сервер настроен для работы с вашим Telegram Mini App. 
          Он предоставляет необходимые API для взаимодействия с приложением.
        </p>
        
        <p style={styles.statusInfo}>
          Доступные API-эндпоинты:
        </p>
        
        <div>
          {apiEndpoints.map((endpoint, index) => (
            <a 
              key={index} 
              href={endpoint.url} 
              target="_blank" 
              rel="noopener noreferrer"
              style={styles.apiLink}
            >
              {endpoint.name}
            </a>
          ))}
        </div>
        
        <div style={{marginTop: '30px'}}>
          <p style={styles.statusInfo}>
            Статус: <strong>{status === 'online' ? 'Онлайн' : status === 'loading' ? 'Загрузка...' : 'Ошибка'}</strong>
          </p>
          <p style={styles.statusInfo}>
            Время: <strong>{new Date().toLocaleString()}</strong>
          </p>
        </div>
      </div>
    </div>
  );
}