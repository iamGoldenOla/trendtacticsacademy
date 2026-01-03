#!/bin/bash
# GitHub Deployment Script for Trendtactics Academy

echo "🚀 Starting Trendtactics Academy GitHub Deployment Setup"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "📦 Initializing new Git repository..."
    git init
fi

# Add all files to git
echo "📝 Adding files to Git..."
git add .

# Check for changes
if git diff --staged --quiet; then
    echo "✅ No changes to commit"
else
    echo " committing changes..."
    git commit -m " feat: Add GitHub Actions deployment workflow

- Add GitHub Actions workflow for automated deployments
- Create package.json for Node.js project
- Add .gitignore file
- Update README with deployment instructions
- Prepare project for GitHub deployment"
fi

echo "✅ GitHub deployment setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Create a GitHub repository at https://github.com"
echo "2. Push this code to your repository:"
echo "   git remote add origin <your-repository-url>"
echo "   git branch -M main"
echo "   git push -u origin main"
echo "3. Configure the following secrets in your GitHub repository:"
echo "   - FTP_SERVER: Your FTP server address"
echo "   - FTP_USERNAME: Your FTP username" 
echo "   - FTP_PASSWORD: Your FTP password"
echo "4. The deployment will happen automatically on pushes to main/master"