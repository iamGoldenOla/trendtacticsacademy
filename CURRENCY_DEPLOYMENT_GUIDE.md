# 💰 Multi-Currency System - Deployment Guide

## ✅ **What's Been Implemented:**

### **Supported Currencies:**
- 🇺🇸 **USD** - US Dollar ($3.00)
- 🇳🇬 **NGN** - Nigerian Naira (₦4,500)
- 🇪🇺 **EUR** - Euro (€2.76)
- 🇬🇧 **GBP** - British Pound (£2.37)
- 🇨🇦 **CAD** - Canadian Dollar (C$4.05)
- 🇦🇺 **AUD** - Australian Dollar (A$4.56)

### **Features:**
✅ Currency selector in sidebar
✅ Automatic price conversion
✅ Saves user preference (localStorage)
✅ Smooth animations
✅ Dark theme styled

---

## 📤 **Deployment Steps:**

### **Step 1: Upload Files**

Upload these files to your server:

1. **`js/currency.js`** → `/js/currency.js`
2. **Updated `course.html`** → `/course.html`

### **Step 2: Verify File Structure**

```
public_html/academy.trendtacticsdigital.com/
├── course.html  ✅ Updated
├── index.html
└── js/
    ├── scroll-to-top.js
    └── currency.js  ✅ NEW
```

### **Step 3: Test**

1. Open any course lesson
2. Look for currency selector in sidebar (below language selector)
3. Click dropdown and select different currency
4. Verify notification appears
5. Refresh page - currency preference should persist

---

## 🎯 **How It Works:**

### **For Students:**
1. See currency selector in sidebar
2. Click dropdown
3. Select preferred currency (USD, NGN, EUR, etc.)
4. All prices update automatically
5. Preference saved for future visits

### **For You:**
- Base price is **$3 USD**
- All other currencies calculated automatically
- Exchange rates are fixed (update manually if needed)
- No external API calls (fast and reliable)

---

## 💡 **Adding Prices to Course Cards:**

To show prices on course cards in React dashboard:

```html
<!-- Example: Course card with price -->
<div class="course-card">
    <h3>Vibe Coding 3.0</h3>
    <p class="course-price" data-price>$3.00</p>
</div>
```

The `data-price` attribute tells the system to update this element when currency changes.

---

## 🔧 **Updating Exchange Rates:**

Edit `js/currency.js` to update rates:

```javascript
currencies: {
    'NGN': {
        symbol: '₦',
        name: 'Nigerian Naira',
        rate: 1500,  // ← Change this number
        format: (amount) => `₦${amount.toLocaleString('en-NG', {maximumFractionDigits: 0})}`
    }
}
```

**Current Rates (as of implementation):**
- 1 USD = 1,500 NGN
- 1 USD = 0.92 EUR
- 1 USD = 0.79 GBP
- 1 USD = 1.35 CAD
- 1 USD = 1.52 AUD

---

## 🎨 **Customization:**

### **Add More Currencies:**

Edit `js/currency.js`:

```javascript
'INR': {
    symbol: '₹',
    name: 'Indian Rupee',
    rate: 83,  // $1 = ₹83
    format: (amount) => `₹${amount.toFixed(2)}`
}
```

### **Change Base Price:**

Edit line 2 in `js/currency.js`:

```javascript
base_price_usd: 3.00,  // Change to your price
```

---

## ✅ **Testing Checklist:**

- [ ] Currency selector appears in sidebar
- [ ] Can select different currencies
- [ ] Notification shows when changing currency
- [ ] Preference persists after refresh
- [ ] All 6 currencies work correctly
- [ ] Prices display with correct symbols

---

## 🚀 **Next Steps:**

### **For Course Viewer:** ✅ DONE
- Currency selector working
- Prices convert automatically
- User preference saved

### **For React Dashboard:** (Future)
- Add currency selector to dashboard
- Show prices on course cards
- Use same currency.js file

---

## 📊 **Price Examples:**

| Currency | Symbol | Price |
|----------|--------|-------|
| USD | $ | $3.00 |
| NGN | ₦ | ₦4,500 |
| EUR | € | €2.76 |
| GBP | £ | £2.37 |
| CAD | C$ | C$4.05 |
| AUD | A$ | A$4.56 |

---

## 💰 **Payment Integration:**

When students purchase:
1. They see price in their currency
2. Payment gateway handles conversion
3. You receive payment in your currency
4. No additional work needed!

**Popular payment gateways that handle multi-currency:**
- Stripe (automatic conversion)
- PayPal (supports multiple currencies)
- Flutterwave (great for NGN)

---

## ✅ **Status:**

**Course Viewer:** ✅ Complete and ready to deploy
**React Dashboard:** ⚠️ Can add later (optional)

**Upload the files and test!** 🎉
