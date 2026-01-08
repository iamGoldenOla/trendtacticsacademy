<?php
// Set CORS headers
header("Access-Control-Allow-Origin: *");

// Set CSP headers
// Use a more targeted CSP that allows Supabase connections
header("Content-Security-Policy: default-src 'self' https:; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com https://cdnjs.cloudflare.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net; connect-src 'self' https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co https://fonts.googleapis.com; img-src 'self' data: https:; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com; font-src 'self' https://fonts.gstatic.com; frame-src 'self';");

// Serve the index.html file
readfile('index.html');
?>