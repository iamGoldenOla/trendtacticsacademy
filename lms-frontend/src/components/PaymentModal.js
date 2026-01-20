import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useFlutterwave, closePaymentModal } from 'flutterwave-react-v3';
import { usePaystackPayment } from 'react-paystack';

const PaymentModal = ({ isOpen, onClose, course, user, selectedCurrency, onPaymentSuccess }) => {
  const [isProcessing, setIsProcessing] = useState(false);
  const [selectedGateway, setSelectedGateway] = useState('flutterwave'); // or 'paystack'
  const navigate = useNavigate();

  // Currency configuration
  const CURRENCY_CONFIG = {
    'USD': { symbol: '$', rate: 1.00, name: 'US Dollar', flw_code: 'USD', paystack_code: 'USD' },
    'NGN': { symbol: '₦', rate: 1.00, name: 'Nigerian Naira', flw_code: 'NGN', paystack_code: 'NGN' },
    'EUR': { symbol: '€', rate: 0.92, name: 'Euro', flw_code: 'EUR', paystack_code: 'EUR' },
    'GBP': { symbol: '£', rate: 0.79, name: 'British Pound', flw_code: 'GBP', paystack_code: 'GBP' },
    'CAD': { symbol: 'C$', rate: 1.35, name: 'Canadian Dollar', flw_code: 'CAD', paystack_code: 'CAD' },
    'AUD': { symbol: 'A$', rate: 1.52, name: 'Australian Dollar', flw_code: 'AUD', paystack_code: 'AUD' }
  };

  // Get actual course price from database
  const coursePrice = course?.price || 5000; // Default to ₦5,000 if not set
  const courseCurrency = course?.currency || 'NGN'; // Default to NGN

  // Use course currency or default to NGN for Nigerian users
  const currency = selectedCurrency || courseCurrency || 'NGN';
  const currencyData = CURRENCY_CONFIG[currency];

  // Use actual course price (no conversion needed if already in NGN)
  const actualPrice = courseCurrency === currency ? coursePrice : coursePrice * currencyData.rate;

  const displayPrice = currency === 'NGN'
    ? `${currencyData.symbol}${Math.round(actualPrice).toLocaleString()}`
    : `${currencyData.symbol}${actualPrice.toFixed(2)}`;

  // Paystack amount in kobo (multiply by 100)
  const paystackAmount = Math.round(actualPrice * 100);

  // Flutterwave configuration
  const flutterwaveConfig = {
    public_key: process.env.REACT_APP_FLUTTERWAVE_PUBLIC_KEY || 'FLWPUBK-test-xxxxx',
    tx_ref: `FLW-${Date.now()}-${user?.id || 'guest'}-${course?.id}`,
    amount: actualPrice,
    currency: currencyData.flw_code,
    payment_options: 'card,mobilemoney,ussd,banktransfer',
    customer: {
      email: user?.email || 'guest@example.com',
      phone_number: user?.phone || '',
      name: user?.name || 'Guest User',
    },
    customizations: {
      title: 'Trendtactics Academy',
      description: `Enrollment for ${course?.title || 'Course'}`,
      logo: 'https://academy.trendtacticsdigital.com/images/Trendtactics-logo - Copy.jpg',
    },
  };

  // Paystack configuration
  const paystackConfig = {
    reference: `PAY-${Date.now()}-${user?.id || 'guest'}-${course?.id}`,
    email: user?.email || 'guest@example.com',
    amount: paystackAmount,
    currency: currencyData.paystack_code,
    publicKey: process.env.REACT_APP_PAYSTACK_PUBLIC_KEY || 'pk_test_xxxxx',
    metadata: {
      user_id: user?.id,
      course_id: course?.id,
      course_title: course?.title,
      custom_fields: [
        {
          display_name: "Course",
          variable_name: "course_title",
          value: course?.title
        }
      ]
    }
  };

  const handleFlutterPayment = useFlutterwave(flutterwaveConfig);

  const onPaystackSuccess = async (reference) => {
    console.log('Paystack payment success:', reference);
    setIsProcessing(true);

    try {
      await onPaymentSuccess(reference);
      alert('Payment successful! You are now enrolled in the course.');
      navigate(`/course.html?id=${course.id}`);
    } catch (error) {
      console.error('Enrollment error:', error);
      alert('Payment successful but enrollment failed. Please contact support.');
    } finally {
      setIsProcessing(false);
    }
  };

  const onPaystackClose = () => {
    setIsProcessing(false);
    alert('Payment cancelled');
  };

  const initializePaystackPayment = usePaystackPayment(paystackConfig);

  const handlePayment = () => {
    setIsProcessing(true);

    if (selectedGateway === 'flutterwave') {
      handleFlutterPayment({
        callback: async (response) => {
          console.log('Flutterwave payment response:', response);
          closePaymentModal();

          if (response.status === 'successful') {
            try {
              await onPaymentSuccess(response);
              alert('Payment successful! You are now enrolled in the course.');
              navigate(`/course.html?id=${course.id}`);
            } catch (error) {
              console.error('Enrollment error:', error);
              alert('Payment successful but enrollment failed. Please contact support.');
            }
          } else {
            alert('Payment failed or was cancelled. Please try again.');
          }

          setIsProcessing(false);
        },
        onClose: () => {
          setIsProcessing(false);
        },
      });
    } else if (selectedGateway === 'paystack') {
      initializePaystackPayment(onPaystackSuccess, onPaystackClose);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl max-w-md w-full p-8 relative">
        {/* Close button */}
        <button
          onClick={onClose}
          className="absolute top-4 right-4 text-gray-400 hover:text-gray-600"
        >
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>

        {/* Content */}
        <div className="text-center">
          <div className="mb-6">
            <div className="w-16 h-16 bg-brand-cyan/10 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-brand-cyan" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
              </svg>
            </div>
            <h2 className="text-2xl font-bold text-gray-900 mb-2">Complete Your Enrollment</h2>
            <p className="text-gray-600">You're one step away from accessing this course</p>
          </div>

          {/* Course Info */}
          <div className="bg-gray-50 rounded-lg p-4 mb-6 text-left">
            <h3 className="font-semibold text-gray-900 mb-2">{course?.title}</h3>
            <div className="flex justify-between items-center">
              <span className="text-gray-600">Course Price:</span>
              <span className="text-2xl font-bold text-brand-cyan">{displayPrice}</span>
            </div>
            <div className="mt-2 text-sm text-gray-500">
              Currency: {currencyData.name}
            </div>
          </div>

          {/* Payment Gateway Selection */}
          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-3">Select Payment Method:</label>
            <div className="grid grid-cols-2 gap-3">
              <button
                onClick={() => setSelectedGateway('flutterwave')}
                className={`p-4 border-2 rounded-lg transition-all ${selectedGateway === 'flutterwave'
                  ? 'border-brand-cyan bg-brand-cyan/5'
                  : 'border-gray-200 hover:border-gray-300'
                  }`}
              >
                <div className="font-semibold text-gray-900">Flutterwave</div>
                <div className="text-xs text-gray-500 mt-1">Card, Bank, USSD</div>
              </button>
              <button
                onClick={() => setSelectedGateway('paystack')}
                className={`p-4 border-2 rounded-lg transition-all ${selectedGateway === 'paystack'
                  ? 'border-brand-cyan bg-brand-cyan/5'
                  : 'border-gray-200 hover:border-gray-300'
                  }`}
              >
                <div className="font-semibold text-gray-900">Paystack</div>
                <div className="text-xs text-gray-500 mt-1">Card, Bank, USSD</div>
              </button>
            </div>
          </div>

          {/* Payment Button */}
          <button
            onClick={handlePayment}
            disabled={isProcessing}
            className="btn-primary w-full py-3 text-lg disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {isProcessing ? (
              <span className="flex items-center justify-center gap-2">
                <svg className="animate-spin h-5 w-5" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                </svg>
                Processing...
              </span>
            ) : (
              `Pay ${displayPrice} with ${selectedGateway === 'flutterwave' ? 'Flutterwave' : 'Paystack'}`
            )}
          </button>

          {/* Security Notice */}
          <p className="text-xs text-gray-500 mt-4">
            🔒 Secure payment powered by {selectedGateway === 'flutterwave' ? 'Flutterwave' : 'Paystack'}
          </p>
        </div>
      </div>
    </div>
  );
};

export default PaymentModal;