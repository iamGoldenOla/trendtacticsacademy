# Trendtactics Academy - GitHub Deployment

This repository contains the Trendtactics Academy platform, which is automatically deployed to the production server via GitHub Actions.

## Deployment Process

The deployment is handled automatically through GitHub Actions when changes are pushed to the `main` or `master` branches.

### GitHub Actions Workflow

The deployment workflow is configured in `.github/workflows/deploy.yml` and includes:
- Code checkout
- Node.js environment setup
- Dependencies installation (if any)
- Tests execution (if any)
- FTP deployment to the production server

### Required Secrets

The deployment requires the following secrets to be configured in the GitHub repository:

- `FTP_SERVER`: The FTP server address
- `FTP_USERNAME`: The FTP username
- `FTP_PASSWORD`: The FTP password

These secrets can be configured in the GitHub repository settings under "Secrets and variables" → "Actions".

## Manual Deployment

If you need to trigger a deployment manually, you can do so from the GitHub Actions tab in your repository.

## Troubleshooting

If deployment fails:
1. Check the GitHub Actions logs for specific error messages
2. Verify that all required secrets are properly configured
3. Ensure that the FTP credentials have appropriate write permissions
4. Confirm that the server directory path is correct