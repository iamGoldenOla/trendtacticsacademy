// ==========================================
// CURRENCY SELECTOR - STANDALONE VERSION
// Add this script to your index.html
// ==========================================

(function () {
    'use strict';

    const CURRENCY_RATES = {
        'USD': { symbol: '$', rate: 1.00, name: 'US Dollar' },
        'NGN': { symbol: '₦', rate: 1500, name: 'Nigerian Naira' },
        'EUR': { symbol: '€', rate: 0.92, name: 'Euro' },
        'GBP': { symbol: '£', rate: 0.79, name: 'British Pound' },
        'CAD': { symbol: 'C$', rate: 1.35, name: 'Canadian Dollar' },
        'AUD': { symbol: 'A$', rate: 1.52, name: 'Australian Dollar' }
    };

    const BASE_PRICE = 3.00;

    // Get/Set currency preference
    function getCurrency() {
        return localStorage.getItem('preferred_currency') || 'USD';
    }

    function setCurrency(currency) {
        localStorage.setItem('preferred_currency', currency);
        updateAllPrices();
        showNotification(CURRENCY_RATES[currency].name);
    }

    // Format price
    function formatPrice(priceUSD = BASE_PRICE) {
        const currency = getCurrency();
        const currencyData = CURRENCY_RATES[currency];
        const convertedAmount = priceUSD * currencyData.rate;

        if (currency === 'NGN') {
            return `${currencyData.symbol}${convertedAmount.toLocaleString('en-NG', { maximumFractionDigits: 0 })}`;
        }
        return `${currencyData.symbol}${convertedAmount.toFixed(2)}`;
    }

    // Update all prices on page
    function updateAllPrices() {
        // Find all price elements (you may need to adjust selectors)
        const priceElements = document.querySelectorAll('[data-price]');
        priceElements.forEach(el => {
            const basePrice = parseFloat(el.getAttribute('data-price')) || BASE_PRICE;
            el.textContent = formatPrice(basePrice);
        });
    }

    // Show notification
    function showNotification(currencyName) {
        const notification = document.createElement('div');
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #00D9FF;
            color: #050B18;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: 600;
            z-index: 10000;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            animation: slideIn 0.3s ease;
        `;
        notification.textContent = `Currency: ${currencyName}`;
        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => notification.remove(), 300);
        }, 2000);
    }

    // Create currency selector
    function createCurrencySelector() {
        const container = document.createElement('div');
        container.className = 'currency-selector-widget';
        container.style.cssText = `
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.05);
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        `;

        const icon = document.createElement('span');
        icon.textContent = '💰';
        icon.style.fontSize = '0.85rem';

        const select = document.createElement('select');
        select.style.cssText = `
            background: #0A1628;
            color: #FFFFFF;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            outline: none;
        `;

        Object.entries(CURRENCY_RATES).forEach(([code, data]) => {
            const option = document.createElement('option');
            option.value = code;
            option.textContent = `${data.symbol} ${code}`;
            if (code === getCurrency()) {
                option.selected = true;
            }
            select.appendChild(option);
        });

        select.addEventListener('change', (e) => {
            setCurrency(e.target.value);
        });

        container.appendChild(icon);
        container.appendChild(select);

        return container;
    }

    // Initialize on page load
    function init() {
        // Add CSS animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from { transform: translateX(400px); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes slideOut {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(400px); opacity: 0; }
            }
        `;
        document.head.appendChild(style);

        // Add currency selector to page (adjust selector as needed)
        const targetElement = document.querySelector('.filters') || document.querySelector('header');
        if (targetElement) {
            targetElement.appendChild(createCurrencySelector());
        }

        // Update prices on load
        updateAllPrices();
    }

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    // Expose formatPrice globally for use in React components
    window.formatPrice = formatPrice;
    window.getCurrency = getCurrency;
    window.setCurrency = setCurrency;

})();
