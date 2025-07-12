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
- **Custom Animations** - SplitText, Typewriter, ScrollReveal, and TrueFocus components
- **Docker Ready** - Easy deployment with Docker and nginx
- **HTTPS Support** - Production-ready with SSL/TLS encryption

## 🚀 Live Demo

Visit the live portfolio: afrizz.my.id

## 🛠️ Tech Stack

### Frontend Technologies
- **Frontend Framework**: React 19.1.0
- **Language**: TypeScript 5.8.3
- **Styling**: Tailwind CSS 4.1.11
- **Build Tool**: Vite 7.0.3
- **Animations**: Framer Motion 12.23.0, GSAP 3.13.0
- **Icons**: React Icons 5.5.0

### Backend & DevOps
- **Runtime**: Node.js
- **Database**: MySQL
- **Web Server**: Apache, Nginx
- **Containerization**: Docker
- **Deployment**: Docker Compose

### Programming Languages
- **Frontend**: HTML5, CSS3, JavaScript, TypeScript
- **Backend**: Python, Node.js

## 📦 Installation

### Prerequisites

- Node.js (v20.19+ or v22.12+)
- npm or yarn

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/ucupp19/portfolio.git
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
│   │   ├── python.png
│   │   ├── javascripts.png
│   │   ├── freecodecamp.png
│   │   ├── networkingbasic.png
│   │   └── networkingdevice.png
│   └── projects/         # Project screenshots
│       ├── LyricsVisualizer.png
│       ├── LyricsAM.png
│       └── DiscordBot.png
├── src/
│   ├── components/       # React components
│   │   ├── About.tsx
│   │   ├── AnimatedContent.tsx
│   │   ├── Certificates.tsx
│   │   ├── Contact.tsx
│   │   ├── Footer.tsx
│   │   ├── Hero.tsx
│   │   ├── Navbar.tsx
│   │   ├── Projects.tsx
│   │   ├── ScrollReveal.tsx
│   │   ├── SplashCursor.tsx
│   │   ├── SplitText.tsx
│   │   ├── TechStack.tsx
│   │   ├── TrueFocus.tsx
│   │   └── Typewriter.tsx
│   ├── App.tsx           # Main application component
│   ├── main.tsx          # Application entry point
│   └── index.css         # Global styles
├── Dockerfile            # Docker configuration
├── docker-compose.yml    # Docker Compose setup
├── nginx.conf           # Nginx configuration
└── package.json         # Dependencies and scripts
```

## 🎯 Featured Projects

### 1. Lyrics Visualizer
A web application that visualizes song lyrics with dynamic animations and effects. Built with modern web technologies to create an immersive music experience.

**GitHub**: [lyrics-visualizer](https://github.com/ucupp19/lyrics-visualizer)

### 2. Lyrics Music AM
A comprehensive music application that displays synchronized lyrics with music playback. Features include real-time lyrics display and music controls.

**GitHub**: [LyricsMusicAM](https://github.com/ucupp19/LyricsMusicAM)

### 3. Discord Bot
A feature-rich Discord bot with various utilities and entertainment features. Includes moderation tools, music playback, and interactive commands.

**GitHub**: [MALAZ-BOTT](https://github.com/ucupp19/MALAZ-BOTT)

## 🏆 Certifications

- **Dicoding Python** - Python Programming Certification
- **JavaScript Freecodecamp** - JavaScript Algorithms and Data Structures
- **Responsive Web Design Freecodecamp** - Responsive Web Design Certification
- **Networking Basic Cisco** - Cisco Networking Fundamentals
- **Networking Device Cisco** - Cisco Device Configuration

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
- **Custom Components** - SplitText, Typewriter, ScrollReveal, TrueFocus

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

- **Name**: Afrizz
- **Email**: yusufafaris@gmail.com
- **GitHub**: [github.com/ucupp19](https://github.com/ucupp19)
- **Instagram**: [@afrizzz19](https://www.instagram.com/afrizzz19/)

---

⭐ If you found this portfolio helpful, please give it a star!
