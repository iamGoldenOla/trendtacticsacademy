# 🔧 Routing 404 Troubleshooting Guide

## Current Status
- ✅ Frontend server is running on `http://localhost:3000`
- ✅ All routes compile successfully without errors
- ✅ Preview tool shows no browser errors for any route
- ❌ User reports 404 errors in Edge/Microsoft browsers

## Routes That Should Work
1. `http://localhost:3000/` (Home)
2. `http://localhost:3000/simple-test` (Simple test page)
3. `http://localhost:3000/diagnostic` (Diagnostic page)
4. `http://localhost:3000/planner` (Planner page)
5. `http://localhost:3000/test-planner` (Test planner)

## Step-by-Step Troubleshooting

### Step 1: Verify Server is Running
1. Open Command Prompt/PowerShell
2. Run: `netstat -ano | findstr :3000`
3. You should see a process listening on port 3000

### Step 2: Test Basic Connectivity
1. Try: `http://localhost:3000` (should show home page)
2. Try: `http://127.0.0.1:3000` (alternative localhost)
3. Try: `http://192.168.0.143:3000` (network IP from server logs)

### Step 3: Browser-Specific Issues
1. **Clear all browser data**:
   - Press `Ctrl + Shift + Delete`
   - Select "All time"
   - Clear everything

2. **Try incognito/private mode**

3. **Disable browser extensions**

4. **Try different browsers**:
   - Chrome
   - Firefox
   - Safari (if on Mac)

### Step 4: Network/Proxy Issues
1. **Check proxy settings**:
   - Windows Settings > Network & Internet > Proxy
   - Ensure "Use a proxy server" is OFF

2. **Check Windows Firewall**:
   - Allow Node.js through firewall

3. **Check antivirus software**:
   - Temporarily disable to test

### Step 5: Development Server Issues
1. **Restart the server**:
   ```bash
   # Stop current server (Ctrl+C)
   npm start
   ```

2. **Clear npm cache**:
   ```bash
   npm cache clean --force
   npm start
   ```

3. **Delete node_modules and reinstall**:
   ```bash
   rmdir /s node_modules
   del package-lock.json
   npm install
   npm start
   ```

### Step 6: Alternative Ports
If port 3000 has issues, try a different port:
```bash
set PORT=3001 && npm start
```

### Step 7: Check for Conflicting Software
- Skype (uses port 80/443)
- IIS (Internet Information Services)
- Other development servers
- VPN software

## What to Check in Browser Developer Tools
1. Press `F12` to open Developer Tools
2. Go to **Network** tab
3. Try to navigate to `/simple-test`
4. Look for:
   - HTTP status codes
   - Failed requests
   - Console errors

## Expected Behavior
When working correctly:
- `http://localhost:3000/simple-test` should show a green success page
- `http://localhost:3000/diagnostic` should show routing diagnostic info
- `http://localhost:3000/planner` should show the study planner

## If Nothing Works
1. **Check Windows hosts file**:
   - Location: `C:\Windows\System32\drivers\etc\hosts`
   - Ensure no conflicting localhost entries

2. **Try running as administrator**:
   - Right-click Command Prompt
   - "Run as administrator"
   - Navigate to project folder
   - Run `npm start`

3. **Check for port conflicts**:
   ```bash
   netstat -ano | findstr :3000
   ```

## Contact Information
If issues persist, provide:
1. Exact error message
2. Browser and version
3. Windows version
4. Screenshot of browser developer tools
5. Output of `netstat -ano | findstr :3000`