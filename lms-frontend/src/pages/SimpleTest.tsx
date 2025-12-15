import React from 'react';

const SimpleTest: React.FC = () => {
  console.log('SimpleTest component is rendering!');
  
  return (
    <div style={{
      padding: '40px',
      textAlign: 'center',
      backgroundColor: '#f0f8ff',
      minHeight: '100vh',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1 style={{ color: '#2c3e50', fontSize: '2.5rem', marginBottom: '20px' }}>🎉 SUCCESS!</h1>
      <p style={{ fontSize: '1.2rem', color: '#34495e', marginBottom: '30px' }}>
        This page is working perfectly! The routing system is functional.
      </p>
      <div style={{
        backgroundColor: '#e8f5e8',
        padding: '20px',
        borderRadius: '10px',
        border: '2px solid #27ae60',
        maxWidth: '600px',
        margin: '0 auto'
      }}>
        <h3 style={{ color: '#27ae60', marginBottom: '15px' }}>✅ What this proves:</h3>
        <ul style={{ textAlign: 'left', color: '#2c3e50' }}>
          <li>React Router is working correctly</li>
          <li>The development server is serving routes properly</li>
          <li>Your browser can access the application</li>
          <li>The issue might be specific to certain routes or components</li>
        </ul>
      </div>
      
      <div style={{ marginTop: '30px' }}>
        <p style={{ fontSize: '1rem', color: '#7f8c8d' }}>
          Current URL: <strong>{window.location.href}</strong>
        </p>
        <p style={{ fontSize: '1rem', color: '#7f8c8d' }}>
          Timestamp: <strong>{new Date().toLocaleString()}</strong>
        </p>
      </div>
    </div>
  );
};

export default SimpleTest;