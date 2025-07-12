import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [react()],
    build: {
        // Memory optimization
        target: 'es2015',
        minify: 'esbuild',
        sourcemap: false,

        // Chunk optimization for low memory
        rollupOptions: {
            output: {
                manualChunks: {
                    vendor: ['react', 'react-dom'],
                    animations: ['framer-motion', 'gsap'],
                    icons: ['react-icons']
                }
            }
        },

        // Reduce memory usage
        chunkSizeWarningLimit: 1000,

        // Optimize for size
        assetsInlineLimit: 4096,

        // Disable CSS code splitting
        cssCodeSplit: false
    },

    // Optimize dependencies
    optimizeDeps: {
        include: ['react', 'react-dom']
    },

    // Server optimization
    server: {
        hmr: false
    }
}) 