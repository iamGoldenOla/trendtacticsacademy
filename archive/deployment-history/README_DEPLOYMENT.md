# Automatic Deployment Setup for Trendtactics Academy

This guide explains how to set up automatic deployment for your `academy.trendtacticsdigital.com` subdomain using GitHub Actions.

## Prerequisites

1. A server with SSH access
2. Node.js 18+ installed on the server
3. PM2 process manager installed globally (`npm install -g pm2`)
4. Nginx configured for your subdomains

## Setting Up GitHub Secrets

To enable automatic deployment, you need to configure the following secrets in your GitHub repository:

1. Go to your GitHub repository
2. Click on "Settings" tab
3. Click on "Secrets and variables" → "Actions" in the left sidebar
4. Click "New repository secret" and add each of the following:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `HOST` | Your server IP address or hostname | `123.123.123.123` |
| `USERNAME` | SSH username for your server | `deploy` |
| `SSH_KEY` | Private SSH key for deployment | `-----BEGIN OPENSSH PRIVATE KEY-----...` |
| `SUPABASE_URL` | Your Supabase project URL | `https://your-project.supabase.co` |
| `SUPABASE_ANON_KEY` | Your Supabase anon key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` |
| `API_URL` | Your backend API URL | `https://api.academy.trendtacticsdigital.com` |

## Server Setup

### Directory Structure

Create the following directory structure on your server:

```bash
sudo mkdir -p /var/www/academy.trendtacticsdigital.com
sudo mkdir -p /var/www/api.academy.trendtacticsdigital.com
```

### Nginx Configuration

Create Nginx configuration files:

1. Frontend configuration (`/etc/nginx/sites-available/academy.trendtacticsdigital.com`):

```nginx
server {
    listen 80;
    server_name academy.trendtacticsdigital.com;

    location / {
        root /var/www/academy.trendtacticsdigital.com;
        index index.html;
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

2. Backend configuration (`/etc/nginx/sites-available/api.academy.trendtacticsdigital.com`):

```nginx
server {
    listen 80;
    server_name api.academy.trendtacticsdigital.com;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Enable the sites:

```bash
sudo ln -s /etc/nginx/sites-available/academy.trendtacticsdigital.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/api.academy.trendtacticsdigital.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## How It Works

The deployment workflow is triggered automatically on every push to the `main` or `master` branch. It performs the following steps:

1. Checks out the code from the repository
2. Sets up Node.js environment
3. Installs dependencies for both frontend and backend
4. Runs tests for the backend
5. Builds the frontend React application
6. Deploys both frontend and backend to your server
7. Restarts the backend service using PM2
8. Reloads Nginx to apply any configuration changes

## Manual Deployment

If you need to deploy manually, you can use the provided scripts:

### On Windows
```powershell
# Set environment variables
$env:DEPLOY_HOST="your-server-ip"
$env:DEPLOY_USER="your-username"
$env:DEPLOY_KEY="C:\path\to\your\private\key"

# Run the deployment script
.\deploy.ps1
```

### On Linux/Mac
```bash
# Set environment variables
export DEPLOY_HOST=your-server-ip
export DEPLOY_USER=your-username
export DEPLOY_KEY=/path/to/your/private/key

# Make the script executable
chmod +x deploy.sh

# Run the deployment script
./deploy.sh
```

## Adding SSL Certificate

For production use, secure your subdomains with SSL certificates using Let's Encrypt:

```bash
sudo certbot --nginx -d academy.trendtacticsdigital.com -d api.academy.trendtacticsdigital.com
```

## Monitoring

Monitor your deployed applications:

```bash
# Check running processes
pm2 list

# View logs
pm2 logs academy-api

# Check Nginx status
sudo systemctl status nginx
```

## Troubleshooting

1. **Deployment fails**: Check GitHub Actions logs in the repository's Actions tab
2. **Frontend not loading**: Verify Nginx configuration and file permissions
3. **API not responding**: Check if the backend service is running with `pm2 list`
4. **Permission denied**: Ensure your SSH user has write permissions to the deployment directories

## Customization

You can customize the deployment workflows by modifying the files in `.github/workflows/`:

- `deploy-frontend.yml`: Frontend-only deployment
- `deploy-backend.yml`: Backend-only deployment
- `deploy-full.yml`: Full deployment of both frontend and backend