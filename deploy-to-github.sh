#!/bin/bash

# Deployment script for Trendtactics Academy
# This script automates the process of deploying to GitHub

echo "Starting deployment process for Trendtactics Academy..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git before proceeding."
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not in a git repository. Initializing new repository..."
    git init
    git remote add origin https://github.com/your-username/trendtactics-academy.git
fi

# Add all changes
echo "Adding all files to staging..."
git add .

# Check for changes
if [[ -z $(git status -s) ]]; then
    echo "No changes to commit. Deployment skipped."
    exit 0
else
    echo "Files have been staged for commit."
fi

# Create commit message with timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
commit_message="Deploy: Updates made on ${timestamp}"

echo "Creating commit with message: ${commit_message}"
git commit -m "${commit_message}"

# Get current branch
current_branch=$(git branch --show-current)

if [[ -z "$current_branch" ]]; then
    # If no branch exists, create master branch
    echo "No branch detected, creating master branch..."
    git checkout -b master
    current_branch="master"
fi

# Push to GitHub
echo "Pushing changes to GitHub on branch: ${current_branch}"
git push origin "${current_branch}" --force-with-lease

if [[ $? -eq 0 ]]; then
    echo "Successfully deployed to GitHub!"
    echo "Repository: $(git remote get-url origin)"
    echo "Branch: ${current_branch}"
    echo "Latest commit: $(git log -1 --format='%h - %s (%cr)' HEAD)"
else
    echo "Deployment failed. Please check your Git configuration and remote repository."
    exit 1
fi

echo "Deployment process completed successfully!"