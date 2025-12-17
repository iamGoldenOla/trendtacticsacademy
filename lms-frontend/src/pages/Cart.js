import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import cartService from "../services/cartService";

const Cart = () => {
    const [cart, setCart] = useState([]);
    const [cartTotal, setCartTotal] = useState(0);
    const [loading, setLoading] = useState(true);
    const [processing, setProcessing] = useState(false);

    // Fetch cart on component mount
    useEffect(() => {
        const fetchCart = async () => {
            try {
                const cartData = await cartService.getCart();
                setCart(cartData.cart || []);
                setCartTotal(cartData.cartTotal || 0);
            } catch (error) {
                console.error("Error fetching cart:", error);
            } finally {
                setLoading(false);
            }
        };

        fetchCart();
    }, []);

    // Remove item from cart
    const handleRemoveFromCart = async (courseId) => {
        try {
            await cartService.removeFromCart(courseId);
            // Refresh cart
            const cartData = await cartService.getCart();
            setCart(cartData.cart || []);
            setCartTotal(cartData.cartTotal || 0);
        } catch (error) {
            console.error("Error removing from cart:", error);
        }
    };

    // Process checkout
    const handleCheckout = async () => {
        try {
            setProcessing(true);
            // Create checkout session
            const session = await cartService.createCheckoutSession();
            console.log("Checkout session created:", session);
            
            // In a real implementation, you would redirect to a payment provider
            // For now, we'll simulate successful payment
            setTimeout(async () => {
                const paymentResult = await cartService.processPayment({
                    sessionId: session.session.id,
                    amount: cartTotal
                });
                
                if (paymentResult.status === "success") {
                    alert("Payment processed successfully!");
                    // Clear cart
                    setCart([]);
                    setCartTotal(0);
                }
                setProcessing(false);
            }, 2000);
        } catch (error) {
            console.error("Error processing checkout:", error);
            setProcessing(false);
            alert("Error processing payment. Please try again.");
        }
    };

    if (loading) {
        return (
            <div className="min-h-screen bg-gray-50 flex items-center justify-center">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-16 w-16 border-t-2 border-b-2 border-brand-cyan mx-auto"></div>
                    <p className="mt-4 text-gray-600">Loading cart...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gray-50">
            {/* Hero Section */}
            <section className="bg-brand-navy text-white py-16">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center">
                        <h1 className="text-4xl md:text-5xl font-heading font-bold mb-6">
                            Shopping Cart
                        </h1>
                        <p className="text-xl text-gray-200 max-w-2xl mx-auto">
                            Review your selected courses before checkout
                        </p>
                    </div>
                </div>
            </section>

            <section className="py-12">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    {cart.length === 0 ? (
                        <div className="text-center py-12">
                            <div className="text-6xl mb-4">🛒</div>
                            <h3 className="text-2xl font-heading font-semibold text-gray-900 mb-2">
                                Your cart is empty
                            </h3>
                            <p className="text-gray-600 mb-6">
                                Browse our courses and add them to your cart
                            </p>
                            <Link to="/courses" className="btn-primary inline-block">
                                Browse Courses
                            </Link>
                        </div>
                    ) : (
                        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                            {/* Cart Items */}
                            <div className="lg:col-span-2">
                                <div className="bg-white rounded-lg shadow-md p-6">
                                    <h2 className="text-2xl font-heading font-semibold text-gray-900 mb-6">
                                        Cart ({cart.length} {cart.length === 1 ? 'Item' : 'Items'})
                                    </h2>
                                    
                                    <div className="space-y-6">
                                        {cart.map((item) => (
                                            <div key={item.id} className="flex items-center border-b border-gray-200 pb-6 last:border-0 last:pb-0">
                                                <img 
                                                    src={item.thumbnail || 'https://placehold.co/150x100'} 
                                                    alt={item.title} 
                                                    className="w-24 h-16 object-cover rounded-lg"
                                                />
                                                <div className="ml-4 flex-1">
                                                    <h3 className="font-medium text-gray-900">{item.title}</h3>
                                                    <p className="text-brand-cyan font-semibold">${item.price.toFixed(2)}</p>
                                                </div>
                                                <button 
                                                    onClick={() => handleRemoveFromCart(item.id)}
                                                    className="text-red-500 hover:text-red-700 ml-4"
                                                >
                                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                    </svg>
                                                </button>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            </div>

                            {/* Order Summary */}
                            <div className="lg:col-span-1">
                                <div className="bg-white rounded-lg shadow-md p-6 sticky top-6">
                                    <h2 className="text-2xl font-heading font-semibold text-gray-900 mb-6">
                                        Order Summary
                                    </h2>
                                    
                                    <div className="space-y-4 mb-6">
                                        <div className="flex justify-between">
                                            <span className="text-gray-600">Subtotal</span>
                                            <span className="font-medium">${cartTotal.toFixed(2)}</span>
                                        </div>
                                        <div className="flex justify-between">
                                            <span className="text-gray-600">Tax</span>
                                            <span className="font-medium">$0.00</span>
                                        </div>
                                        <div className="border-t border-gray-200 pt-4 flex justify-between font-semibold text-lg">
                                            <span>Total</span>
                                            <span>${cartTotal.toFixed(2)}</span>
                                        </div>
                                    </div>
                                    
                                    <button
                                        onClick={handleCheckout}
                                        disabled={processing}
                                        className={`w-full btn-primary ${processing ? 'opacity-75 cursor-not-allowed' : ''}`}
                                    >
                                        {processing ? (
                                            <>
                                                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white inline" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                                </svg>
                                                Processing...
                                            </>
                                        ) : (
                                            'Proceed to Checkout'
                                        )}
                                    </button>
                                    
                                    <div className="mt-4 text-center">
                                        <Link to="/courses" className="text-brand-cyan hover:underline">
                                            Continue Shopping
                                        </Link>
                                    </div>
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            </section>
        </div>
    );
};

export default Cart;