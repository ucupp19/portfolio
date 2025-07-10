import { motion } from 'framer-motion';
import { useInView } from 'framer-motion';
import { useRef } from 'react';
import { FaGithub, FaExternalLinkAlt } from 'react-icons/fa';
import AnimatedContent from './AnimatedContent';

const Projects = () => {
    const ref = useRef(null);
    const isInView = useInView(ref); // Animation repeats every time in view

    const projects = [
        {
            title: 'Lyrics Visualizer',
            description: 'A web application that visualizes song lyrics with dynamic animations and effects. Built with modern web technologies to create an immersive music experience.',
            github: 'https://github.com/ucupp19/lyrics-visualizer',
            image: '/projects/LyricsVisualizer.png'
        },
        {
            title: 'Lyrics Music AM',
            description: 'A comprehensive music application that displays synchronized lyrics with music playback. Features include real-time lyrics display and music controls.',
            github: 'https://github.com/ucupp19/LyricsMusicAM',
            image: '/projects/LyricsAM.png'
        },
        {
            title: 'Discord Bot',
            description: 'A feature-rich Discord bot with various utilities and entertainment features. Includes moderation tools, music playback, and interactive commands.',
            github: 'https://github.com/ucupp19/MALAZ-BOTT',
            image: '/projects/DiscordBot.png'
        }
    ];

    return (
        <section id="projects" className="py-20 px-4">
            <div className="max-w-6xl mx-auto">
                <motion.div
                    ref={ref}
                    initial={{ opacity: 0, y: 100 }}
                    animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 100 }}
                    transition={{ duration: 0.8 }}
                    className="text-center mb-16"
                >
                    <h2 className="text-4xl md:text-5xl font-poppins font-bold">
                        My Projects
                    </h2>
                </motion.div>

                <div className="space-y-20">
                    {projects.map((project, index) => (
                        <AnimatedContent
                            key={project.title}
                            distance={100}
                            direction="horizontal"
                            reverse={index % 2 !== 0}
                            duration={0.8}
                            delay={index * 0.2}
                        >
                            <div className={`flex flex-col ${index % 2 === 0 ? 'lg:flex-row' : 'lg:flex-row-reverse'} items-center gap-8 lg:gap-12`}>
                                <div className="flex-1">
                                    <img
                                        src={project.image}
                                        alt={project.title}
                                        className="w-full h-64 object-cover rounded-lg shadow-lg"
                                    />
                                </div>
                                <div className="flex-1 text-center lg:text-left">
                                    <h3 className="text-2xl md:text-3xl font-poppins font-bold mb-4">
                                        {project.title}
                                    </h3>
                                    <p className="text-lg font-figtree font-light leading-relaxed mb-6">
                                        {project.description}
                                    </p>
                                    <div className="flex justify-center lg:justify-start space-x-4">
                                        <a
                                            href={project.github}
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            className="flex items-center space-x-2 px-6 py-3 bg-white text-black font-medium rounded-lg hover:bg-gray-200 transition-colors duration-200"
                                        >
                                            <FaGithub />
                                            <span>View on GitHub</span>
                                        </a>
                                        <a
                                            href={project.github}
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            className="flex items-center space-x-2 px-6 py-3 border border-white text-white font-medium rounded-lg hover:bg-white hover:text-black transition-colors duration-200"
                                        >
                                            <FaExternalLinkAlt />
                                            <span>Live Demo</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </AnimatedContent>
                    ))}
                </div>
            </div>
        </section>
    );
};

export default Projects; 