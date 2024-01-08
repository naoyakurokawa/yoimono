import { createApp } from 'vue'
import RelationshipButton from './components/Relationship/RelationshipButton.vue';

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("relationship-button");
  const initialData = JSON.parse(node.getAttribute("data-vue"));
  createApp(RelationshipButton, { followerId: Number(initialData.followerId), followedId: Number(initialData.followedId)}).mount('#relationship-button');
})