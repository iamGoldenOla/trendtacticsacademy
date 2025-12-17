// Cart Service
// Handles cart operations and payment processing

import api from './api';

class CartService {
  // Add course to cart
  async addToCart(courseId) {
    try {
      const response = await api.post('/cart/add', { courseId });
      return response.data;
    } catch (error) {
      console.error('Error adding to cart:', error);
      throw error;
    }
  }

  // Remove course from cart
  async removeFromCart(courseId) {
    try {
      const response = await api.delete(`/cart/remove/${courseId}`);
      return response.data;
    } catch (error) {
      console.error('Error removing from cart:', error);
      throw error;
    }
  }

  // Get user's cart
  async getCart() {
    try {
      const response = await api.get('/cart');
      return response.data;
    } catch (error) {
      console.error('Error fetching cart:', error);
      throw error;
    }
  }

  // Create checkout session
  async createCheckoutSession() {
    try {
      const response = await api.post('/payment/checkout');
      return response.data;
    } catch (error) {
      console.error('Error creating checkout session:', error);
      throw error;
    }
  }

  // Process payment
  async processPayment(paymentData) {
    try {
      const response = await api.post('/payment/process', paymentData);
      return response.data;
    } catch (error) {
      console.error('Error processing payment:', error);
      throw error;
    }
  }
}

// Export singleton instance
const cartService = new CartService();

export default cartService;