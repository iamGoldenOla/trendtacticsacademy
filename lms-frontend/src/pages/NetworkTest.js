import React, { useState, useEffect } from "react";
const NetworkTest = () => {
    const [testResults, setTestResults] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    useEffect(() => {
        const runTests = async () => {
            const results = [];
            // Test 1: Basic fetch to same origin
            try {
                const response = await fetch('/');
                results.push({
                    test: 'Home page fetch',
                    status: response.status,
                    success: response.ok,
                    url: response.url
                });
            }
            catch (error) {
                results.push({
                    test: 'Home page fetch',
                    status: 'ERROR',
                    success: false,
                    error: error instanceof Error ? error.message : 'Unknown error'
                });
            }
            // Test 2: Check current location
            results.push({
                test: 'Current location',
                status: 'INFO',
                success: true,
                data: {
                    href: window.location.href,
                    origin: window.location.origin,
                    pathname: window.location.pathname,
                    host: window.location.host,
                    hostname: window.location.hostname,
                    port: window.location.port,
                    protocol: window.location.protocol
                }
            });
            // Test 3: User agent info
            results.push({
                test: 'Browser info',
                status: 'INFO',
                success: true,
                data: {
                    userAgent: navigator.userAgent,
                    platform: navigator.platform,
                    language: navigator.language,
                    cookieEnabled: navigator.cookieEnabled,
                    onLine: navigator.onLine
                }
            });
            // Test 4: Check if React Router is working
            results.push({
                test: 'React Router status',
                status: 'INFO',
                success: true,
                data: {
                    routerWorking: 'This page loaded successfully via React Router',
                    timestamp: new Date().toISOString()
                }
            });
            setTestResults(results);
            setIsLoading(false);
        };
        runTests();
    }, []);
    const testDirectNavigation = () => {
        const routes = ['/planner', '/diagnostic', '/simple-test', '/about'];
        routes.forEach((route, index) => {
            setTimeout(() => {
                window.open(route, '_blank');
            }, index * 1000);
        });
    };
    if (isLoading) {
        return (<div style={{ padding: '40px', textAlign: 'center' }}>
        <h1>🔍 Running Network Tests...</h1>
        <p>Please wait while we diagnose the issue.</p>
      </div>);
    }
    return (<div style={{ padding: '20px', fontFamily: 'Arial, sans-serif', maxWidth: '1200px', margin: '0 auto' }}>
      <h1 style={{ color: '#2c3e50', marginBottom: '30px' }}>🔍 Network & Routing Diagnostic</h1>
      
      <div style={{ marginBottom: '30px' }}>
        <button onClick={testDirectNavigation} style={{
            padding: '15px 30px',
            backgroundColor: '#3498db',
            color: 'white',
            border: 'none',
            borderRadius: '5px',
            fontSize: '16px',
            cursor: 'pointer'
        }}>
          🚀 Test All Routes (Opens in New Tabs)
        </button>
      </div>

      <div style={{ display: 'grid', gap: '20px' }}>
        {testResults.map((result, index) => (<div key={index} style={{
                padding: '20px',
                border: '1px solid #ddd',
                borderRadius: '8px',
                backgroundColor: result.success ? '#f8f9fa' : '#fff5f5'
            }}>
            <h3 style={{
                color: result.success ? '#27ae60' : '#e74c3c',
                marginBottom: '10px'
            }}>
              {result.success ? '✅' : '❌'} {result.test}
            </h3>
            
            <p><strong>Status:</strong> {result.status}</p>
            
            {result.url && <p><strong>URL:</strong> {result.url}</p>}
            {result.error && <p style={{ color: '#e74c3c' }}><strong>Error:</strong> {result.error}</p>}
            
            {result.data && (<div style={{ marginTop: '15px' }}>
                <strong>Details:</strong>
                <pre style={{
                    backgroundColor: '#f1f2f6',
                    padding: '10px',
                    borderRadius: '4px',
                    overflow: 'auto',
                    fontSize: '12px',
                    marginTop: '5px'
                }}>
                  {JSON.stringify(result.data, null, 2)}
                </pre>
              </div>)}
          </div>))}
      </div>

      <div style={{
            marginTop: '40px',
            padding: '20px',
            backgroundColor: '#fff3cd',
            borderRadius: '8px',
            border: '1px solid #ffeaa7'
        }}>
        <h3 style={{ color: '#d63031' }}>🚨 If you're seeing 404 errors:</h3>
        <ol style={{ marginTop: '15px', lineHeight: '1.6' }}>
          <li><strong>Clear browser cache completely</strong> (Ctrl+Shift+Delete → All time → Everything)</li>
          <li><strong>Try incognito/private mode</strong></li>
          <li><strong>Disable all browser extensions</strong></li>
          <li><strong>Check Windows proxy settings</strong> (Settings → Network & Internet → Proxy)</li>
          <li><strong>Try a different browser</strong> (Chrome, Firefox)</li>
          <li><strong>Restart your computer</strong> (sometimes fixes network stack issues)</li>
          <li><strong>Check antivirus/firewall</strong> (temporarily disable to test)</li>
        </ol>
      </div>

      <div style={{
            marginTop: '20px',
            padding: '15px',
            backgroundColor: '#e8f5e8',
            borderRadius: '8px',
            border: '1px solid #27ae60'
        }}>
        <p><strong>✅ Good news:</strong> If you can see this page, React Router is working correctly!</p>
        <p>The issue is likely browser-specific or related to caching/network configuration.</p>
      </div>
    </div>);
};
export default NetworkTest;
