<template>
  <nav class="fixed top-0 w-full z-50 bg-white/80 dark:bg-slate-950/80 backdrop-blur-md shadow-sm dark:shadow-none">
    <div class="flex justify-between items-center w-full px-8 py-4 max-w-screen-2xl mx-auto">
      <div class="text-xl font-bold tracking-tighter text-purple-900 dark:text-purple-100 uppercase font-headline">
        <router-link to="/">BSU GAD Office</router-link>
      </div>

      <div class="hidden md:flex items-center gap-8 font-manrope tracking-tight font-semibold">
        <router-link 
          v-for="item in navItems" 
          :key="item.label"
          :to="item.href"
          class="transition-colors"
          :class="$route.path === item.href ? 'text-purple-700 dark:text-purple-400 font-bold border-b-2 border-purple-600 pb-1' : 'text-slate-600 dark:text-slate-400 hover:text-purple-600'"
        >
          {{ item.label }}
        </router-link>
      </div>

      <div class="flex items-center gap-4">
        <div class="relative hidden lg:block">
          <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-sm">search</span>
          <input class="bg-surface-container-low border-none rounded-sm pl-10 pr-4 py-2 text-sm focus:ring-2 focus:ring-primary w-64 transition-all" placeholder="Search resources..." type="text"/>
        </div>

        <template v-if="$route.path === '/login'">
          <router-link to="/register" class="bg-[#422b68] text-white px-5 py-2 rounded-full font-label text-sm font-semibold tracking-wide hover:opacity-90 transition-all active:scale-95 duration-200 inline-block text-center">
            Sign Up
          </router-link>
        </template>
        <template v-else>
          <span class="text-xs uppercase tracking-widest text-slate-400 font-label">Already have an account?</span>
          <router-link to="/login" class="bg-gradient-to-br from-primary to-primary-container text-on-primary px-6 py-2 rounded-full font-label text-sm font-semibold hover:scale-95 duration-200 transition-all uppercase tracking-wider inline-block text-center">
            Portal Login
          </router-link>
        </template>
      </div>
    </div>
  </nav>
</template>

<script setup>
const navItems = [
  { href: '/', label: 'Home' },
  { href: '/about', label: 'About Us' },
  { href: '/resources', label: 'Resources' },
  { href: '/gad-corner', label: 'GAD Corner' },
  { href: '/contact', label: 'Contact' }
];
</script>

<style scoped>
/* Ensure material symbols are available if not globally */
@import url('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap');
</style>
