/**
 * TrendTactics Academy Design System
 * Professional brand colors: Navy Blue + Cyan
 */

export const theme = {
  colors: {
    // Primary Brand Colors
    primary: {
      navy: '#0A1F44',        // Deep Navy Blue
      navyLight: '#1a3a6b',   // Lighter Navy
      navyDark: '#050f22',    // Darker Navy
      cyan: '#00D9FF',        // Bright Cyan
      cyanLight: '#33E1FF',   // Light Cyan
      cyanDark: '#00B8D9',    // Dark Cyan
    },
    
    // Neutral Colors
    neutral: {
      white: '#FFFFFF',
      gray50: '#F9FAFB',
      gray100: '#F3F4F6',
      gray200: '#E5E7EB',
      gray300: '#D1D5DB',
      gray400: '#9CA3AF',
      gray500: '#6B7280',
      gray600: '#4B5563',
      gray700: '#374151',
      gray800: '#1F2937',
      gray900: '#111827',
      black: '#000000',
    },
    
    // Semantic Colors
    success: '#10B981',
    warning: '#F59E0B',
    error: '#EF4444',
    info: '#3B82F6',
    
    // Gradients
    gradients: {
      primary: 'linear-gradient(135deg, #0A1F44 0%, #1a3a6b 100%)',
      cyan: 'linear-gradient(135deg, #00B8D9 0%, #00D9FF 100%)',
      hero: 'linear-gradient(135deg, #0A1F44 0%, #1a3a6b 50%, #00B8D9 100%)',
      card: 'linear-gradient(135deg, rgba(10, 31, 68, 0.95) 0%, rgba(26, 58, 107, 0.95) 100%)',
    },
  },
  
  // Typography
  typography: {
    fontFamily: {
      sans: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
      mono: 'Monaco, Consolas, "Liberation Mono", "Courier New", monospace',
    },
    fontSize: {
      xs: '0.75rem',      // 12px
      sm: '0.875rem',     // 14px
      base: '1rem',       // 16px
      lg: '1.125rem',     // 18px
      xl: '1.25rem',      // 20px
      '2xl': '1.5rem',    // 24px
      '3xl': '1.875rem',  // 30px
      '4xl': '2.25rem',   // 36px
      '5xl': '3rem',      // 48px
      '6xl': '3.75rem',   // 60px
    },
    fontWeight: {
      light: 300,
      normal: 400,
      medium: 500,
      semibold: 600,
      bold: 700,
      extrabold: 800,
    },
  },
  
  // Spacing
  spacing: {
    xs: '0.25rem',   // 4px
    sm: '0.5rem',    // 8px
    md: '1rem',      // 16px
    lg: '1.5rem',    // 24px
    xl: '2rem',      // 32px
    '2xl': '3rem',   // 48px
    '3xl': '4rem',   // 64px
    '4xl': '6rem',   // 96px
  },
  
  // Border Radius
  borderRadius: {
    none: '0',
    sm: '0.25rem',   // 4px
    md: '0.5rem',    // 8px
    lg: '0.75rem',   // 12px
    xl: '1rem',      // 16px
    '2xl': '1.5rem', // 24px
    full: '9999px',
  },
  
  // Shadows
  shadows: {
    sm: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
    md: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
    lg: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
    xl: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
    '2xl': '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
    inner: 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.06)',
    glow: '0 0 20px rgba(0, 217, 255, 0.3)',
    glowStrong: '0 0 40px rgba(0, 217, 255, 0.5)',
  },
  
  // Transitions
  transitions: {
    fast: '150ms cubic-bezier(0.4, 0, 0.2, 1)',
    base: '300ms cubic-bezier(0.4, 0, 0.2, 1)',
    slow: '500ms cubic-bezier(0.4, 0, 0.2, 1)',
    bounce: '500ms cubic-bezier(0.68, -0.55, 0.265, 1.55)',
  },
  
  // Z-Index
  zIndex: {
    dropdown: 1000,
    sticky: 1020,
    fixed: 1030,
    modalBackdrop: 1040,
    modal: 1050,
    popover: 1060,
    tooltip: 1070,
  },
  
  // Breakpoints
  breakpoints: {
    sm: '640px',
    md: '768px',
    lg: '1024px',
    xl: '1280px',
    '2xl': '1536px',
  },
};

export type Theme = typeof theme;

// Helper function to get theme values
export const getThemeValue = (path: string): any => {
  return path.split('.').reduce((obj, key) => obj?.[key], theme as any);
};

export default theme;

