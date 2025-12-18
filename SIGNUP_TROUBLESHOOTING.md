# Signup Troubleshooting Guide

This guide helps you resolve the "Signup failed. Please try again." error and related issues.

## Common Issues and Solutions

### 1. Content Security Policy (CSP) Violations

**Error Messages:**
```
Loading the script 'https://js.puter.com/v2/' violates the following Content Security Policy directive
Connecting to 'http://localhost:5000/api/auth/register' violates the following Content Security Policy directive: "connect-src 'self'"
```

**Solution:**
1. Update CSP in `lms-frontend/public/index.html`:
   ```html
   <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdnjs.cloudflare.com https://unpkg.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net https://js.puter.com; connect-src 'self' http://localhost:5000 https://uimdbodamoeyukrghchb.supabase.co; media-src 'self' data:; img-src 'self' data: https:; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net; font-src 'self' https://fonts.gstatic.com https://cdn.jsdelivr.net;" />
   ```

2. Update CSP in backend (`lms-backend/src/index.js`):
   ```javascript
   app.use(helmet({
       contentSecurityPolicy: {
           directives: {
               defaultSrc: ["'self'"],
               styleSrc: ["'self'", "'unsafe-inline'"],
               scriptSrc: ["'self'", "'unsafe-inline'", "'unsafe-eval'", "https://js.puter.com"],
               imgSrc: ["'self'", "data:", "https:"],
               connectSrc: ["'self'", "http://localhost:3000", "http://localhost:5000", "https://uimdbodamoeyukrghchb.supabase.co"],
               mediaSrc: ["'self'", "data:"],
           },
       },
   }));
   ```

### 2. Backend Server Not Running

**Error Messages:**
```
Signup error: Error: Network error: Unable to connect to server
```

**Solution:**
1. Check if backend server is running:
   ```bash
   npm run check-server
   ```

2. Start the backend server:
   ```bash
   cd lms-backend
   npm start
   # or for development
   npm run dev
   ```

### 3. CORS Configuration Issues

**Solution:**
Ensure CORS is properly configured in `lms-backend/src/index.js`:
```javascript
app.use(cors({
    origin: process.env.NODE_ENV === 'production'
        ? process.env.FRONTEND_URL
        : ['http://localhost:3000', 'http://localhost:3001', 'http://localhost:5173'],
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'Authorization'],
}));
```

### 4. Port Conflicts

**Issue:**
The backend might be trying to use a port that's already in use.

**Solution:**
1. Check which ports are in use:
   ```bash
   netstat -an | findstr :5000
   netstat -an | findstr :5001
   ```

2. Update the PORT in `.env` file:
   ```env
   PORT=5002
   ```

## Testing Scripts

### Check Server Status
```bash
cd lms-backend
npm run check-server
```

### Test Auth Endpoint Directly
```bash
cd lms-backend
npm run test-auth-endpoint
```

### Test Email Service
```bash
cd lms-backend
npm run test-email
```

## Debugging Steps

### 1. Verify Backend is Running
1. Open terminal and run:
   ```bash
   cd lms-backend
   npm run check-server
   ```

2. If not running, start it:
   ```bash
   npm start
   ```

### 2. Check Browser Console
1. Open browser developer tools (F12)
2. Go to Console tab
3. Look for CSP violations or network errors

### 3. Check Network Tab
1. In browser developer tools, go to Network tab
2. Try to signup again
3. Look for failed requests to `/api/auth/register`
4. Check request/response details

### 4. Check Backend Logs
1. Look at the terminal where backend is running
2. Check for any error messages when signup is attempted

## Common Fixes

### 1. Restart Both Servers
```bash
# Terminal 1 - Frontend
cd lms-frontend
npm start

# Terminal 2 - Backend
cd lms-backend
npm start
```

### 2. Clear Browser Cache
1. Hard refresh (Ctrl+F5 or Cmd+Shift+R)
2. Clear browser cache and cookies for localhost

### 3. Check Environment Variables
Ensure `.env` files are properly configured:
- `lms-frontend/.env` should have `REACT_APP_BACKEND_URL=http://localhost:5000`
- `lms-backend/.env` should have correct MongoDB URI and other configs

## Advanced Troubleshooting

### 1. Test API Endpoints Directly
Use curl or Postman to test the auth endpoint:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"TestPass123!"}'
```

### 2. Check MongoDB Connection
If using MongoDB:
```bash
cd lms-backend
npm run test-supabase
```

### 3. Verify Supabase Configuration
Check that Supabase credentials are correct in `.env` file.

## Still Having Issues?

1. Check that all ports are available (5000, 5001, 3000)
2. Ensure firewall isn't blocking connections
3. Verify that no other instances of the servers are running
4. Check if you're using the correct branch/version of the code