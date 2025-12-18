// Edge Function for sending emails using Resend
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { Resend } from "https://esm.sh/resend@4.0.0";

serve(async (req) => {
  try {
    // Parse the request body
    const { to, subject, text, html } = await req.json();
    
    // Validate required fields
    if (!to || !subject) {
      return new Response(
        JSON.stringify({ 
          success: false, 
          error: "Missing required fields: to and subject are required" 
        }),
        { 
          headers: { "Content-Type": "application/json" },
          status: 400
        }
      );
    }
    
    // Get Resend API key from secrets
    const resendApiKey = Deno.env.get('RESEND_API_KEY');
    
    if (!resendApiKey) {
      return new Response(
        JSON.stringify({ 
          success: false, 
          error: "Resend API key not configured" 
        }),
        { 
          headers: { "Content-Type": "application/json" },
          status: 500
        }
      );
    }
    
    // Create Resend client
    const resend = new Resend(resendApiKey);
    
    // Send email
    const data = await resend.emails.send({
      from: Deno.env.get('EMAIL_FROM') || 'noreply@trendtactics.com',
      to,
      subject,
      text,
      html
    });
    
    return new Response(
      JSON.stringify({ 
        success: true, 
        messageId: data.id,
        message: "Email sent successfully"
      }),
      { 
        headers: { "Content-Type": "application/json" },
        status: 200
      }
    );
  } catch (error) {
    console.error('Error sending email:', error);
    
    return new Response(
      JSON.stringify({ 
        success: false, 
        error: error.message || "Failed to send email"
      }),
      { 
        headers: { "Content-Type": "application/json" },
        status: 500
      }
    );
  }
});