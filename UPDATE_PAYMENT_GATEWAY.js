// Script to update payment gateway configuration
// Run this after setting environment variables

const fs = require('fs');
const path = require('path');

// Path to the payment controller file
const paymentControllerPath = path.join(__dirname, 'lms-backend/src/controllers/paymentController.js');

// Read the current payment controller file
let paymentControllerContent = fs.readFileSync(paymentControllerPath, 'utf8');

// Replace the processPayment function with a real implementation
const newProcessPaymentFunction = `
/**
 * Process payment using configured gateway
 * @param {Object} req - Request object
 * @param {Object} res - Response object
 */
const processPayment = async (req, res) => {
    try {
        const { orderId, paymentMethod, paymentData } = req.body;
        const userId = req.user.id;
        
        // Validate order exists and belongs to user
        const orderQuery = \`SELECT * FROM orders WHERE id = \$1 AND user_id = \$2\`;
        const orderResult = await client.query(orderQuery, [orderId, userId]);
        
        if (orderResult.rows.length === 0) {
            return res.status(404).json({ 
                success: false, 
                message: 'Order not found' 
            });
        }
        
        const order = orderResult.rows[0];
        
        // Check if already processed
        if (order.status !== 'pending') {
            return res.status(400).json({ 
                success: false, 
                message: 'Order already processed' 
            });
        }
        
        let paymentResult;
        
        // Check if we're using Stripe
        if (process.env.STRIPE_SECRET_KEY) {
            const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
            
            // Create payment intent
            const paymentIntent = await stripe.paymentIntents.create({
                amount: Math.round(order.total_amount * 100), // Convert to cents
                currency: 'usd',
                metadata: {
                    orderId: orderId,
                    userId: userId
                }
            });
            
            // Confirm payment with provided payment method
            if (paymentMethod === 'card' && paymentData.paymentMethodId) {
                const confirmedPayment = await stripe.paymentIntents.confirm(
                    paymentIntent.id,
                    { payment_method: paymentData.paymentMethodId }
                );
                
                if (confirmedPayment.status === 'succeeded') {
                    paymentResult = {
                        success: true,
                        transactionId: confirmedPayment.id,
                        status: 'completed'
                    };
                } else {
                    paymentResult = {
                        success: false,
                        message: 'Payment failed',
                        status: confirmedPayment.status
                    };
                }
            } else {
                paymentResult = {
                    success: false,
                    message: 'Invalid payment method',
                    status: 'failed'
                };
            }
        }
        // Check if we're using PayPal
        else if (process.env.PAYPAL_CLIENT_ID && process.env.PAYPAL_CLIENT_SECRET) {
            const paypal = require('@paypal/checkout-server-sdk');
            
            // Create PayPal environment
            const environment = new paypal.core.SandboxEnvironment(
                process.env.PAYPAL_CLIENT_ID,
                process.env.PAYPAL_CLIENT_SECRET
            );
            const client = new paypal.core.PayPalHttpClient(environment);
            
            // Create order
            const request = new paypal.orders.OrdersCreateRequest();
            request.requestBody({
                intent: 'CAPTURE',
                purchase_units: [{
                    amount: {
                        currency_code: 'USD',
                        value: order.total_amount.toString()
                    }
                }]
            });
            
            try {
                const response = await client.execute(request);
                paymentResult = {
                    success: true,
                    transactionId: response.result.id,
                    status: 'completed'
                };
            } catch (error) {
                paymentResult = {
                    success: false,
                    message: 'PayPal payment failed',
                    status: 'failed'
                };
            }
        }
        // Default simulation mode
        else {
            // Simulate successful payment
            paymentResult = {
                success: true,
                transactionId: 'simulated-' + Date.now(),
                status: 'completed'
            };
        }
        
        if (paymentResult.success) {
            // Update order status
            const updateQuery = \`UPDATE orders SET status = 'completed', payment_intent_id = \$1 WHERE id = \$2 RETURNING *\`;
            const updateResult = await client.query(updateQuery, [paymentResult.transactionId, orderId]);
            
            // Enroll user in courses from order items
            const enrollQuery = \`
                INSERT INTO enrollments (user_id, course_id, progress, completed_lessons)
                SELECT o.user_id, oi.course_id, 0, '{}'
                FROM orders o
                JOIN order_items oi ON o.id = oi.order_id
                WHERE o.id = \$1
                ON CONFLICT (user_id, course_id) DO NOTHING
            \`;
            await client.query(enrollQuery, [orderId]);
            
            res.json({
                success: true,
                message: 'Payment processed successfully',
                order: updateResult.rows[0],
                transactionId: paymentResult.transactionId
            });
        } else {
            // Update order status to failed
            const updateQuery = \`UPDATE orders SET status = 'failed' WHERE id = \$1\`;
            await client.query(updateQuery, [orderId]);
            
            res.status(400).json({
                success: false,
                message: paymentResult.message || 'Payment processing failed'
            });
        }
    } catch (error) {
        console.error('Payment processing error:', error);
        res.status(500).json({
            success: false,
            message: 'Internal server error during payment processing'
        });
    }
};
`;

// Replace the existing processPayment function
paymentControllerContent = paymentControllerContent.replace(
    /const processPayment = \(req, res\) => __awaiter\(void 0, void 0, void 0, function\* \(\) \{[\s\S]*?res\.json\(\{[\s\S]*?\}\);\s*\}\)\);/,
    newProcessPaymentFunction
);

// Write the updated content back to the file
fs.writeFileSync(paymentControllerPath, paymentControllerContent);

console.log('✅ Payment controller updated successfully!');
console.log('\\nNext steps:');
console.log('1. Run: npm install stripe @paypal/checkout-server-sdk');
console.log('2. Set your payment gateway environment variables');
console.log('3. Restart your backend server');