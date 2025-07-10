import { motion } from 'framer-motion';
import SplitText from './SplitText';
import Typewriter from './Typewriter';

const Hero = () => {
    return (
        <section id="home" className="min-h-screen flex items-center justify-center pt-16">
            <div className="text-center">
                <motion.h1
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                    className="text-4xl sm:text-6xl md:text-8xl font-poppins font-bold mb-6 break-words mb-10 sm:mb-10 md:mb-20"
                >
                    <Typewriter /> I'm Afrizz
                </motion.h1>

                <SplitText
                    text="Full Stack Web Developer"
                    className="text-2xl font-semibold text-center sm:mb-5 md:mb-5"
                    delay={10}
                    duration={3}
                    ease="power3.out"
                    splitType="chars"
                    from={{ opacity: 0, y: 40 }}
                    to={{ opacity: 1, y: 0 }}
                    threshold={0.1}
                    rootMargin="-100px"
                    textAlign="center"
                />


                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8, delay: 0.4 }}
                    className="mt-8"
                >
                    <button
                        onClick={() => document.getElementById('contact')?.scrollIntoView({ behavior: 'smooth' })}
                        className="mb-50 sm:mb-40 md:mb-30 px-8 py-3 bg-white text-black font-medium rounded-lg hover:bg-gray-200 transition-colors duration-200"
                    >
                        Contact Me
                    </button>
                </motion.div>
            </div>
        </section>
    );
};

export default Hero; 