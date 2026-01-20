// ============================================================================
// Supabase Edge Function: AI Playground Proxy
// ============================================================================
// This function securely handles AI requests without exposing API keys
// Deploy this to: supabase/functions/ai-playground/index.ts
// ============================================================================

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
    // Handle CORS preflight requests
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        const { prompt, model = 'gpt-4o-mini' } = await req.json()

        if (!prompt) {
            return new Response(
                JSON.stringify({ error: 'Prompt is required' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }



        // Get API key (Check OPENROUTER_KEY_1 to 21, then OPENAI_API_KEY)
        let API_KEY = Deno.env.get('OPENROUTER_API_KEY') || Deno.env.get('OPENAI_API_KEY');

        // Fallback: Check numbered keys if main one is missing
        if (!API_KEY) {
            for (let i = 1; i <= 21; i++) {
                const key = Deno.env.get(`OPENROUTER_KEY_${i}`);
                if (key) {
                    API_KEY = key;
                    break;
                }
            }
        }

        if (!API_KEY) {
            return new Response(
                JSON.stringify({ error: 'API key not configured (OPENROUTER_API_KEY)' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Map simplified model names to OpenRouter provider/model format
        const modelMap: Record<string, string> = {
            'gpt-4o-mini': 'openai/gpt-4o-mini',
            'gpt-4': 'openai/gpt-4',
            'claude-3-sonnet': 'anthropic/claude-3-sonnet',
            'gemini-pro': 'google/gemini-pro'
        }

        const providerModel = modelMap[model] || model;

        // Make request to OpenRouter
        const response = await fetch('https://openrouter.ai/api/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${API_KEY}`,
                'HTTP-Referer': 'https://academy.trendtacticsdigital.com', // Required by OpenRouter
                'X-Title': 'Trendtactics Academy'
            },
            body: JSON.stringify({
                model: providerModel,
                messages: [
                    {
                        role: 'system',
                        content: 'You are an expert web developer specialized in Vibe Coding. Generate a SINGLE HTML file containing all necessary CSS (in <style>) and JS (in <script>) to fulfill the user request. The code must be production-ready, beautiful, and responsive. Do NOT output markdown backticks. Just the raw HTML code.'
                    },
                    { role: 'user', content: prompt }
                ],
                temperature: 0.7,
                max_tokens: 4000
            })
        })

        const data = await response.json()

        if (data.error) {
            console.error("OpenRouter Error:", data.error)
            return new Response(
                JSON.stringify({ error: data.error.message || 'OpenRouter Error' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        if (!data.choices || data.choices.length === 0) {
            return new Response(
                JSON.stringify({ error: 'No response from AI provider' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Extract generated code
        let generatedCode = data.choices[0].message.content

        // Clean up markdown if present
        generatedCode = generatedCode.replace(/```html/g, '').replace(/```/g, '').trim()

        return new Response(
            JSON.stringify({ code: generatedCode }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )

    } catch (error) {
        return new Response(
            JSON.stringify({ error: error.message }),
            { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
    }
})

