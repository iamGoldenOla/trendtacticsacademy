import React from 'react';
import { useLocation, useNavigate } from 'react-router-dom';

const Diagnostic: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();

  const testRoutes = [
    '/planner',
    '/test-planner',
    '/about',
    '/courses',
    '/dashboard'
  ];

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>🔧 Route Diagnostic Page</h1>
      <div style={{ marginBottom: '20px', padding: '15px', backgroundColor: '#f0f0f0', borderRadius: '5px' }}>
        <h3>Current Location Info:</h3>
        <p><strong>Pathname:</strong> {location.pathname}</p>
        <p><strong>Search:</strong> {location.search}</p>
        <p><strong>Hash:</strong> {location.hash}</p>
        <p><strong>Full URL:</strong> {window.location.href}</p>
        <p><strong>User Agent:</strong> {navigator.userAgent}</p>
      </div>
      
      <div style={{ marginBottom: '20px' }}>
        <h3>Test Navigation:</h3>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '10px' }}>
          {testRoutes.map(route => (
            <button
              key={route}
              onClick={() => navigate(route)}
              style={{
                padding: '10px',
                backgroundColor: '#007bff',
                color: 'white',
                border: 'none',
                borderRadius: '5px',
                cursor: 'pointer'
              }}
            >
              Go to {route}
            </button>
          ))}
        </div>
      </div>

      <div style={{ marginBottom: '20px' }}>
        <h3>Direct Links Test:</h3>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
          {testRoutes.map(route => (
            <a
              key={route}
              href={route}
              style={{
                padding: '10px',
                backgroundColor: '#28a745',
                color: 'white',
                textDecoration: 'none',
                borderRadius: '5px',
                textAlign: 'center'
              }}
            >
              Direct link to {route}
            </a>
          ))}
        </div>
      </div>

      <div style={{ padding: '15px', backgroundColor: '#fff3cd', borderRadius: '5px' }}>
        <h3>⚠️ Troubleshooting Tips:</h3>
        <ul>
          <li>Try hard refresh (Ctrl+F5 or Cmd+Shift+R)</li>
          <li>Clear browser cache and cookies</li>
          <li>Try incognito/private browsing mode</li>
          <li>Check if the issue persists in different browsers</li>
          <li>Ensure you're using the correct port (3000)</li>
        </ul>
      </div>
    </div>
  );
};

export default Diagnostic;