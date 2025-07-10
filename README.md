# Afrizz Portfolio

A modern, responsive portfolio website built with React, TypeScript, and Tailwind CSS. Features smooth animations, interactive components, and a professional design to showcase your skills and projects.

![Portfolio Preview](https://img.shields.io/badge/React-19.1.0-blue?logo=react)
![TypeScript](https://img.shields.io/badge/TypeScript-5.8.3-blue?logo=typescript)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-4.1.11-38B2AC?logo=tailwind-css)
![Vite](https://img.shields.io/badge/Vite-7.0.3-646CFF?logo=vite)

## ✨ Features

- **Modern Design** - Clean, professional layout with smooth animations
- **Responsive** - Fully responsive design that works on all devices
- **Interactive Components** - Engaging animations and hover effects
- **TypeScript** - Type-safe development with better code quality
- **Tailwind CSS** - Utility-first CSS framework for rapid styling
- **Framer Motion** - Smooth animations and transitions
- **GSAP** - Advanced animation library for complex effects
- **React Icons** - Beautiful icon library
- **Docker Ready** - Easy deployment with Docker and nginx
- **HTTPS Support** - Production-ready with SSL/TLS encryption

## 🚀 Live Demo

Visit the live portfolio: [Your Portfolio URL]

## 🛠️ Tech Stack

- **Frontend Framework**: React 19.1.0
- **Language**: TypeScript 5.8.3
- **Styling**: Tailwind CSS 4.1.11
- **Build Tool**: Vite 7.0.3
- **Animations**: Framer Motion 12.23.0, GSAP 3.13.0
- **Icons**: React Icons 5.5.0
- **Deployment**: Docker, nginx

## 📦 Installation

### Prerequisites

- Node.js (v18 or higher)
- npm or yarn

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/portfolio.git
   cd portfolio
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the development server**
   ```bash
   npm run dev
   ```

4. **Open your browser**
   Navigate to `http://localhost:5173`

### Production Build

1. **Build the application**
   ```bash
   npm run build
   ```

2. **Preview the production build**
   ```bash
   npm run start
   ```

## 🐳 Docker Deployment

For production deployment with Docker and HTTPS support, see the [Deployment Guide](README-DEPLOYMENT.md).

### Quick Docker Setup

```bash
# Build and run with Docker Compose
docker-compose up --build -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down
```

## 📁 Project Structure

```
portfolio/
├── public/                 # Static assets
│   ├── certificates/      # Certificate images
│   └── projects/         # Project screenshots
├── src/
│   ├── components/       # React components
│   │   ├── About.tsx
│   │   ├── Certificates.tsx
│   │   ├── Contact.tsx
│   │   ├── Hero.tsx
│   │   ├── Navbar.tsx
│   │   ├── Projects.tsx
│   │   ├── TechStack.tsx
│   │   └── TrueFocus.tsx
│   ├── App.tsx           # Main application component
│   ├── main.tsx          # Application entry point
│   └── index.css         # Global styles
├── Dockerfile            # Docker configuration
├── docker-compose.yml    # Docker Compose setup
├── nginx.conf           # Nginx configuration
└── package.json         # Dependencies and scripts
```

## 🎨 Customization

### Personal Information

Update your personal information in the respective components:

- **Hero.tsx** - Main introduction and call-to-action
- **About.tsx** - Personal background and skills
- **Projects.tsx** - Your projects and work
- **Certificates.tsx** - Your certifications
- **Contact.tsx** - Contact information and form

### Styling

The project uses Tailwind CSS for styling. You can customize:

- Colors in `tailwind.config.js`
- Global styles in `src/index.css`
- Component-specific styles in each component

### Animations

Customize animations using:

- **Framer Motion** - For component animations
- **GSAP** - For complex timeline animations
- **CSS Transitions** - For simple hover effects

## 📝 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Build and preview production build
- `npm run lint` - Run ESLint
- `npm run preview` - Preview production build

## 🔧 Configuration

### Environment Variables

Create a `.env` file for environment-specific configuration:

```env
VITE_APP_TITLE=Your Portfolio Title
VITE_APP_DESCRIPTION=Your portfolio description
```

### Build Configuration

Modify `vite.config.ts` for build-specific settings:

```typescript
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    sourcemap: false,
  },
})
```

## 🚀 Performance

The portfolio is optimized for performance with:

- **Code Splitting** - Automatic code splitting with Vite
- **Image Optimization** - Optimized images and lazy loading
- **Caching** - Proper cache headers for static assets
- **Compression** - Gzip compression enabled
- **Minification** - Minified CSS and JavaScript

## 📱 Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [React](https://reactjs.org/) - UI library
- [Tailwind CSS](https://tailwindcss.com/) - CSS framework
- [Framer Motion](https://www.framer.com/motion/) - Animation library
- [GSAP](https://greensock.com/gsap/) - Animation library
- [React Icons](https://react-icons.github.io/react-icons/) - Icon library
- [Vite](https://vitejs.dev/) - Build tool

## 📞 Contact

- **Name**: [Your Name]
- **Email**: [your.email@example.com]
- **LinkedIn**: [Your LinkedIn]
- **GitHub**: [Your GitHub]

---

⭐ If you found this portfolio helpful, please give it a star!
