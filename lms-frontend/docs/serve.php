<?php
// Set CORS headers
header("Access-Control-Allow-Origin: *");

// Set CSP headers
header("Content-Security-Policy: default-src * 'unsafe-inline' 'unsafe-eval'; connect-src * https://uimdbodamoeyukrghchb.supabase.co https://*.supabase.co; script-src * 'unsafe-inline' 'unsafe-eval' https://cdnjs.cloudflare.com https://unpkg.com https://fonts.googleapis.com https://www.googletagmanager.com https://www.google-analytics.com https://cdn.jsdelivr.net https://js.puter.com; frame-src * https://puter.com https://*.supabase.co; img-src * data: https:; style-src * 'unsafe-inline' https://fonts.googleapis.com; font-src * https://fonts.gstatic.com; worker-src * blob:; child-src * https://puter.com https://*.supabase.co;");

// Serve the index.html file
readfile('index.html');
?>