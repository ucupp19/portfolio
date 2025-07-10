import { motion } from 'framer-motion';
import { useInView } from 'framer-motion';
import { useRef } from 'react';
import { MdEmail } from 'react-icons/md';
import { FaGithub, FaInstagram } from 'react-icons/fa';
import AnimatedContent from './AnimatedContent';


const Contact = () => {
    const ref = useRef(null);
    const isInView = useInView(ref); // Animation repeats every time in view

    const contactItems = [
        {
            name: 'Email',
            value: 'yusufafaris@gmail.com',
            icon: <MdEmail />,
            link: 'mailto:yusufafaris@gmail.com',
            color: 'text-red-400'
        },
        {
            name: 'GitHub',
            value: 'github.com/ucupp19',
            icon: <FaGithub />,
            link: 'https://github.com/ucupp19',
            color: 'text-gray-400'
        },
        {
            name: 'Instagram',
            value: '@afrizzz19',
            icon: <FaInstagram />,
            link: 'https://www.instagram.com/afrizzz19/',
            color: 'text-pink-400'
        }
    ];

    return (
        <section id="contact" className="py-20 px-4">
            <div className="max-w-4xl mx-auto">
                <motion.div
                    ref={ref}
                    initial={{ opacity: 0, y: 100 }}
                    animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 100 }}
                    transition={{ duration: 0.8 }}
                    className="text-center"
                >
                    <h2 className="text-4xl md:text-5xl font-poppins font-bold mb-12">
                        Contact
                    </h2>
                </motion.div>
                <AnimatedContent
                    distance={100}
                    direction="vertical"
                    reverse={false}
                    duration={0.8}
                    ease="power3.out"
                    initialOpacity={0}
                    animateOpacity
                    scale={1}
                    threshold={0.1}
                    delay={0}
                >
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                        {contactItems.map((item) => (
                            <div
                                key={item.name}
                                className="flex flex-col items-center p-6 rounded-lg bg-white/5 border border-white/10 group transition-all duration-200"
                            >
                                <span className={`text-4xl mb-4 group-hover:scale-110 transition-transform duration-200 ${item.color}`}>
                                    {item.icon}
                                </span>
                                <h3 className="text-xl font-poppins font-bold mb-2 group-hover:text-yellow-400 transition-colors duration-200">
                                    {item.name}
                                </h3>
                                <p className="text-lg font-figtree font-light text-gray-300 group-hover:text-white transition-colors duration-200">
                                    {item.value}
                                </p>
                            </div>
                        ))}
                    </div>
                </AnimatedContent>

                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 50 }}
                    transition={{ duration: 0.8, delay: 0.4 }}
                    className="mt-12 p-6 rounded-lg bg-white/5 border border-white/10"
                >
                    <p className="text-lg font-figtree font-light">
                        Feel free to reach out to me through any of the platforms above. I'm always open to new opportunities and collaborations!
                    </p>
                </motion.div>

            </div >

        </section >
    );
};

export default Contact; 