import SplashCursor from './components/SplashCursor';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import About from './components/About';
import TechStack from './components/TechStack';
import Projects from './components/Projects';
import Certificates from './components/Certificates';
import Contact from './components/Contact';
import Footer from './components/Footer';

function App() {
  return (
    <>
      <SplashCursor />
      <div className="min-h-screen bg-black text-white overflow-x-hidden">
        <Navbar />
        <main>
          <Hero />
          <About />
          <TechStack />
          <Projects />
          <Certificates />
          <Contact />
        </main>
        <Footer />
      </div>
    </>
  );
}

export default App;
