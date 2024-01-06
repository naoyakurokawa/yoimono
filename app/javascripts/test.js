import { createApp } from 'vue'
import Test from './components/Test.vue';

export const components = {
  Test
};

document.addEventListener("DOMContentLoaded", () => {
  let templates = document.querySelectorAll("[data-vue]");

  for (let el of templates) {
    let app = createApp(components[el.dataset.vue]);
    app.mount(el);
  }
});