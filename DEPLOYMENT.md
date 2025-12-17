# Deployment Guide for Trendtactics Academy

This guide explains how to deploy the Trendtactics Academy frontend to your subdomain `academy.trendtacticsdigital.com` using FTP. Since you're using Supabase for your backend, you only need to deploy the frontend.

## Prerequisites

1. An FTP account with write access to your hosting account
2. Node.js 18+ installed on the server (for backend)
3. GitHub repository secrets configured

## GitHub Secrets Required

You need to configure the following secrets in your GitHub repository settings:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `FTP_HOST` | Your FTP server address | `ftp.trendtacticsdigital.com` |
| `FTP_USERNAME` | Your FTP username | `your-ftp-username` |
| `FTP_PASSWORD` | Your FTP password | `your-ftp-password` |
| `SUPABASE_URL` | Your Supabase project URL | `https://your-project.supabase.co` |
| `SUPABASE_ANON_KEY` | Your Supabase anon key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` |

## Directory Structure on Server

The deployment process assumes the following directory structure:

```
/public_html/
└── academy/     # Frontend static files
```

## Web Server Configuration

You'll need to configure your web server to serve the frontend. Here's how:

### Frontend Configuration

The frontend will be served from `https://academy.trendtacticsdigital.com/` and should point to the `/public_html/academy/` directory.

If your hosting provider uses cPanel or similar control panel, you may need to set up a subdomain that points to this directory.

## Deployment Process

The deployment is automated through GitHub Actions:

1. **Frontend Deployment**: Builds the React application and deploys static files via FTP

The backend is hosted on Supabase, so no backend deployment is needed.

### Manual Deployment

If you need to deploy manually:

#### Frontend
```bash
cd lms-frontend
npm run build
# Then use an FTP client to upload the contents of the build/ directory to /public_html/academy/
```

## Monitoring

Check with your hosting provider's control panel for:
1. Application logs
2. Resource usage
3. Uptime monitoring

## Troubleshooting

1. **Frontend not loading**: Check file permissions and ensure all files were uploaded correctly
2. **API not responding**: Verify your Supabase configuration and connectivity
3. **Deployment failures**: Check GitHub Actions logs in the repository's Actions tab

## SSL Certificate

Most hosting providers automatically provide SSL certificates for your domains. If not, contact your hosting provider to set up SSL for your subdomain.