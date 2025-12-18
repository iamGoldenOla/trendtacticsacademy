# Deployment Steps for Trendtactics Academy

## Prerequisites
1. GitHub account
2. Git installed locally
3. Supabase project configured
4. Service role key stored in GitHub Secrets (already done)

## Frontend Deployment (Vercel Recommended)

### 1. Push Code to GitHub
```bash
# Navigate to your project directory
cd "c:\Users\Akinola Olujobi\Documents\Trendtactics Academy"

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Interactive Learning Workspace"

# Add remote repository (replace with your actual repository URL)
git remote add origin https://github.com/your-username/trendtactics-academy.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### 2. Deploy to Vercel
1. Go to [Vercel](https://vercel.com/)
2. Sign in with GitHub
3. Click "New Project"
4. Import your GitHub repository
5. Configure environment variables:
   - REACT_APP_SUPABASE_URL (from your Supabase project settings)
   - REACT_APP_SUPABASE_ANON_KEY (from your Supabase project settings)
6. Deploy!

## Backend Deployment

### Option 1: Deploy to Render.com
1. Create an account at [Render](https://render.com/)
2. Connect your GitHub repository
3. Set up a new Web Service
4. Configure environment variables from your `.env` file:
   - SUPABASE_URL
   - SUPABASE_ANON_KEY
   - SUPABASE_SERVICE_ROLE_KEY (from GitHub Secrets)
   - MONGO_URI
   - JWT_SECRET
   - PORT (typically 5000)

### Option 2: Deploy to Heroku
1. Install Heroku CLI
2. Login: `heroku login`
3. Create app: `heroku create your-app-name`
4. Set environment variables:
   ```bash
   heroku config:set SUPABASE_URL=your_supabase_url
   heroku config:set SUPABASE_ANON_KEY=your_anon_key
   heroku config:set SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
   heroku config:set MONGO_URI=your_mongo_uri
   heroku config:set JWT_SECRET=your_jwt_secret
   ```
5. Deploy: `git push heroku main`

## Supabase Functions Deployment

### Check Existing Functions
First, let's check if you have any Supabase functions that need to be deployed:

```bash
# Navigate to your Supabase functions directory
cd supabase/functions

# List existing functions
ls -la
```

### Deploy Functions to Supabase Edge
If you have functions to deploy:

```bash
# Install Supabase CLI if not already installed
npm install -g supabase

# Login to Supabase
supabase login

# Deploy functions
supabase functions deploy

# Or deploy specific function
supabase functions deploy function-name
```

## Post-Deployment Checklist

- [ ] Verify frontend deployment URL
- [ ] Verify backend API is accessible
- [ ] Test course loading
- [ ] Test user authentication
- [ ] Verify Supabase integration
- [ ] Test all CRUD operations

## Environment Variables Needed

### Frontend (.env.production)
```
REACT_APP_SUPABASE_URL=your_supabase_url
REACT_APP_SUPABASE_ANON_KEY=your_anon_key
REACT_APP_API_URL=https://your-backend-url.com/api
```

### Backend (.env.production)
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_from_github_secrets
MONGO_URI=your_mongo_connection_string
JWT_SECRET=your_jwt_secret
PORT=5000
```

## Troubleshooting

### Common Issues
1. **Environment Variables Not Loaded**: Double-check that all environment variables are set in your deployment platform
2. **CORS Errors**: Ensure your frontend URL is added to Supabase CORS settings
3. **Database Connection**: Verify MongoDB connection string and Supabase credentials
4. **Authentication Issues**: Check JWT secret consistency between frontend and backend

### Useful Commands
```bash
# Check git status
git status

# View commit history
git log --oneline

# Check remote repositories
git remote -v

# View environment variables (local testing only)
cat .env
```