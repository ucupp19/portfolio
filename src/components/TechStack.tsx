import { motion } from 'framer-motion';
import { useInView } from 'framer-motion';
import { useRef } from 'react';
import TrueFocus from './TrueFocus';


import {
    SiHtml5,
    SiCss3,
    SiJavascript,
    SiTypescript,
    SiReact,
    SiVite,
    SiNextdotjs,
    SiTailwindcss,
    SiPython,
    SiMysql,
    SiNodedotjs,
    SiApache,
    SiNginx,
    SiDocker
} from 'react-icons/si';

const TechStack = () => {
    const ref = useRef(null);
    const isInView = useInView(ref); // Animation repeats every time in view

    const techItems = [
        { name: 'HTML', icon: <SiHtml5 />, color: 'text-orange-500' },
        { name: 'CSS', icon: <SiCss3 />, color: 'text-blue-500' },
        { name: 'JAVASCRIPT', icon: <SiJavascript />, color: 'text-yellow-400' },
        { name: 'TYPESCRIPT', icon: <SiTypescript />, color: 'text-blue-600' },
        { name: 'REACT', icon: <SiReact />, color: 'text-cyan-400' },
        { name: 'VITE', icon: <SiVite />, color: 'text-purple-500' },
        { name: 'NEXT JS', icon: <SiNextdotjs />, color: 'text-white' },
        { name: 'TAILWIND CSS', icon: <SiTailwindcss />, color: 'text-cyan-500' },
        { name: 'PYTHON', icon: <SiPython />, color: 'text-blue-500' },
        { name: 'MYSQL', icon: <SiMysql />, color: 'text-blue-600' },
        { name: 'NODE JS', icon: <SiNodedotjs />, color: 'text-green-500' },
        { name: 'APACHE', icon: <SiApache />, color: 'text-red-500' },
        { name: 'NGINX', icon: <SiNginx />, color: 'text-green-600' },
        { name: 'DOCKER', icon: <SiDocker />, color: 'text-blue-500' },
    ];

    return (
        <section id="tech" className="py-20 px-4">
            <div className="max-w-6xl mx-auto">

                <motion.div
                    ref={ref}
                    initial={{ opacity: 0, y: 100 }}
                    animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 100 }}
                    transition={{ duration: 0.8 }}
                    className=" text-center"
                >
                    <TrueFocus
                        sentence="Tech Stack"
                        manualMode={false}
                        blurAmount={5}
                        borderColor="blue"
                        animationDuration={2}
                        pauseBetweenAnimations={1}
                    />


                    <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-6">
                        {techItems.map((tech, index) => (
                            <motion.div
                                key={tech.name}
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={isInView ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0.8 }}
                                transition={{ duration: 0.5, delay: index * 0.1 }}
                                className="mt-12 flex flex-col items-center p-4 rounded-lg bg-white/5 hover:bg-white/10 transition-colors duration-200 group"
                            >
                                <span className={`text-4xl mb-2 group-hover:scale-110 transition-transform duration-200 ${tech.color}`}>
                                    {tech.icon}
                                </span>
                                <span className="text-sm font-figtree font-light text-center">
                                    {tech.name}
                                </span>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            </div>
        </section>
    );
};

export default TechStack; 