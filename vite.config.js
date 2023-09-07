import { resolve } from 'path'
import { defineConfig } from 'vite'
import ViteRestart from 'vite-plugin-restart'

export default defineConfig(( command, mode, ssrBuild ) => {
    return {
        base: command === 'serve' ? '' : '/dist/',
        build: {
            manifest: true,
            rollupOptions: {
                input: {
                    style: resolve(__dirname, 'src/style/main.scss'),
                    app: resolve(__dirname, 'src/js/app.js'),
                },
                output: {
                    entryFileNames: '[name].min.js',
                    assetFileNames:  'style[extname]',
                }
            },
            outDir: resolve(__dirname, 'httpdocs/dist/'),
        },
        server: {
            host: '0.0.0.0',
            port: 3000,
            strictPort: true
        },
        plugins: [
          ViteRestart({
              reload: [
                'templates/**/*',
              ]
          })
        ]
    }
})
