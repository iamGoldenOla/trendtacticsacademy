// ==========================================
// PAYSTACK WEBHOOK SIGNATURE VERIFICATION
// Supabase Edge Function
// ==========================================

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { createHmac } from "https://deno.land/std@0.168.0/node/crypto.ts"

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type, x-paystack-signature',
}

serve(async (req) => {
    // Handle CORS preflight
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders })
    }

    try {
        // Get webhook signature from headers
        const signature = req.headers.get('x-paystack-signature')

        if (!signature) {
            return new Response(
                JSON.stringify({ error: 'Missing webhook signature' }),
                { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Get request body as text for signature verification
        const body = await req.text()

        // Verify signature
        const secretKey = Deno.env.get('PAYSTACK_SECRET_KEY')!
        const hash = createHmac('sha512', secretKey)
            .update(body)
            .digest('hex')

        if (hash !== signature) {
            console.error('Invalid webhook signature')
            return new Response(
                JSON.stringify({ error: 'Invalid signature' }),
                { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
            )
        }

        // Parse body
        const payload = JSON.parse(body)

        // Initialize Supabase client
        const supabaseUrl = Deno.env.get('SUPABASE_URL')!
        const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
        const supabase = createClient(supabaseUrl, supabaseKey)

        // Process webhook based on event type
        const { event, data } = payload

        if (event === 'charge.success') {
            const { reference, amount, currency, customer, status, metadata } = data

            // Check if payment already processed (prevent duplicates)
            const { data: existingPayment } = await supabase
                .from('payments')
                .select('id')
                .eq('transaction_ref', reference)
                .single()

            if (existingPayment) {
                console.log('Payment already processed:', reference)
                return new Response(
                    JSON.stringify({ message: 'Payment already processed' }),
                    { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
                )
            }

            // Verify payment status
            if (status === 'success') {
                // Extract course ID and user ID from metadata
                const courseId = metadata?.course_id
                const userId = metadata?.user_id

                if (!courseId || !userId) {
                    console.error('Missing metadata:', metadata)
                    throw new Error('Missing course_id or user_id in metadata')
                }

                // Convert amount from kobo to naira (or cents to dollars)
                const actualAmount = amount / 100

                // Store payment record
                const { error: paymentError } = await supabase
                    .from('payments')
                    .insert({
                        transaction_ref: reference,
                        user_id: userId,
                        course_id: courseId,
                        amount: actualAmount,
                        currency: currency,
                        status: 'completed',
                        payment_method: 'paystack',
                        customer_email: customer.email,
                        customer_name: `${customer.first_name} ${customer.last_name}`,
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
                        record_id: reference,
                        new_data: { amount: actualAmount, currency, course_id: courseId, gateway: 'paystack' },
                        created_at: new Date().toISOString()
                    })

                console.log('Payment processed successfully:', reference)
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
   supabase functions new paystack-webhook

2. Copy this code to the function file

3. Set environment variables in Supabase:
   - PAYSTACK_SECRET_KEY (from Paystack dashboard)
   - SUPABASE_URL (your Supabase URL)
   - SUPABASE_SERVICE_ROLE_KEY (from Supabase settings)

4. Deploy function:
   supabase functions deploy paystack-webhook

5. Configure webhook in Paystack:
   - URL: https://your-project.supabase.co/functions/v1/paystack-webhook
   - Events: charge.success

6. Payments table already created (same as Flutterwave)

==========================================
*/
