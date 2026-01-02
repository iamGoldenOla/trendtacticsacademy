// supabase/functions/add-course-access/index.ts
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
    const { user_id, course_id } = await req.json();

    if (!user_id || !course_id) {
      return new Response(JSON.stringify({ error: "User ID and Course ID are required" }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    // First, check if the user already has access to this course
    const { data: existingAccess, error: checkError } = await supabase
      .from("student_course_access")
      .select("id")
      .eq("user_id", user_id)
      .eq("course_id", course_id);

    if (checkError) {
      throw new Error(`Failed to check existing access: ${checkError.message}`);
    }

    let result;
    let action;

    if (existingAccess && existingAccess.length > 0) {
      // User already has access, update the status to active
      const { data, error: updateError } = await supabase
        .from("student_course_access")
        .update({ access_status: "active", updated_at: new Date().toISOString() })
        .eq("user_id", user_id)
        .eq("course_id", course_id);

      if (updateError) {
        throw new Error(`Failed to update course access: ${updateError.message}`);
      }

      result = data;
      action = "updated";
    } else {
      // Insert new course access record
      const { data, error: insertError } = await supabase
        .from("student_course_access")
        .insert([{ user_id, course_id, access_status: "active" }]);

      if (insertError) {
        throw new Error(`Failed to add course access: ${insertError.message}`);
      }

      result = data;
      action = "created";
    }

    return new Response(
      JSON.stringify({
        success: true,
        message: `Course access ${action} successfully`,
        action: action,
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
    console.error("Error adding course access:", error);
    return new Response(
      JSON.stringify({
        error: "Failed to add course access",
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