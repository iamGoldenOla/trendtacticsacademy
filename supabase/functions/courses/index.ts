// supabase/functions/courses/index.ts
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.0.0";

const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const supabase = createClient(supabaseUrl, supabaseServiceRoleKey);

serve(async (req) => {
  try {
    // Handle CORS preflight requests
    if (req.method === "OPTIONS") {
      return new Response(null, {
        status: 200,
        headers: {
          "Access-Control-Allow-Origin": "https://academy.trendtacticsdigital.com",
          "Access-Control-Allow-Methods": "GET, POST",
          "Access-Control-Allow-Headers": "Content-Type, Authorization",
        },
      });
    }

    // Only allow GET and POST requests
    if (req.method !== "GET" && req.method !== "POST") {
      return new Response(JSON.stringify({ error: "Method not allowed" }), {
        status: 405,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Get request body for POST or query params for GET
    let queryParams = {};
    if (req.method === "POST") {
      queryParams = await req.json();
    } else {
      // For GET requests, parse query parameters from URL
      const url = new URL(req.url);
      const title = url.searchParams.get("title");
      const slug = url.searchParams.get("slug");
      
      if (title) {
        queryParams = { ...queryParams, title };
      }
      if (slug) {
        queryParams = { ...queryParams, slug };
      }
    }

    // Build query to fetch courses
    let query = supabase
      .from("courses")
      .select("id, title, description, level, category, thumbnail_url, duration, modules_count, lessons_count, price, created_at, updated_at, status")
      .eq("status", "published");

    // If both title and slug are provided, prioritize slug
    if (queryParams.slug) {
      // Try to match by title transformed from slug (e.g., 'vibe-coding' -> 'vibe coding')
      query = query.ilike("title", `%${queryParams.slug.replace(/-/g, ' ')}%`);
    } else if (queryParams.title) {
      query = query.ilike("title", `%${queryParams.title}%`);
    }

    const { data, error } = await query;

    if (error) {
      throw new Error(`Failed to fetch courses: ${error.message}`);
    }

    return new Response(
      JSON.stringify({
        success: true,
        courses: data || [],
        count: data ? data.length : 0,
      }),
      {
        status: 200,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "https://academy.trendtacticsdigital.com",
        },
      }
    );
  } catch (error) {
    console.error("Error fetching courses:", error);
    return new Response(
      JSON.stringify({
        error: "Failed to fetch courses",
        message: error.message,
      }),
      {
        status: 500,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "https://academy.trendtacticsdigital.com",
        },
      }
    );
  }
});