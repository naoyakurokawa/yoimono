import { createApp } from 'vue'
import Menu from './components/Menu.vue'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('vue-menu')
  createApp(Menu, {
    isLogin: JSON.parse(node.getAttribute('data-vue')),
  }).mount('#vue-menu')
})
