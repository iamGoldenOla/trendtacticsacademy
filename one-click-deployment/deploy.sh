#!/bin/bash

echo "========================================"
echo "Trendtactics Academy - One-Click Deployment"
echo "========================================"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "ERROR: Git is not installed on your system."
    echo "Please install Git from https://git-scm.com/downloads"
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

echo "Please enter your GitHub repository URL:"
echo "(Format: https://github.com/YOUR_USERNAME/REPO_NAME.git)"
read -p "Repository URL: " repo_url

if [ -z "$repo_url" ]
then
    echo "ERROR: No repository URL provided."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

echo ""
echo "Initializing deployment..."

# Initialize git repository
git init
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to initialize git repository."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

# Add all files
git add .
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to add files to repository."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

# Commit files
git commit -m "Initial commit: Vibe Coding course deployment"
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to commit files."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

# Add remote origin
git remote add origin $repo_url
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to set remote repository."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

# Push to GitHub
echo ""
echo "Pushing to GitHub... (you may be prompted for credentials)"
git push -u origin main
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to push to GitHub."
    echo "You may need to use a Personal Access Token instead of password."
    echo ""
    read -p "Press Enter to continue..."
    exit 1
fi

echo ""
echo "========================================"
echo "DEPLOYMENT SUCCESSFUL!"
echo "========================================"
echo ""
echo "Your site will be available at:"
echo "https://[YOUR_USERNAME].github.io/[REPO_NAME]/"
echo ""
echo "It may take 2-3 minutes for the site to be live."
echo ""
echo "Future updates will automatically deploy when you push to the main branch."
echo ""
read -p "Press Enter to continue..."