# Trendtactics Academy - Vibe Coding Course

## Overview

This repository contains the HTML version of the Vibe Coding course for Trendtactics Academy. It demonstrates a hybrid approach combining static HTML for course content with React for interactive features.

## 🚀 Automated Deployment

This repository is configured with GitHub Actions for automatic deployment to GitHub Pages. Any changes pushed to the `main` branch will automatically trigger a deployment.

## Directory Structure

```
├── index.html (Homepage)
├── courses/
│   ├── index.html (Courses listing)
│   └── vibe-coding/
│       ├── index.html (Course overview)
│       └── module-1-understanding-vibe-coding.html (Sample module)
├── integration-guide.html (Integration documentation)
├── HYBRID_DEPLOYMENT_GUIDE.md (Deployment instructions)
├── package.json (Node.js project configuration)
└── .github/workflows/deploy.yml (GitHub Actions workflow)
```

## Features

### Course Content (HTML)
- Fast-loading, SEO-friendly course pages
- Responsive design that works on all devices
- Easy to update and maintain
- No build process required

### Integration Documentation
- Detailed guide on connecting HTML content with React dashboard
- Shared authentication system
- Progress tracking implementation
- Navigation consistency

## 🔄 Automatic Deployment

This repository uses GitHub Actions to automatically deploy to GitHub Pages:

1. Any push to the `main` branch triggers deployment
2. GitHub Actions workflow builds and deploys the site
3. Site is available at `https://[username].github.io/[repository-name]/`

To manually trigger deployment:
1. Go to the Actions tab
2. Select "Deploy to GitHub Pages"
3. Click "Run workflow"

## Hybrid Approach Benefits

1. **Performance**: HTML pages load instantly without JavaScript overhead
2. **Reliability**: No frontend rendering failures or dependency issues
3. **SEO**: Search engines can easily crawl and index content
4. **Maintenance**: Simple HTML updates without complex build processes
5. **Integration**: Seamless connection to React-powered dashboard features

## Files

- `index.html` - Main homepage
- `courses/` - Directory containing all course content
- `integration-guide.html` - Detailed documentation on HTML/React integration
- `HYBRID_DEPLOYMENT_GUIDE.md` - Deployment instructions
- `.github/workflows/deploy.yml` - GitHub Actions deployment workflow

## Local Development

To run locally:

```bash
npm install
npm start
```

This will start a local server at `http://localhost:3000`

## License

This project is for educational purposes as part of Trendtactics Academy.

## Support

For questions about this implementation, please contact the Trendtactics Academy team.