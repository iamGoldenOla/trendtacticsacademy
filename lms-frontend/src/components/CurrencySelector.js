import React, { useState, useEffect } from 'react';

const CURRENCY_RATES = {
    'USD': { symbol: '$', rate: 1.00, name: 'US Dollar' },
    'NGN': { symbol: '₦', rate: 1500, name: 'Nigerian Naira' },
    'EUR': { symbol: '€', rate: 0.92, name: 'Euro' },
    'GBP': { symbol: '£', rate: 0.79, name: 'British Pound' },
    'CAD': { symbol: 'C$', rate: 1.35, name: 'Canadian Dollar' },
    'AUD': { symbol: 'A$', rate: 1.52, name: 'Australian Dollar' }
};

const BASE_PRICE = 3.00;

export const CurrencySelector = ({ className = '' }) => {
    const [currency, setCurrency] = useState(
        localStorage.getItem('preferred_currency') || 'USD'
    );

    const handleChange = (e) => {
        const newCurrency = e.target.value;
        setCurrency(newCurrency);
        localStorage.setItem('preferred_currency', newCurrency);

        // Dispatch custom event for other components
        window.dispatchEvent(new CustomEvent('currencyChanged', {
            detail: newCurrency
        }));
    };

    return (
        <div className={`currency-selector ${className}`}>
            <span style={{ marginRight: '8px' }}>💰</span>
            <select
                value={currency}
                onChange={handleChange}
                style={{
                    background: '#0A1628',
                    color: '#FFFFFF',
                    border: '1px solid rgba(255, 255, 255, 0.1)',
                    padding: '8px 12px',
                    borderRadius: '6px',
                    fontSize: '0.9rem',
                    cursor: 'pointer'
                }}
            >
                {Object.entries(CURRENCY_RATES).map(([code, data]) => (
                    <option key={code} value={code}>
                        {data.symbol} {code}
                    </option>
                ))}
            </select>
        </div>
    );
};

export const usePrice = () => {
    const [currency, setCurrency] = useState(
        localStorage.getItem('preferred_currency') || 'USD'
    );

    useEffect(() => {
        const handleCurrencyChange = (e) => {
            setCurrency(e.detail);
        };

        window.addEventListener('currencyChanged', handleCurrencyChange);
        return () => window.removeEventListener('currencyChanged', handleCurrencyChange);
    }, []);

    const formatPrice = (priceUSD = BASE_PRICE) => {
        const currencyData = CURRENCY_RATES[currency];
        const convertedAmount = priceUSD * currencyData.rate;

        if (currency === 'NGN') {
            return `${currencyData.symbol}${convertedAmount.toLocaleString('en-NG', { maximumFractionDigits: 0 })}`;
        }
        return `${currencyData.symbol}${convertedAmount.toFixed(2)}`;
    };

    return { currency, formatPrice };
};

export { CURRENCY_RATES, BASE_PRICE };
