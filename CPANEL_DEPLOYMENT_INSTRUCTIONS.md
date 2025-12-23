# cPanel Deployment Instructions

This project includes automated deployment scripts to deploy your React application to cPanel via FTP.

## Prerequisites

1. Node.js installed on your system
2. cPanel/FTP access credentials:
   - FTP Hostname
   - FTP Username
   - FTP Password
   - FTP Path (usually `/public_html` or `/www`)

## Setup

1. Install dependencies:
   ```bash
   cd lms-frontend
   npm install
   ```

2. Update the deployment configuration in `deploy-to-cpanel.js`:
   ```javascript
   const config = {
       host: 'your-domain.com',           // Your FTP host
       user: 'your_ftp_username',        // Your FTP username
       password: 'your_ftp_password',    // Your FTP password
       port: 21,                        // FTP port (usually 21)
       remotePath: '/public_html'       // Web root directory
   };
   ```

## Deployment Methods

### Method 1: Using Batch Script (Windows)
1. Run the batch script:
   ```bash
   deploy-to-cpanel.bat
   ```

### Method 2: Using PowerShell Script (Windows)
1. Run the PowerShell script:
   ```powershell
   .\deploy-to-cpanel.ps1
   ```

### Method 3: Manual Deployment
1. Build the React app:
   ```bash
   cd lms-frontend
   npm run build
   ```

2. Run the deployment script:
   ```bash
   node ../deploy-to-cpanel.js
   ```

## Environment Variables (Optional)

Instead of hardcoding credentials in the script, you can set environment variables:

```bash
FTP_HOST=your-domain.com
FTP_USER=your_ftp_username
FTP_PASS=your_ftp_password
FTP_PATH=/public_html
```

The script will use these environment variables if available.

## Notes

- The build process will create optimized static files in the `lms-frontend/build` directory
- The deployment script will upload all files from the build directory to your cPanel
- Make sure your cPanel account has sufficient space and permissions
- The deployment will overwrite existing files in the target directory