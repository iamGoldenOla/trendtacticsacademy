# Deployment Script for Trendtactics Academy Fixes

This document provides step-by-step instructions to deploy all the fixes and improvements made to the Trendtactics Academy platform.

## Prerequisites

1. Node.js and npm installed
2. Git installed
3. Access to the Trendtactics Academy repository
4. Supabase account and project configured

## Deployment Steps

### 1. Backup Current Code

```bash
# Create backup of current frontend
cp -r lms-frontend lms-frontend-backup-$(date +%Y%m%d)

# Create backup of current backend
cp -r lms-backend lms-backend-backup-$(date +%Y%m%d)
```

### 2. Pull Latest Changes

```bash
# Navigate to project root
cd /path/to/trendtactics-academy

# Pull latest changes from repository
git pull origin main
```

### 3. Install Dependencies

```bash
# Install backend dependencies
cd lms-backend
npm install

# Install frontend dependencies
cd ../lms-frontend
npm install
```

### 4. Configure Environment Variables

Ensure the following environment variables are set in both `.env` files:

**Backend (.env)**:
```env
PORT=5002
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret_key
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

**Frontend (.env)**:
```env
REACT_APP_API_URL=http://localhost:5002/api
REACT_APP_SUPABASE_URL=your_supabase_url
REACT_APP_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 5. Build Frontend

```bash
# Navigate to frontend directory
cd lms-frontend

# Build production version
npm run build
```

### 6. Deploy Backend

```bash
# Navigate to backend directory
cd ../lms-backend

# Start production server
npm start
```

### 7. Deploy Frontend

Deploy the contents of `lms-frontend/build` to your web hosting provider.

For Netlify:
```bash
# Install Netlify CLI if not already installed
npm install -g netlify-cli

# Deploy to Netlify
netlify deploy --prod
```

For Vercel:
```bash
# Install Vercel CLI if not already installed
npm install -g vercel

# Deploy to Vercel
vercel --prod
```

### 8. Verify Deployment

1. Visit your deployed frontend URL
2. Check that all new features are working:
   - Header spacing is correct
   - All courses are displayed on the courses page
   - Cart functionality works
   - Analytics dashboard is accessible
   - Admin dashboard is accessible for admin users
3. Test email functionality by registering a new user
4. Test payment flow by adding courses to cart and checking out

### 9. Monitor Logs

Check application logs for any errors:

```bash
# Backend logs
cd lms-backend
tail -f logs/app.log

# Frontend logs (if using hosting provider with log access)
```

## Rollback Procedure

If issues are encountered, rollback to the previous version:

```bash
# Stop current services
# Restore from backups
mv lms-frontend lms-frontend-broken-$(date +%Y%m%d)
mv lms-frontend-backup-previous lms-frontend

mv lms-backend lms-backend-broken-$(date +%Y%m%d)
mv lms-backend-backup-previous lms-backend

# Restart services with previous version
```

## Post-Deployment Tasks

1. Update documentation with new features
2. Notify stakeholders of deployment
3. Monitor application performance
4. Address any user feedback

## Troubleshooting

### Common Issues

1. **Courses not displaying**: Check Supabase connection and course data
2. **Emails not sending**: Verify email service configuration
3. **Payment errors**: Check payment gateway credentials
4. **Dashboard access issues**: Verify user roles and permissions

### Support Contacts

- Development Team: dev@trendtactics.com
- Infrastructure Team: infra@trendtactics.com
- Product Owner: product@trendtactics.com

## Success Metrics

After deployment, monitor these metrics:

1. User engagement with new features
2. Course enrollment rates
3. Cart conversion rates
4. System performance metrics
5. Error rates and user feedback

## Conclusion

Following this deployment script will ensure all fixes and improvements are properly applied to the Trendtactics Academy platform, enhancing functionality and user experience.