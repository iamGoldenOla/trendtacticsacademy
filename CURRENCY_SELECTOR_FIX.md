# 🔧 Currency Selector Fix - Simple Embedded Version

## ❌ **Problem:**
Currency selector not showing because `currency.js` file may not be loading properly.

## ✅ **Solution:**
Embed the currency selector code directly in `course.html` instead of using a separate JS file.

---

## 📋 **Quick Fix Instructions:**

### **Option 1: Add Inline Currency Selector** ⭐ EASIEST

Add this code to `course.html` right after the Google Translate div (around line 543):

```html
<!-- Currency Selector -->
<div style="margin-top: 10px; background: rgba(255, 255, 255, 0.05); padding: 8px 12px; border-radius: 6px; border: 1px solid var(--border); display: flex; align-items: center; gap: 8px;">
    <span style="font-size: 0.85rem; color: var(--text-dim);">💰</span>
    <select id="currencySelect" onchange="changeCurrency(this.value)" style="background: var(--bg-card); color: var(--text-main); border: 1px solid var(--border); padding: 5px 10px; border-radius: 4px; font-size: 0.85rem; cursor: pointer; outline: none;">
        <option value="USD">$ USD</option>
        <option value="NGN">₦ NGN</option>
        <option value="EUR">€ EUR</option>
        <option value="GBP">£ GBP</option>
        <option value="CAD">C$ CAD</option>
        <option value="AUD">A$ AUD</option>
    </select>
</div>

<script>
// Currency conversion logic
const CURRENCY_RATES = {
    'USD': { symbol: '$', rate: 1.00, name: 'US Dollar' },
    'NGN': { symbol: '₦', rate: 1500, name: 'Nigerian Naira' },
    'EUR': { symbol: '€', rate: 0.92, name: 'Euro' },
    'GBP': { symbol: '£', rate: 0.79, name: 'British Pound' },
    'CAD': { symbol: 'C$', rate: 1.35, name: 'Canadian Dollar' },
    'AUD': { symbol: 'A$', rate: 1.52, name: 'Australian Dollar' }
};

const BASE_PRICE = 3.00; // USD

function changeCurrency(currency) {
    localStorage.setItem('preferred_currency', currency);
    const currencyData = CURRENCY_RATES[currency];
    const convertedPrice = (BASE_PRICE * currencyData.rate).toFixed(2);
    
    // Show notification
    const notification = document.createElement('div');
    notification.style.cssText = 'position: fixed; top: 20px; right: 20px; background: var(--primary); color: var(--bg-deep); padding: 12px 20px; border-radius: 6px; font-weight: 600; z-index: 10000;';
    notification.textContent = `Currency changed to ${currencyData.name} (${currencyData.symbol})`;
    document.body.appendChild(notification);
    
    setTimeout(() => notification.remove(), 2000);
}

// Load saved currency on page load
window.addEventListener('DOMContentLoaded', () => {
    const savedCurrency = localStorage.getItem('preferred_currency') || 'USD';
    const select = document.getElementById('currencySelect');
    if (select) select.value = savedCurrency;
});
</script>
```

---

## 📍 **Where to Add:**

Find this section in `course.html` (around line 541-543):

```html
<!-- Language Selector -->
<div id="google_translate_element" style="margin-top: 10px;"></div>

<!-- ADD THE CURRENCY SELECTOR CODE HERE -->

<div style="margin-top:15px; background:rgba(255,255,255,0.1)...
```

---

## ✅ **After Adding:**

1. Save `course.html`
2. Upload to server
3. Clear browser cache (Ctrl+Shift+R)
4. Reload page
5. Currency selector should appear!

---

## 🎯 **What You'll See:**

- 💰 Currency dropdown in sidebar
- 6 currencies available (USD, NGN, EUR, GBP, CAD, AUD)
- Notification when changing currency
- Preference saved automatically

---

## 💡 **Why This Works:**

- ✅ No separate JS file needed
- ✅ All code in one place
- ✅ No file loading issues
- ✅ Simpler to debug

---

## 🔧 **If Still Not Showing:**

1. Check browser console (F12) for errors
2. Verify the code is in the correct location
3. Make sure you're looking at the right page (course viewer, not dashboard)
4. Try a different browser

---

## 📊 **Currency Prices:**

| Currency | Price |
|----------|-------|
| USD | $3.00 |
| NGN | ₦4,500 |
| EUR | €2.76 |
| GBP | £2.37 |
| CAD | C$4.05 |
| AUD | A$4.56 |

**This embedded version is simpler and more reliable!** 🎉
