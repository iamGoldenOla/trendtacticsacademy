# GitHub Deployment Setup for Trendtactics Academy

This document explains how to set up automated deployment for the Trendtactics Academy project using GitHub Actions.

## Overview

The project is configured for automated deployment to GitHub Pages using GitHub Actions. When changes are pushed to the `master` or `main` branch, GitHub Actions will automatically build and deploy the site.

## Setup Process

### 1. Create GitHub Repository

1. Go to GitHub and create a new repository
2. Name it appropriately (e.g., `trendtactics-academy`)
3. Do not initialize with README, .gitignore, or license (we already have these)

### 2. Push Local Code to GitHub

```bash
# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/trendtactics-academy.git

# Verify the remote URL
git remote -v

# Push the code to GitHub
git branch -M master
git push -u origin master
```

### 3. GitHub Pages Configuration (Optional)

If you want to host the site directly through GitHub Pages:

1. Go to your repository on GitHub
2. Navigate to Settings > Pages
3. Under "Source", select "GitHub Actions"
4. Your site will be published automatically after the first successful workflow run

## Deployment Configuration

### GitHub Actions Workflow

The workflow is configured in `.github/workflows/deploy.yml` and includes:

- Automatic build on every push to `master` or `main` branch
- Deployment to GitHub Pages
- Synchronization between `master` and `main` branches

### Build Process

The deployment process includes:

1. Checkout the code
2. Setup Node.js environment
3. Install dependencies (from package.json)
4. Build the project
5. Deploy to GitHub Pages

## Manual Deployment

If you need to deploy manually, you can use the provided script:

```bash
# Make the script executable (on Unix systems)
chmod +x deploy-to-github.sh

# Run the deployment script
./deploy-to-github.sh
```

Or use npm:

```bash
npm run deploy
```

## Project Structure

```
trendtactics-academy/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── js/
│   └── lesson-fallback-content.js  # Lesson content
├── .gitignore                  # Files to ignore in Git
├── package.json               # Project configuration and scripts
├── README.md                 # Project documentation
├── deploy-to-github.sh       # Manual deployment script
└── GITHUB_DEPLOYMENT.md      # This file
```

## Troubleshooting

### Workflow Not Triggering

- Ensure your branch is named `master` or `main`
- Check that the workflow file is in the correct location
- Verify the workflow syntax in `.github/workflows/deploy.yml`

### Deployment Failures

- Check the Actions tab in your GitHub repository for error logs
- Ensure all required files are present and properly formatted
- Verify that there are no build errors in your project

## Best Practices

- Always test changes locally before pushing
- Use descriptive commit messages
- Keep dependencies up to date
- Regularly check the deployment logs for any issues
- Make sure to review changes before pushing to the main branch

## Security Considerations

- Never commit sensitive information to the repository
- The .gitignore file is configured to prevent common sensitive files from being committed
- All configurations are designed to be safe for public repositories

## Next Steps

1. Set up your GitHub repository
2. Push the code with the deployment configuration
3. Monitor the first deployment in the Actions tab
4. Verify that your site is working correctly
5. Continue developing and pushing changes - they will be automatically deployed