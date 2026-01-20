// ==========================================
// AI TUTOR EDGE FUNCTION
// Supabase Edge Function for AI-powered tutoring
// ==========================================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
    // Handle CORS preflight
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        // Get request body
        const { message, context, courseId, lessonId } = await req.json()

        if (!message) {
            return new Response(
                JSON.stringify({ error: 'Message is required' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Initialize Supabase client
        const supabaseUrl = Deno.env.get('SUPABASE_URL')!
        const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
        const supabase = createClient(supabaseUrl, supabaseKey)

        // Get OpenRouter API key from environment
        const openrouterApiKey = Deno.env.get('OPENROUTER_API_KEY')

        if (!openrouterApiKey) {
            return new Response(
                JSON.stringify({ error: 'AI service not configured' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Fetch course/lesson context if provided
        let contextInfo = ''
        if (courseId && lessonId) {
            const { data: lesson } = await supabase
                .from('lessons')
                .select('title, content')
                .eq('id', lessonId)
                .single()

            if (lesson) {
                contextInfo = `\n\nCurrent Lesson: ${lesson.title}\nLesson Content: ${lesson.content?.substring(0, 500)}...`
            }
        }

        // Build system prompt
        const systemPrompt = `You are Trendy, an AI tutor for Trendtactics Academy. You help students learn digital marketing, coding, and prompt engineering.

Your role:
- Answer questions clearly and concisely
- Provide practical examples
- Encourage learning and exploration
- Be friendly and supportive
- If you don't know something, admit it

Context: ${context || 'General tutoring'}${contextInfo}

Keep responses under 200 words unless asked for more detail.`

        // Call OpenRouter API (compatible with OpenAI format)
        const openrouterResponse = await fetch('https://openrouter.ai/api/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${openrouterApiKey}`,
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://academy.trendtacticsdigital.com',
                'X-Title': 'Trendtactics Academy AI Tutor'
            },
            body: JSON.stringify({
                model: 'meta-llama/llama-3.2-3b-instruct:free', // Free model
                messages: [
                    { role: 'system', content: systemPrompt },
                    { role: 'user', content: message }
                ],
                max_tokens: 500,
                temperature: 0.7,
            }),
        })

        if (!openrouterResponse.ok) {
            const error = await openrouterResponse.text()
            console.error('OpenRouter API error:', error)
            return new Response(
                JSON.stringify({ error: 'AI service temporarily unavailable' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        const data = await openrouterResponse.json()
        const aiResponse = data.choices[0]?.message?.content || 'Sorry, I could not generate a response.'

        // Log the interaction (optional)
        await supabase
            .from('ai_tutor_logs')
            .insert({
                message: message,
                response: aiResponse,
                course_id: courseId,
                lesson_id: lessonId,
                created_at: new Date().toISOString()
            })
            .catch(err => console.error('Error logging AI interaction:', err))

        return new Response(
            JSON.stringify({
                response: aiResponse,
                success: true
            }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )

    } catch (error) {
        console.error('AI Tutor error:', error)
        return new Response(
            JSON.stringify({ error: error.message }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
    }
})

/* 
==========================================
DEPLOYMENT INSTRUCTIONS:
==========================================

1. Create Edge Function in Supabase:
   supabase functions new ai-tutor

2. Copy this code to the function file

3. Set environment variables in Supabase:
   - OPENROUTER_API_KEY (your OpenRouter API key - FREE!)
   - SUPABASE_URL (your Supabase URL)
   - SUPABASE_SERVICE_ROLE_KEY (from Supabase settings)

4. Deploy function:
   supabase functions deploy ai-tutor

5. Test the function:
   POST https://uimdbodamoeyukrghchb.supabase.co/functions/v1/ai-tutor
   Body: {
     "message": "What is digital marketing?",
     "context": "Learning basics",
     "courseId": "course-id",
     "lessonId": "lesson-id"
   }

6. Optional: Create ai_tutor_logs table:
   CREATE TABLE ai_tutor_logs (
     id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
     message TEXT,
     response TEXT,
     course_id UUID,
     lesson_id UUID,
     created_at TIMESTAMPTZ DEFAULT NOW()
   );

7. Get FREE OpenRouter API Key:
   - Go to https://openrouter.ai/keys
   - Sign up (free)
   - Create API key
   - Add to Supabase secrets

==========================================
FREE MODELS AVAILABLE:
==========================================
- meta-llama/llama-3.2-3b-instruct:free
- google/gemma-2-9b-it:free
- microsoft/phi-3-mini-128k-instruct:free
- qwen/qwen-2-7b-instruct:free

Current model: meta-llama/llama-3.2-3b-instruct:free
Cost: $0.00 (completely free!)

==========================================
*/
