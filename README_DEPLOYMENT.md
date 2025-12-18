# Trendtactics Academy Deployment Guide

## 🚀 Quick Deployment

To deploy the Trendtactics Academy platform, follow these steps:

### 1. GitHub Repository Setup
```bash
# Initialize git repository
git init

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Interactive Learning Workspace"

# Add your GitHub repository (replace with your actual URL)
git remote add origin https://github.com/your-username/trendtactics-academy.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### 2. Environment Variables Setup
You need to configure the following environment variables in your deployment platforms:

#### Frontend (Vercel/Netlify)
- `REACT_APP_SUPABASE_URL` - Your Supabase project URL
- `REACT_APP_SUPABASE_ANON_KEY` - Your Supabase anonymous key

#### Backend (Render/Heroku)
- `SUPABASE_URL` - Your Supabase project URL
- `SUPABASE_ANON_KEY` - Your Supabase anonymous key
- `SUPABASE_SERVICE_ROLE_KEY` - Your Supabase service role key (stored in GitHub Secrets)
- `MONGO_URI` - Your MongoDB connection string
- `JWT_SECRET` - Your JWT secret key
- `PORT` - Port number (typically 5000)

### 3. GitHub Secrets Configuration
Store the following sensitive information in GitHub Secrets:

1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Add the following secrets:
   - `SUPABASE_SERVICE_ROLE_KEY` - Your Supabase service role key
   - `MONGO_URI` - Your MongoDB connection string
   - `JWT_SECRET` - Your JWT secret
   - `VERCEL_TOKEN` - Your Vercel token (for automated deployments)
   - `SUPABASE_ACCESS_TOKEN` - Your Supabase access token

## ☁️ Deployment Platforms

### Frontend Deployment Options

#### Vercel (Recommended)
1. Go to [Vercel](https://vercel.com/)
2. Sign in with GitHub
3. Click "New Project"
4. Import your GitHub repository
5. Configure environment variables
6. Deploy!

#### Netlify
1. Go to [Netlify](https://netlify.com/)
2. Sign in with GitHub
3. Click "New site from Git"
4. Select your repository
5. Configure build settings:
   - Build command: `npm run build`
   - Publish directory: `lms-frontend/build`
6. Add environment variables
7. Deploy!

### Backend Deployment Options

#### Render (Recommended)
1. Go to [Render](https://render.com/)
2. Sign up/in with GitHub
3. Click "New Web Service"
4. Connect your GitHub repository
5. Configure settings:
   - Name: trendtactics-academy-backend
   - Region: Choose closest to your users
   - Branch: main
   - Root Directory: lms-backend
   - Environment: Node
   - Build command: `npm install`
   - Start command: `npm start`
6. Add environment variables
7. Deploy!

#### Heroku
1. Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
2. Login: `heroku login`
3. Create app: `heroku create trendtactics-academy-backend`
4. Set environment variables:
   ```bash
   heroku config:set SUPABASE_URL=your_supabase_url
   heroku config:set SUPABASE_ANON_KEY=your_anon_key
   heroku config:set SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
   heroku config:set MONGO_URI=your_mongo_uri
   heroku config:set JWT_SECRET=your_jwt_secret
   heroku config:set PORT=5000
   ```
5. Deploy: `git push heroku main`

## ⚡ Supabase Functions Deployment

### Manual Deployment
```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Navigate to supabase directory
cd supabase

# Deploy all functions
supabase functions deploy

# Or deploy specific function
supabase functions deploy send-email
```

### Automated Deployment (GitHub Actions)
The workflow is already configured in `.github/workflows/deploy.yml`. It will automatically deploy functions when you push to the main branch.

## 🔧 Post-Deployment Verification

After deployment, verify that:

1. ✅ Frontend loads without errors
2. ✅ Courses display correctly
3. ✅ User authentication works
4. ✅ Database connections are functioning
5. ✅ Email functions operate properly
6. ✅ API endpoints respond correctly

## 🛠️ Troubleshooting

### Common Issues

1. **Environment Variables Not Loading**
   - Double-check that all environment variables are set in your deployment platform
   - Ensure variable names match exactly

2. **CORS Errors**
   - Add your frontend URL to Supabase CORS settings
   - Check that API URLs are correctly configured

3. **Database Connection Failures**
   - Verify MongoDB connection string
   - Check Supabase credentials
   - Ensure network access is allowed

4. **Authentication Issues**
   - Confirm JWT secret consistency between frontend and backend
   - Check Supabase auth settings

### Useful Commands

```bash
# Check git status
git status

# View commit history
git log --oneline

# Check remote repositories
git remote -v

# Test locally
cd lms-frontend
npm start

# Test backend locally
cd ../lms-backend
npm start
```

## 📋 Deployment Checklist

- [ ] GitHub repository created and code pushed
- [ ] Environment variables configured in deployment platforms
- [ ] GitHub Secrets set up for sensitive data
- [ ] Frontend deployed and accessible
- [ ] Backend deployed and API responding
- [ ] Supabase functions deployed
- [ ] Database connections verified
- [ ] User authentication tested
- [ ] Course loading functionality confirmed
- [ ] Email functions operational

## 🆘 Need Help?

If you encounter issues during deployment:

1. Check the console logs in your deployment platform
2. Verify all environment variables are correctly set
3. Ensure your Supabase project is properly configured
4. Confirm MongoDB connection is working
5. Reach out to support channels for your deployment platform

For additional assistance with Trendtactics Academy, please contact the development team.