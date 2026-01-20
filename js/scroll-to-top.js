/**
 * Universal Scroll-to-Top Solution
 * Ensures all pages load from the top regardless of navigation method
 */

(function () {
    'use strict';

    // Function to scroll to top
    function scrollToTop(behavior = 'instant') {
        window.scrollTo({
            top: 0,
            left: 0,
            behavior: behavior
        });

        // Fallback for older browsers
        document.documentElement.scrollTop = 0;
        document.body.scrollTop = 0;
    }

    // 1. Scroll to top on page load
    window.addEventListener('load', function () {
        scrollToTop('instant');
    });

    // 2. Scroll to top on DOMContentLoaded (earlier than load)
    document.addEventListener('DOMContentLoaded', function () {
        scrollToTop('instant');
    });

    // 3. Scroll to top on history navigation (back/forward buttons)
    window.addEventListener('popstate', function () {
        scrollToTop('smooth');
    });

    // 4. Scroll to top on hash change
    window.addEventListener('hashchange', function (e) {
        // Only scroll if not navigating to a specific anchor
        if (!window.location.hash || window.location.hash === '#') {
            scrollToTop('smooth');
        }
    });

    // 5. Intercept link clicks and scroll to top
    document.addEventListener('click', function (e) {
        const link = e.target.closest('a');
        if (link && link.href) {
            const currentDomain = window.location.origin;
            const linkUrl = new URL(link.href, currentDomain);

            // If it's an internal link (same domain) and not an anchor link
            if (linkUrl.origin === currentDomain && !linkUrl.hash) {
                // Let the navigation happen, but scroll will be handled by load event
                setTimeout(() => scrollToTop('instant'), 0);
            }
        }
    });

    // 6. For SPA-style navigation (if using pushState/replaceState)
    const originalPushState = history.pushState;
    const originalReplaceState = history.replaceState;

    history.pushState = function () {
        originalPushState.apply(this, arguments);
        scrollToTop('smooth');
    };

    history.replaceState = function () {
        originalReplaceState.apply(this, arguments);
        scrollToTop('smooth');
    };

    // 7. Immediate scroll on script execution
    scrollToTop('instant');

})();
