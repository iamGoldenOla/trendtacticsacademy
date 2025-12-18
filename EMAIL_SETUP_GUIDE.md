# Email Setup Guide for Trendtactics Academy

This guide explains how to set up and test email functionality using Resend with Supabase Edge Functions.

## Prerequisites

1. Resend account with API key
2. Supabase project
3. Backend server running

## Setup Steps

### 1. Configure Environment Variables

In your `lms-backend/.env` file, add:

```env
# Email Configuration
RESEND_API_KEY=your_resend_api_key_here
EMAIL_FROM=noreply@trendtactics.com
```

### 2. Set Supabase Secrets

In Supabase Dashboard:
1. Go to Settings > Secrets
2. Add the following secrets:
   - `RESEND_API_KEY` = your_resend_api_key
   - `EMAIL_FROM` = noreply@trendtactics.com

### 3. Deploy Edge Function

To deploy the email Edge Function:

```bash
supabase functions deploy send-email
```

### 4. Test Email Functionality

#### Test locally:

```bash
# Test email service
npm run test-email

# Test Resend directly
npm run test-resend
```

#### Test Edge Function:

```bash
# Invoke the Edge Function directly
curl -X POST \
  -H "Authorization: Bearer YOUR_SUPABASE_SERVICE_ROLE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "test@example.com",
    "subject": "Test Email",
    "html": "<p>Hello from Trendtactics Academy!</p>"
  }' \
  https://YOUR_SUPABASE_PROJECT.supabase.co/functions/v1/send-email
```

## How It Works

The email service tries to send emails in this order:

1. **Supabase Edge Function** - If SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set
2. **Resend Direct** - If RESEND_API_KEY is set
3. **Simulation** - Console logging if no credentials are provided

## Troubleshooting

### Common Issues

1. **Email not sending**: Check that API keys are correctly set
2. **Edge Function errors**: Verify secrets are set in Supabase
3. **Authentication errors**: Ensure service role key is used for Edge Functions

### Logs

Check logs in:
- Terminal/console output
- Supabase Dashboard > Edge Functions > Logs
- Resend Dashboard > Logs

## Security Notes

- Never commit API keys to version control
- Use Supabase secrets for production
- Rotate API keys regularly
- Use environment-specific keys for development/staging/production

## Next Steps

1. Test email functionality with real addresses
2. Customize email templates
3. Set up email analytics
4. Configure email fallbacks