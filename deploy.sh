#!/bin/bash

# Deployment script for Trendtactics Academy
# This script builds and deploys both frontend and backend to your server

echo "Starting deployment process for Trendtactics Academy..."

# Check if required environment variables are set
if [ -z "$DEPLOY_HOST" ] || [ -z "$DEPLOY_USER" ] || [ -z "$DEPLOY_KEY" ]; then
    echo "Error: Please set DEPLOY_HOST, DEPLOY_USER, and DEPLOY_KEY environment variables"
    echo "Example:"
    echo "  export DEPLOY_HOST=your-server-ip"
    echo "  export DEPLOY_USER=your-username"
    echo "  export DEPLOY_KEY=/path/to/your/private/key"
    exit 1
fi

# Build frontend
echo "Building frontend..."
cd lms-frontend
npm run build
if [ $? -ne 0 ]; then
    echo "Error: Frontend build failed"
    exit 1
fi
cd ..

# Build backend
echo "Building backend..."
cd lms-backend
npm run build
if [ $? -ne 0 ]; then
    echo "Error: Backend build failed"
    exit 1
fi
cd ..

# Deploy frontend
echo "Deploying frontend to $DEPLOY_HOST..."
scp -i $DEPLOY_KEY -r lms-frontend/build/* $DEPLOY_USER@$DEPLOY_HOST:/var/www/academy.trendtacticsdigital.com

# Deploy backend
echo "Deploying backend to $DEPLOY_HOST..."
scp -i $DEPLOY_KEY -r lms-backend/* $DEPLOY_USER@$DEPLOY_HOST:/var/www/api.academy.trendtacticsdigital.com

# Configure and restart services
echo "Configuring and restarting services..."
ssh -i $DEPLOY_KEY $DEPLOY_USER@$DEPLOY_HOST << 'EOF'
    # Navigate to backend directory and install production dependencies
    cd /var/www/api.academy.trendtacticsdigital.com
    npm ci --production
    
    # Restart or start the backend service with PM2
    pm2 reload academy-api || pm2 start app.js --name academy-api
    
    # Reload Nginx to apply any configuration changes
    sudo systemctl reload nginx
    
    # Display status
    echo "Deployment completed successfully!"
    pm2 list
EOF

echo "Deployment process completed!"