<?php
// Set CORS headers
header("Access-Control-Allow-Origin: *");

// Set CSP headers
// Use a more targeted CSP that allows Supabase connections
header("Content-Security-Policy: default-src 'self' https:; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://unpkg.com https://cdnjs.cloudflare.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net https://js.puter.com https://api.puter.com https://*.puter.com; connect-src 'self' https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co wss://*.puter.com wss://api.puter.com https://api.puter.com https://js.puter.com https://fonts.googleapis.com; img-src 'self' data: https: https://*.puter.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com https://*.puter.com; font-src 'self' https://fonts.gstatic.com; frame-src 'self' https://js.puter.com https://*.puter.com;");

// Serve the index.html file
readfile('index.html');
?>