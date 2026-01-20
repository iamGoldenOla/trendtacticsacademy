// ==========================================
// MULTI-CURRENCY SYSTEM
// Base price: $3 USD
// ==========================================

const CURRENCY_CONFIG = {
    base_price_usd: 3.00,

    currencies: {
        'USD': {
            symbol: '$',
            name: 'US Dollar',
            rate: 1.00,
            format: (amount) => `$${amount.toFixed(2)}`
        },
        'NGN': {
            symbol: '₦',
            name: 'Nigerian Naira',
            rate: 1500, // $1 = ₦1500 (approximate)
            format: (amount) => `₦${amount.toLocaleString('en-NG', { maximumFractionDigits: 0 })}`
        },
        'EUR': {
            symbol: '€',
            name: 'Euro',
            rate: 0.92, // $1 = €0.92 (approximate)
            format: (amount) => `€${amount.toFixed(2)}`
        },
        'GBP': {
            symbol: '£',
            name: 'British Pound',
            rate: 0.79, // $1 = £0.79 (approximate)
            format: (amount) => `£${amount.toFixed(2)}`
        },
        'CAD': {
            symbol: 'C$',
            name: 'Canadian Dollar',
            rate: 1.35, // $1 = C$1.35 (approximate)
            format: (amount) => `C$${amount.toFixed(2)}`
        },
        'AUD': {
            symbol: 'A$',
            name: 'Australian Dollar',
            rate: 1.52, // $1 = A$1.52 (approximate)
            format: (amount) => `A$${amount.toFixed(2)}`
        }
    },

    // Get user's preferred currency from localStorage
    getUserCurrency: function () {
        return localStorage.getItem('preferred_currency') || 'USD';
    },

    // Set user's preferred currency
    setUserCurrency: function (currency) {
        localStorage.setItem('preferred_currency', currency);
    },

    // Convert price to selected currency
    convertPrice: function (currency = null) {
        const selectedCurrency = currency || this.getUserCurrency();
        const currencyData = this.currencies[selectedCurrency];

        if (!currencyData) return this.currencies.USD.format(this.base_price_usd);

        const convertedAmount = this.base_price_usd * currencyData.rate;
        return currencyData.format(convertedAmount);
    },

    // Get all prices for display
    getAllPrices: function () {
        const prices = {};
        for (const [code, data] of Object.entries(this.currencies)) {
            const amount = this.base_price_usd * data.rate;
            prices[code] = {
                formatted: data.format(amount),
                amount: amount,
                symbol: data.symbol,
                name: data.name
            };
        }
        return prices;
    }
};

// Currency Selector Component (HTML)
function createCurrencySelector() {
    const currentCurrency = CURRENCY_CONFIG.getUserCurrency();

    return `
        <div class="currency-selector" style="
            background: rgba(255, 255, 255, 0.05);
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 8px;
        ">
            <span style="font-size: 0.85rem; color: var(--text-dim);">💰</span>
            <select id="currencySelect" onchange="handleCurrencyChange(this.value)" style="
                background: var(--bg-card);
                color: var(--text-main);
                border: 1px solid var(--border);
                padding: 5px 10px;
                border-radius: 4px;
                font-size: 0.85rem;
                cursor: pointer;
                outline: none;
            ">
                ${Object.entries(CURRENCY_CONFIG.currencies).map(([code, data]) =>
        `<option value="${code}" ${code === currentCurrency ? 'selected' : ''}>
                        ${data.symbol} ${code}
                    </option>`
    ).join('')}
            </select>
        </div>
    `;
}

// Handle currency change
function handleCurrencyChange(newCurrency) {
    CURRENCY_CONFIG.setUserCurrency(newCurrency);

    // Update all prices on the page
    updateAllPrices();

    // Show notification
    const currencyData = CURRENCY_CONFIG.currencies[newCurrency];
    showNotification(`Currency changed to ${currencyData.name} (${currencyData.symbol})`);
}

// Update all price displays
function updateAllPrices() {
    const priceElements = document.querySelectorAll('[data-price]');
    const currentCurrency = CURRENCY_CONFIG.getUserCurrency();

    priceElements.forEach(element => {
        element.textContent = CURRENCY_CONFIG.convertPrice(currentCurrency);
    });
}

// Show notification
function showNotification(message) {
    const notification = document.createElement('div');
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: var(--primary);
        color: var(--bg-deep);
        padding: 12px 20px;
        border-radius: 6px;
        font-weight: 600;
        z-index: 10000;
        animation: slideIn 0.3s ease;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 2000);
}

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

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    updateAllPrices();
});

// Export for use in other files
if (typeof module !== 'undefined' && module.exports) {
    module.exports = CURRENCY_CONFIG;
}
