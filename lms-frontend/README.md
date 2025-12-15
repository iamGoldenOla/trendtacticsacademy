# Trendtactics Academy LMS Frontend

A modern, responsive Learning Management System (LMS) built with React, TypeScript, and Tailwind CSS.

## 🚀 Features

- **Modern Design**: Clean, professional UI with mobile-first responsive design
- **TypeScript**: Full type safety and better development experience
- **Tailwind CSS**: Utility-first CSS framework for rapid styling
- **Component-Based**: Modular, reusable components
- **Accessibility**: WCAG compliant with proper ARIA labels and keyboard navigation
- **SEO Optimized**: Meta tags, semantic HTML, and performance optimized
- **AI-Powered Course Creation**: Conversational course creation with Trendy AI assistant
- **Interactive Learning**: Dynamic content generation and personalized recommendations

## 🎨 Design System

### Colors
- **Primary Navy**: `#1e3a8a` - Main brand color
- **Cyan**: `#06b6d4` - Accent color
- **White**: `#ffffff` - Background color

### Typography
- **Headings**: Poppins (Bold, professional)
- **Body Text**: Inter (Clean, readable)
- **UI Elements**: DM Sans (Modern, accessible)

### Components
- `.btn-primary` - Primary action buttons
- `.btn-secondary` - Secondary action buttons
- `.card` - Content containers
- `.input-field` - Form inputs

## 📁 Project Structure

```
src/
├── components/                 # Reusable UI components
│   ├── Header.tsx             # Navigation header
│   ├── Footer.tsx             # Site footer
│   ├── TrendyAssistant.js     # AI assistant chat widget
│   └── ...
├── pages/                     # Page components
│   ├── Home.tsx               # Homepage
│   ├── CourseCreator.js       # Conversational course creation
│   ├── ConversationalCourseTest.js  # Test page for course creation
│   ├── ConversationalDemo.js  # Demo visualization
│   └── ...
├── services/                  # API and external service integrations
│   ├── puterService.js        # Puter.js AI integration
│   └── ...
├── demo/                      # Demonstration files
│   ├── conversationalCourseDemo.js  # Demo data and functions
│   └── README.md              # Demo documentation
├── types/                     # TypeScript type definitions
│   └── index.ts               # Main type definitions
├── assets/                    # Static assets
├── utils/                     # Utility functions
├── hooks/                     # Custom React hooks
└── App.tsx                    # Main app component
```

## 🛠️ Tech Stack

- **React 19** - UI library
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **PostCSS** - CSS processing
- **Vite** - Build tool (via Create React App)

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ 
- npm or yarn

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd lms-frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development server**
   ```bash
   npm start
   ```

4. **Open your browser**
   Navigate to `http://localhost:3000`

### Available Scripts

- `npm start` - Start development server
- `npm build` - Build for production
- `npm test` - Run tests
- `npm eject` - Eject from Create React App

## 📱 Responsive Design

The application is built with a mobile-first approach:

- **Mobile**: < 768px
- **Tablet**: 768px - 1024px  
- **Desktop**: > 1024px

## 🎯 Key Components

### Header Component
- Responsive navigation
- User authentication state
- Mobile menu toggle
- Brand logo and navigation links

### Home Page
- Hero section with call-to-action
- Statistics showcase
- Feature highlights
- Featured courses grid
- Call-to-action section

### Footer Component
- Company information
- Navigation links
- Social media links
- Copyright information

### Trendy AI Assistant
- Floating chat widget for conversational interactions
- Course creation assistance
- Personalized recommendations
- Real-time responses powered by puter.js

### Course Creator
- Conversational course creation interface
- Interactive content generation
- User preference collection
- Course outline generation

## 🔧 Customization

### Adding New Components
1. Create component in `src/components/`
2. Export from component file
3. Import and use in pages

### Styling
- Use Tailwind CSS classes for styling
- Custom styles in `src/index.css`
- Component-specific styles in component files

### Routing
- Main course creation: `/course-creator`
- Interactive test page: `/conversational-course-test`
- Demo visualization: `/conversational-demo`

### TypeScript Types
- Define interfaces in `src/types/index.ts`
- Import and use throughout components

## 📦 Deployment

### Build for Production
```bash
npm run build
```

### Deploy Options
- **Netlify**: Drag and drop `build` folder
- **Vercel**: Connect GitHub repository
- **AWS S3**: Upload `build` folder
- **cPanel**: Upload via File Manager

## 🔍 SEO Features

- Semantic HTML structure
- Meta tags for social sharing
- Open Graph tags
- Twitter Card support
- Structured data markup
- Performance optimization

## ♿ Accessibility

- WCAG 2.1 AA compliant
- Keyboard navigation support
- Screen reader friendly
- High contrast ratios
- Focus indicators
- ARIA labels

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Built with ❤️ by Trendtactics Digital**
