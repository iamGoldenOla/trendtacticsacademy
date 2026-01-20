// Supabase Edge Function for AI Playground
// Uses OpenRouter API with keys stored in Supabase secrets

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
        const { prompt, model = 'openai/gpt-4o-mini' } = await req.json()

        if (!prompt || typeof prompt !== 'string') {
            return new Response(
                JSON.stringify({ error: 'Prompt is required and must be a string' }),
                { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Get OpenRouter API key from Supabase secrets
        // Using OPENROUTER_API_KEY as configured in Supabase
        const openRouterKey = Deno.env.get('OPENROUTER_API_KEY')

        if (!openRouterKey) {
            console.error('OpenRouter API key not found in environment')
            return new Response(
                JSON.stringify({ error: 'API configuration error. Please contact support.' }),
                { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Call OpenRouter API
        const openRouterResponse = await fetch('https://openrouter.ai/api/v1/chat/completions', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${openRouterKey}`,
                'Content-Type': 'application/json',
                'HTTP-Referer': 'https://academy.trendtacticsdigital.com',
                'X-Title': 'Trendtactics Academy AI Playground',
            },
            body: JSON.stringify({
                model: model,
                messages: [
                    {
                        role: 'system',
                        content: 'You are a helpful coding assistant for the Trendtactics Academy AI Playground. Provide clear, concise, and educational responses. When generating code, include explanations and best practices.'
                    },
                    {
                        role: 'user',
                        content: prompt
                    }
                ],
                temperature: 0.7,
                max_tokens: 2000,
            }),
        })

        if (!openRouterResponse.ok) {
            const errorData = await openRouterResponse.text()
            console.error('OpenRouter API error:', errorData)
            return new Response(
                JSON.stringify({
                    error: 'Failed to generate AI response. Please try again.',
                    details: openRouterResponse.status === 429 ? 'Rate limit exceeded' : 'API error'
                }),
                { status: openRouterResponse.status, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        const data = await openRouterResponse.json()

        // Extract the AI response
        const aiResponse = data.choices?.[0]?.message?.content || 'No response generated'

        return new Response(
            JSON.stringify({
                response: aiResponse,
                model: model,
                success: true
            }),
            {
                status: 200,
                headers: { ...corsHeaders, 'Content-Type': 'application/json' }
            }
        )

    } catch (error) {
        console.error('Edge function error:', error)
        return new Response(
            JSON.stringify({
                error: 'An unexpected error occurred',
                message: error.message
            }),
            {
                status: 500,
                headers: { ...corsHeaders, 'Content-Type': 'application/json' }
            }
        )
    }
})
