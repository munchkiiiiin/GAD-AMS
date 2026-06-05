<template>
  <div id="app" class="min-h-screen flex flex-col">
    <Navbar v-if="!isDashboard" />
    <router-view class="flex-grow" />
    <Footer v-if="!isDashboard" />
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import Navbar from './components/Navbar.vue';
import Footer from './components/Footer.vue';

const route = useRoute();
const isDashboard = computed(() => {
  const path = route.path;
  return (
    path.includes('/admin/') || 
    path.includes('/staff/') || 
    path.includes('/college/')
  );
});
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap');

body {
  margin: 0;
  font-family: 'Manrope', sans-serif;
}
</style>