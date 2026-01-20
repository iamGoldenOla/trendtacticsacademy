import React from 'react';
import CookieConsent from 'react-cookie-consent';

const CookieBanner = () => {
    const handleAccept = () => {
        // Enable analytics and tracking
        console.log('User accepted all cookies');
        localStorage.setItem('cookieConsent', 'all');

        // Initialize analytics here (Google Analytics, etc.)
        // window.gtag('consent', 'update', {
        //   analytics_storage: 'granted'
        // });
    };

    const handleDecline = () => {
        // Only essential cookies
        console.log('User declined non-essential cookies');
        localStorage.setItem('cookieConsent', 'essential');

        // Disable analytics
        // window.gtag('consent', 'update', {
        //   analytics_storage: 'denied'
        // });
    };

    return (
        <CookieConsent
            location="bottom"
            buttonText="Accept All Cookies"
            declineButtonText="Essential Only"
            enableDeclineButton
            onAccept={handleAccept}
            onDecline={handleDecline}
            cookieName="trendtactics_cookie_consent"
            style={{
                background: '#0A1628',
                padding: '20px',
                alignItems: 'center'
            }}
            buttonStyle={{
                background: '#00D9FF',
                color: '#0A1628',
                fontSize: '14px',
                fontWeight: '600',
                borderRadius: '6px',
                padding: '12px 24px',
                border: 'none',
                cursor: 'pointer'
            }}
            declineButtonStyle={{
                background: 'transparent',
                color: '#FFFFFF',
                fontSize: '14px',
                fontWeight: '600',
                borderRadius: '6px',
                padding: '12px 24px',
                border: '1px solid rgba(255, 255, 255, 0.3)',
                cursor: 'pointer'
            }}
            expires={365}
        >
            <div style={{ maxWidth: '800px' }}>
                <h3 style={{ margin: '0 0 8px 0', fontSize: '18px', fontWeight: '700', color: '#FFFFFF' }}>
                    🍪 We Value Your Privacy
                </h3>
                <p style={{ margin: '0', fontSize: '14px', color: 'rgba(255, 255, 255, 0.9)', lineHeight: '1.6' }}>
                    We use cookies to enhance your learning experience, analyze site traffic, and personalize content.
                    By clicking "Accept All Cookies", you consent to our use of cookies.{' '}
                    <a
                        href="/privacy-policy"
                        style={{ color: '#00D9FF', textDecoration: 'underline' }}
                    >
                        Learn more about our Privacy Policy
                    </a>
                </p>
            </div>
        </CookieConsent>
    );
};

export default CookieBanner;
