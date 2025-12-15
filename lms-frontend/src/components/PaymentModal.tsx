import React, { useState } from 'react';
import { Course } from '../types';

interface PaymentModalProps {
  isOpen: boolean;
  onClose: () => void;
  course: Course;
  onPaymentSuccess: (paymentId: string) => void;
  onPaymentError: (error: string) => void;
}

const PaymentModal: React.FC<PaymentModalProps> = ({
  isOpen,
  onClose,
  course,
  onPaymentSuccess,
  onPaymentError
}) => {
  const [paymentMethod, setPaymentMethod] = useState('card');
  const [isProcessing, setIsProcessing] = useState(false);
  const [formData, setFormData] = useState({
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    cardholderName: '',
    email: '',
    address: '',
    city: '',
    zipCode: '',
    country: 'US'
  });
  const [errors, setErrors] = useState<{ [key: string]: string }>({});

  const validateForm = () => {
    const newErrors: { [key: string]: string } = {};

    if (!formData.cardNumber.replace(/\s/g, '').match(/^\d{16}$/)) {
      newErrors.cardNumber = 'Please enter a valid 16-digit card number';
    }

    if (!formData.expiryDate.match(/^(0[1-9]|1[0-2])\/([0-9]{2})$/)) {
      newErrors.expiryDate = 'Please enter a valid expiry date (MM/YY)';
    }

    if (!formData.cvv.match(/^\d{3,4}$/)) {
      newErrors.cvv = 'Please enter a valid CVV';
    }

    if (!formData.cardholderName.trim()) {
      newErrors.cardholderName = 'Cardholder name is required';
    }

    if (!formData.email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      newErrors.email = 'Please enter a valid email address';
    }

    if (!formData.address.trim()) {
      newErrors.address = 'Address is required';
    }

    if (!formData.city.trim()) {
      newErrors.city = 'City is required';
    }

    if (!formData.zipCode.trim()) {
      newErrors.zipCode = 'ZIP code is required';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) {
      return;
    }

    setIsProcessing(true);

    try {
      // Mock payment processing - in real app, this would call Stripe API
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      // Simulate successful payment
      const paymentId = `pay_${Date.now()}`;
      onPaymentSuccess(paymentId);
      onClose();
    } catch (error) {
      onPaymentError('Payment failed. Please try again.');
    } finally {
      setIsProcessing(false);
    }
  };

  const formatCardNumber = (value: string) => {
    const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    const matches = v.match(/\d{4,16}/g);
    const match = matches && matches[0] || '';
    const parts = [];
    for (let i = 0, len = match.length; i < len; i += 4) {
      parts.push(match.substring(i, i + 4));
    }
    if (parts.length) {
      return parts.join(' ');
    } else {
      return v;
    }
  };

  const formatExpiryDate = (value: string) => {
    const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    if (v.length >= 2) {
      return v.substring(0, 2) + '/' + v.substring(2, 4);
    }
    return v;
  };

  const paymentCardStyles: Record<string, string> = {
    card: 'bg-gray-50 border-gray-300',
    flutterwave: 'bg-yellow-50 border-yellow-300',
    paystack: 'bg-blue-50 border-blue-300',
    stripe: 'bg-purple-50 border-purple-300',
  };
  const paymentIcons: Record<string, React.ReactNode> = {
    card: (
      <svg className="w-8 h-8" fill="none" viewBox="0 0 24 24" stroke="currentColor"><rect x="2" y="6" width="20" height="12" rx="3" fill="#e5e7eb" stroke="#64748b" strokeWidth="2"/><rect x="2" y="10" width="20" height="2" fill="#64748b" /></svg>
    ),
    flutterwave: (
      <img src="/payments/flutterwave.png" alt="Flutterwave" className="w-8 h-8 object-contain" />
    ),
    paystack: (
      <svg className="w-8 h-8" viewBox="0 0 48 48" fill="none"><rect width="48" height="48" rx="24" fill="#e3f0ff"/><rect x="14" y="14" width="20" height="4" rx="2" fill="#0aa5ff"/><rect x="14" y="20" width="20" height="4" rx="2" fill="#0aa5ff"/><rect x="14" y="26" width="20" height="4" rx="2" fill="#0aa5ff"/><rect x="14" y="32" width="12" height="4" rx="2" fill="#0aa5ff"/></svg>
    ),
    stripe: (
      <svg className="w-8 h-8" viewBox="0 0 48 48" fill="none"><rect width="48" height="48" rx="24" fill="#f3f0ff"/><text x="24" y="30" textAnchor="middle" fontSize="18" fontWeight="bold" fill="#635bff">S</text></svg>
    ),
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        {/* Header */}
        <div className="p-6 border-b border-gray-200">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-2xl font-heading font-bold text-gray-900">
                Complete Your Purchase
              </h2>
              <p className="text-gray-600 mt-1">
                {course.title}
              </p>
            </div>
            <button
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
        </div>

        <div className="p-6">
          {/* Order Summary */}
          <div className="bg-gray-50 rounded-lg p-4 mb-6">
            <h3 className="font-semibold text-gray-900 mb-3">Order Summary</h3>
            <div className="flex items-center space-x-4">
              <img
                src={course.thumbnail}
                alt={course.title}
                className="w-16 h-16 object-cover rounded-lg"
              />
              <div className="flex-1">
                <h4 className="font-medium text-gray-900">{course.title}</h4>
                <p className="text-sm text-gray-600">{course.duration} • {course.lessons.length} lessons</p>
              </div>
              <div className="text-right">
                <div className="text-2xl font-bold text-gray-900">${course.price}</div>
                <div className="text-sm text-gray-600">One-time payment</div>
              </div>
            </div>
          </div>

          {/* Payment Methods */}
          <div className="mb-6">
            <h3 className="font-semibold text-gray-900 mb-3">Payment Method</h3>
            <div className="grid grid-cols-1 md:grid-cols-4 gap-3">
              {[
                { id: 'card', label: 'Credit Card' },
                { id: 'flutterwave', label: 'Flutterwave' },
                { id: 'paystack', label: 'Paystack' },
                { id: 'stripe', label: 'Stripe' },
              ].map((method) => (
                <button
                  key={method.id}
                  onClick={() => setPaymentMethod(method.id)}
                  className={`p-4 border rounded-lg flex flex-col items-center justify-center transition-colors ${
                    paymentMethod === method.id
                      ? 'border-brand-cyan bg-brand-cyan bg-opacity-10'
                      : paymentCardStyles[method.id] || 'border-gray-300'
                  } hover:shadow-lg`}
                >
                  <div className="flex flex-col items-center">
                    <span className="mb-2">{paymentIcons[method.id]}</span>
                    <span className="font-medium text-gray-900 text-center">{method.label}</span>
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* Payment Form */}
          {paymentMethod === 'card' && (
            <form onSubmit={handleSubmit} className="space-y-6">
              {/* Card Information */}
              <div>
                <h4 className="font-medium text-gray-900 mb-4">Card Information</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Card Number
                    </label>
                    <input
                      type="text"
                      value={formData.cardNumber}
                      onChange={(e) => setFormData(prev => ({ ...prev, cardNumber: formatCardNumber(e.target.value) }))}
                      className={`input-field ${errors.cardNumber ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="1234 5678 9012 3456"
                      maxLength={19}
                    />
                    {errors.cardNumber && (
                      <p className="mt-1 text-sm text-red-600">{errors.cardNumber}</p>
                    )}
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Expiry Date
                    </label>
                    <input
                      type="text"
                      value={formData.expiryDate}
                      onChange={(e) => setFormData(prev => ({ ...prev, expiryDate: formatExpiryDate(e.target.value) }))}
                      className={`input-field ${errors.expiryDate ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="MM/YY"
                      maxLength={5}
                    />
                    {errors.expiryDate && (
                      <p className="mt-1 text-sm text-red-600">{errors.expiryDate}</p>
                    )}
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      CVV
                    </label>
                    <input
                      type="text"
                      value={formData.cvv}
                      onChange={(e) => setFormData(prev => ({ ...prev, cvv: e.target.value.replace(/\D/g, '') }))}
                      className={`input-field ${errors.cvv ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="123"
                      maxLength={4}
                    />
                    {errors.cvv && (
                      <p className="mt-1 text-sm text-red-600">{errors.cvv}</p>
                    )}
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Cardholder Name
                    </label>
                    <input
                      type="text"
                      value={formData.cardholderName}
                      onChange={(e) => setFormData(prev => ({ ...prev, cardholderName: e.target.value }))}
                      className={`input-field ${errors.cardholderName ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="John Doe"
                    />
                    {errors.cardholderName && (
                      <p className="mt-1 text-sm text-red-600">{errors.cardholderName}</p>
                    )}
                  </div>
                </div>
              </div>

              {/* Billing Information */}
              <div>
                <h4 className="font-medium text-gray-900 mb-4">Billing Information</h4>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Email Address
                    </label>
                    <input
                      type="email"
                      value={formData.email}
                      onChange={(e) => setFormData(prev => ({ ...prev, email: e.target.value }))}
                      className={`input-field ${errors.email ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="john@example.com"
                    />
                    {errors.email && (
                      <p className="mt-1 text-sm text-red-600">{errors.email}</p>
                    )}
                  </div>

                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Address
                    </label>
                    <input
                      type="text"
                      value={formData.address}
                      onChange={(e) => setFormData(prev => ({ ...prev, address: e.target.value }))}
                      className={`input-field ${errors.address ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="123 Main St"
                    />
                    {errors.address && (
                      <p className="mt-1 text-sm text-red-600">{errors.address}</p>
                    )}
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      City
                    </label>
                    <input
                      type="text"
                      value={formData.city}
                      onChange={(e) => setFormData(prev => ({ ...prev, city: e.target.value }))}
                      className={`input-field ${errors.city ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="New York"
                    />
                    {errors.city && (
                      <p className="mt-1 text-sm text-red-600">{errors.city}</p>
                    )}
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      ZIP Code
                    </label>
                    <input
                      type="text"
                      value={formData.zipCode}
                      onChange={(e) => setFormData(prev => ({ ...prev, zipCode: e.target.value }))}
                      className={`input-field ${errors.zipCode ? 'border-red-500 focus:ring-red-500' : ''}`}
                      placeholder="10001"
                    />
                    {errors.zipCode && (
                      <p className="mt-1 text-sm text-red-600">{errors.zipCode}</p>
                    )}
                  </div>
                </div>
              </div>

              {/* Security Notice */}
              <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div className="flex items-start space-x-3">
                  <svg className="w-5 h-5 text-blue-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clipRule="evenodd" />
                  </svg>
                  <div>
                    <h5 className="font-medium text-blue-900">Secure Payment</h5>
                    <p className="text-sm text-blue-700 mt-1">
                      Your payment information is encrypted and secure. We use industry-standard SSL encryption to protect your data.
                    </p>
                  </div>
                </div>
              </div>

              {/* Submit Button */}
              <button
                type="submit"
                disabled={isProcessing}
                className="w-full btn-primary disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isProcessing ? (
                  <div className="flex items-center justify-center">
                    <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Processing Payment...
                  </div>
                ) : (
                  `Pay $${course.price}`
                )}
              </button>
            </form>
          )}

          {paymentMethod === 'flutterwave' && (
            <div className="text-center py-8">
              <div className="text-6xl mb-4">🌍</div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                Flutterwave Integration
              </h3>
              <p className="text-gray-600 mb-6">
                You'll be redirected to Flutterwave to complete your payment securely.
              </p>
              <button className="btn-primary">
                Continue with Flutterwave
              </button>
            </div>
          )}

          {paymentMethod === 'paystack' && (
            <div className="text-center py-8">
              <div className="text-6xl mb-4">💡</div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                Paystack Integration
              </h3>
              <p className="text-gray-600 mb-6">
                You'll be redirected to Paystack to complete your payment securely.
              </p>
              <button className="btn-primary">
                Continue with Paystack
              </button>
            </div>
          )}

          {paymentMethod === 'stripe' && (
            <div className="text-center py-8">
              <div className="text-6xl mb-4">💠</div>
              <h3 className="text-xl font-semibold text-gray-900 mb-2">
                Stripe Integration
              </h3>
              <p className="text-gray-600 mb-6">
                You'll be redirected to Stripe to complete your payment securely.
              </p>
              <button className="btn-primary">
                Continue with Stripe
              </button>
            </div>
          )}

          {/* Terms and Conditions */}
          <div className="mt-6 text-center">
            <p className="text-xs text-gray-500">
              By completing your purchase, you agree to our{' '}
              <button type="button" className="text-brand-cyan hover:text-brand-navy">
                Terms of Service
              </button>{' '}
              and{' '}
              <button type="button" className="text-brand-cyan hover:text-brand-navy">
                Privacy Policy
              </button>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default PaymentModal; 