// Example Edge Function for sending welcome emails
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (_req) => {
  // Access environment variables
  const siteName = Deno.env.get('SITE_NAME') || 'Trendtactics Academy';
  
  // Access secrets (automatically injected)
  const sendgridKey = Deno.env.get('SENDGRID_API_KEY');
  
  // In a real implementation, you would:
  // 1. Parse the request body for user data
  // 2. Use the sendgridKey to send an actual email
  // 3. Return appropriate success/failure response
  
  return new Response(
    JSON.stringify({ 
      message: `Welcome email function ready for ${siteName}!`,
      timestamp: new Date().toISOString(),
      hasSendGridKey: !!sendgridKey
    }),
    { 
      headers: { "Content-Type": "application/json" },
      status: 200
    },
  );
});