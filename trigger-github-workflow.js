#!/usr/bin/env node

// Script to trigger the GitHub workflow to add sample lessons
console.log('🚀 Triggering GitHub Workflow');
console.log('===========================\n');

console.log('To trigger the GitHub workflow that adds sample lessons:');
console.log('');
console.log('1. Visit this URL in your browser:');
console.log('   https://github.com/iamGoldenOla/trendtacticsacademy/actions/workflows/add-sample-lessons.yml');
console.log('');
console.log('2. Click the "Run workflow" button (green button)');
console.log('3. Confirm by clicking "Run workflow" again');
console.log('');
console.log('The workflow will:');
console.log('- Use your GitHub Secrets for secure database access');
console.log('- Add 3 sample lessons to each of your 30 modules');
console.log('- Fix the "Error Loading Course" issue');
console.log('');
console.log('After the workflow completes (2-3 minutes), refresh your course page.');
console.log('The error message should be gone and replaced with actual lesson content.');

// If you want to automate this with a GitHub token, you would need to:
// 1. Create a personal access token with repo scope
// 2. Store it securely
// 3. Use the GitHub API to trigger the workflow
//
// But for security reasons, it's better to manually trigger through the GitHub UI