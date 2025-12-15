/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          navy: '#1e3a8a',
          cyan: '#06b6d4',
        },
        brand: {
          navy: '#1e3a8a',
          cyan: '#06b6d4',
          white: '#ffffff',
        }
      },
      fontFamily: {
        'heading': ['Poppins', 'sans-serif'],
        'body': ['Inter', 'sans-serif'],
        'ui': ['DM Sans', 'sans-serif'],
      },
    },
  },
  plugins: [],
} 