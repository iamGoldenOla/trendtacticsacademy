<?php
// Set CORS headers
header("Access-Control-Allow-Origin: *");

// Set CSP headers
// Use a more targeted CSP that allows Supabase connections
header("Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com https://cdnjs.cloudflare.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net https://js.puter.com; connect-src 'self' https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co; img-src 'self' data: https:; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com; font-src 'self' https://fonts.gstatic.com;");

// Serve the index.html file
readfile('index.html');
?>