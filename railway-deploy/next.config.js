/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  // Always use server-side rendering for better SEO and performance
  output: 'standalone',
  // Use a custom server.js file in production
  serverRuntimeConfig: {
    PROJECT_ROOT: __dirname,
  },
  // Configure asset handling to match your existing application
  images: {
    domains: [
      'static.nike.com', 
      'assets.adidas.com', 
      'image.goat.com', 
      'cdn-images.farfetch-contents.com'
    ],
  },
  // Configure headers for better security
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
        ],
      },
    ];
  },
};

module.exports = nextConfig;