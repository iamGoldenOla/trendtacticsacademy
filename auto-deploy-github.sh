#!/bin/bash

echo "================================"
echo "Trendtactics Academy Auto Deployment"
echo "================================"

# Check if Git is installed
echo "Checking Git installation..."
if ! command -v git &> /dev/null
then
    echo "ERROR: Git is not installed!"
    echo "Please install Git from https://git-scm.com/downloads"
    echo
    read -p "Press Enter to continue..."
    exit 1
fi

echo "Git found. Proceeding with deployment..."
echo

# Initialize Git repository if not already initialized
echo "Initializing Git repository..."
if [ ! -d ".git" ]; then
    git init
    echo "Git repository initialized."
else
    echo "Git repository already exists."
fi

echo

# Add all files
echo "Adding files to Git..."
git add .
echo "Files added successfully."

echo

# Commit changes
echo "Creating commit..."
git commit -m "Auto-deploy: Update Trendtactics Academy site"
echo "Commit created successfully."

echo

# Get repository URL from user
echo "Please enter your GitHub repository URL:"
echo "Example: https://github.com/YOUR_USERNAME/trendtactics-academy.git"
read -p "Repository URL: " repo_url

if [ -z "$repo_url" ]
then
    echo "ERROR: No repository URL provided."
    echo
    read -p "Press Enter to continue..."
    exit 1
fi

echo

# Add remote origin if not already set
echo "Setting up remote repository..."
git remote add origin $repo_url 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Remote origin already exists or error occurred. Updating remote URL..."
    git remote set-url origin $repo_url
fi

echo "Remote repository configured."

echo

# Push to GitHub
echo "Pushing to GitHub..."
echo "You may be prompted for your GitHub credentials."
echo "If using two-factor authentication, use a Personal Access Token as password."
git push -u origin main --force
if [ $? -ne 0 ]; then
    echo "Trying with master branch..."
    git push -u origin master --force
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to push to GitHub."
        echo "Please check your repository URL and credentials."
        echo
        read -p "Press Enter to continue..."
        exit 1
    fi
fi

echo

echo "================================"
echo "DEPLOYMENT SUCCESSFUL!"
echo "================================"
echo
echo "Your site has been deployed to GitHub."
echo
echo "Next steps:"
echo "1. Go to your repository Settings"
echo "2. Navigate to Pages section"
echo "3. Select 'Deploy from a branch'"
echo "4. Choose your branch (main or master)"
echo "5. Select root folder"
echo "6. Click Save"
echo
echo "Your site will be available at:"
echo "https://[YOUR_USERNAME].github.io/trendtactics-academy/"
echo
echo "Future updates will automatically deploy when you run this script."
echo
read -p "Press Enter to continue..."