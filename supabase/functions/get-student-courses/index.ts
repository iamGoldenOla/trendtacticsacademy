// supabase/functions/get-student-courses/index.ts
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
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST",
          "Access-Control-Allow-Headers": "Content-Type, Authorization",
        },
      });
    }

    // Only allow POST requests
    if (req.method !== "POST") {
      return new Response(JSON.stringify({ error: "Method not allowed" }), {
        status: 405,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Get request body
    const { user_id } = await req.json();

    if (!user_id) {
      return new Response(JSON.stringify({ error: "User ID is required" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Get the user's course access records
    const { data: accessData, error: accessError } = await supabase
      .from("student_course_access")
      .select("course_id, access_status, purchase_date")
      .eq("user_id", user_id)
      .eq("access_status", "active");

    if (accessError) {
      throw new Error(`Failed to get course access: ${accessError.message}`);
    }

    if (!accessData || accessData.length === 0) {
      // No enrolled courses
      return new Response(
        JSON.stringify({
          success: true,
          courses: [],
          count: 0,
        }),
        {
          status: 200,
          headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
          },
        }
      );
    }

    // Extract course IDs
    const courseIds = accessData.map((item) => item.course_id);

    // Get course details for these IDs
    const { data: coursesData, error: coursesError } = await supabase
      .from("courses")
      .select("id, title, description, level, category, thumbnail_url")
      .in("id", courseIds)
      .eq("status", "published");

    if (coursesError) {
      throw new Error(`Failed to get courses: ${coursesError.message}`);
    }

    // Combine the data
    const courses = [];
    if (coursesData) {
      for (const course of coursesData) {
        // Find the corresponding access data
        const access = accessData.find((a) => a.course_id === course.id);
        if (access) {
          courses.push({
            course_id: course.id,
            course_title: course.title,
            course_description: course.description,
            course_level: course.level,
            course_category: course.category,
            course_image_url: course.thumbnail_url,
            enrollment_date: access.purchase_date,
            access_status: access.access_status,
          });
        }
      }
    }

    return new Response(
      JSON.stringify({
        success: true,
        courses: courses,
        count: courses.length,
      }),
      {
        status: 200,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      }
    );
  } catch (error) {
    console.error("Error fetching student courses:", error);
    return new Response(
      JSON.stringify({
        error: "Failed to fetch courses",
        message: error.message,
      }),
      {
        status: 500,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      }
    );
  }
});