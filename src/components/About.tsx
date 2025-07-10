import { motion } from 'framer-motion';
import { useInView } from 'framer-motion';
import ScrollReveal from './ScrollReveal';
import { useRef } from 'react';

const About = () => {
    const ref = useRef(null);
    const isInView = useInView(ref); // Animation repeats every time in view

    return (
        <section id="about" className="py-20 px-4">
            <div className="max-w-6xl mx-auto text-center">
                <motion.div
                    ref={ref}
                    initial={{ opacity: 0, y: 100 }}
                    animate={isInView ? { opacity: 1, y: 0 } : { opacity: 0, y: 100 }}
                    transition={{ duration: 0.8 }}
                    className="text-center"
                >
                    <h2 className="text-4xl md:text-5xl font-poppins font-bold mb-12">
                        About Me
                    </h2>
                </motion.div>

                <ScrollReveal
                    baseOpacity={0.5}
                    enableBlur={true}
                    baseRotation={4}
                    blurStrength={2}
                    textClassName='text-center text-sm sm:text-lg md:text-xl font-poppins font-extralight font-weight-200 font-thin leading-relaxed max-w-245 mx-auto'
                >
                    I am a student and i create this project just for fun cuz why not? i am still enjoy this long holiday. this project maybe a created by someone has no idea what is he doing cause he dont know what is he doing. this person is lazy and not have any ideas coming on his brain. if you see this please do not share it to other people i think thats it enjoy the f*ck is this i dont know what is this portofolio.
                </ScrollReveal>


            </div>
        </section>
    );
};

export default About; 