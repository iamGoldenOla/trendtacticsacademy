# Trendtactics Academy Troubleshooting Guide

## Common Issues and Solutions

### 1. Dashboard Access Issues
**Problem**: Unable to access the dashboard or getting redirected incorrectly
**Solution**:
- Check authentication status using browser console
- Verify that the Supabase client is properly initialized
- Ensure the user session is valid

### 2. Authentication Problems
**Problem**: Login/signup not working properly
**Solution**:
- Verify Supabase URL and ANON_KEY are correctly configured in `js/env.js`
- Check browser console for authentication errors
- Clear browser cache and cookies if needed

### 3. Content Security Policy (CSP) Errors
**Problem**: Scripts not loading or blocked by CSP
**Solution**:
- Review `_headers` file for correct CSP directives
- Ensure all required domains are included in CSP
- Check browser console for CSP violation reports

### 4. Course Loading Issues
**Problem**: Courses not loading on the courses page
**Solution**:
- Verify database connectivity through Supabase
- Check that the courses table has the correct schema
- Ensure user has proper permissions to access course data

## Diagnostic Commands

### Check Authentication Status
Open browser console and run:
```javascript
Auth.isLoggedIn().then(loggedIn => console.log('User logged in:', loggedIn));
```

### Check Supabase Connection
Open browser console and run:
```javascript
window.supabaseClient ? console.log('Supabase client OK') : console.log('Supabase client missing');
```

### Run Full Health Check
The site includes a health check script that runs automatically when the page loads. Check the browser console for health check results.

## Quick Fixes

### Force Refresh Authentication
If experiencing authentication issues:
1. Log out completely
2. Clear browser cache and cookies
3. Hard refresh the page (Ctrl+F5 or Cmd+Shift+R)
4. Log in again

### Debug Dashboard Access
If dashboard is not accessible:
1. Check that you're logged in
2. Verify your user account has proper permissions
3. Try accessing `/new-dashboard` directly
4. Check browser console for errors

## Contact Support

If issues persist after trying the above solutions, please contact support with:
- Browser and version
- Specific error messages from console
- Steps to reproduce the issue
- Screenshot of the problem if applicable