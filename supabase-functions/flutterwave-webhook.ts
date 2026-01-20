// ==========================================
// FLUTTERWAVE WEBHOOK SIGNATURE VERIFICATION
// Supabase Edge Function
// ==========================================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type, verif-hash',
}

serve(async (req) => {
    // Handle CORS preflight
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        // Get webhook signature from headers
        const signature = req.headers.get('verif-hash')

        if (!signature) {
            return new Response(
                JSON.stringify({ error: 'Missing webhook signature' }),
                { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Get request body
        const payload = await req.json()

        // Verify signature
        const secretHash = Deno.env.get('FLUTTERWAVE_SECRET_HASH')

        if (signature !== secretHash) {
            console.error('Invalid webhook signature')
            return new Response(
                JSON.stringify({ error: 'Invalid signature' }),
                { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Initialize Supabase client
        const supabaseUrl = Deno.env.get('SUPABASE_URL')!
        const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
        const supabase = createClient(supabaseUrl, supabaseKey)

        // Process webhook based on event type
        const { event, data } = payload

        if (event === 'charge.completed') {
            const { tx_ref, amount, currency, customer, status } = data

            // Check if payment already processed (prevent duplicates)
            const { data: existingPayment } = await supabase
                .from('payments')
                .select('id')
                .eq('transaction_ref', tx_ref)
                .single()

            if (existingPayment) {
                console.log('Payment already processed:', tx_ref)
                return new Response(
                    JSON.stringify({ message: 'Payment already processed' }),
                    { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                )
            }

            // Verify payment status
            if (status === 'successful') {
                // Extract course ID from tx_ref (format: TT-timestamp-userId-courseId)
                const parts = tx_ref.split('-')
                const courseId = parts[parts.length - 1]
                const userId = parts[parts.length - 2]

                // Store payment record
                const { error: paymentError } = await supabase
                    .from('payments')
                    .insert({
                        transaction_ref: tx_ref,
                        user_id: userId,
                        course_id: courseId,
                        amount: amount,
                        currency: currency,
                        status: 'completed',
                        payment_method: 'flutterwave',
                        customer_email: customer.email,
                        customer_name: customer.name,
                        raw_data: data,
                        created_at: new Date().toISOString()
                    })

                if (paymentError) {
                    console.error('Error storing payment:', paymentError)
                    throw paymentError
                }

                // Enroll user in course
                const { error: enrollError } = await supabase
                    .from('enrollments')
                    .insert({
                        user_id: userId,
                        course_id: courseId,
                        enrolled_at: new Date().toISOString(),
                        payment_status: 'paid'
                    })

                if (enrollError) {
                    console.error('Error enrolling user:', enrollError)
                    // Don't throw - payment is recorded, manual enrollment may be needed
                }

                // Log audit trail
                await supabase
                    .from('audit_logs')
                    .insert({
                        user_id: userId,
                        action: 'payment_completed',
                        table_name: 'payments',
                        record_id: tx_ref,
                        new_data: { amount, currency, course_id: courseId },
                        created_at: new Date().toISOString()
                    })

                console.log('Payment processed successfully:', tx_ref)
            }
        }

        return new Response(
            JSON.stringify({ message: 'Webhook processed successfully' }),
            { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )

    } catch (error) {
        console.error('Webhook error:', error)
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
   supabase functions new flutterwave-webhook

2. Copy this code to the function file

3. Set environment variables in Supabase:
   - FLUTTERWAVE_SECRET_HASH (from Flutterwave dashboard)
   - SUPABASE_URL (your Supabase URL)
   - SUPABASE_SERVICE_ROLE_KEY (from Supabase settings)

4. Deploy function:
   supabase functions deploy flutterwave-webhook

5. Configure webhook in Flutterwave:
   - URL: https://your-project.supabase.co/functions/v1/flutterwave-webhook
   - Events: charge.completed

6. Create payments table in Supabase:
   See CREATE_PAYMENTS_TABLE.sql

==========================================
*/
