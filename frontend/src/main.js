import { createApp } from 'vue'
import axios from 'axios'
import './src/style.css'
import App from './src/App.vue'
import router from './src/router'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'
const uploadBaseUrl = import.meta.env.VITE_UPLOAD_BASE_URL || apiBaseUrl

axios.defaults.baseURL = apiBaseUrl
axios.interceptors.request.use((config) => {
	if (typeof config.url === 'string' && config.url.startsWith('http://localhost:8080')) {
		config.url = config.url.replace('http://localhost:8080', apiBaseUrl)
	}

	return config
})

globalThis.__API_BASE_URL__ = apiBaseUrl
globalThis.__UPLOAD_BASE_URL__ = uploadBaseUrl

const app = createApp(App)
app.use(router)
app.mount('#app')
