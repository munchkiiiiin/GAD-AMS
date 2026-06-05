<template>
  <div class="gad-corner bg-background text-on-surface font-body selection:bg-primary/20 pt-20 pb-24 max-w-7xl mx-auto px-8">
    <!-- Header Section -->
      <header class="mb-16">
        <h1 class="font-headline text-5xl md:text-6xl font-extrabold tracking-tight text-primary mb-4">GAD Corner</h1>
        <p class="text-on-surface-variant text-lg max-w-2xl leading-relaxed">
          Advancing gender equality and social inclusion through stories, news, and institutional updates from Benguet State University.
        </p>
      </header>

      <!-- Featured Article (Bento Style) -->
      <section class="mb-20">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm border border-outline-variant/10">
          <div class="lg:col-span-7 relative h-[400px] lg:h-[540px]">
            <img alt="Featured Article" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCXSUul2vJcK0ecat705QJaylXcLlfEmrDJDtuyKbWxsG3ejpgx2YIgIAk_XYYAX3Ua7Gqx0rG20VfyTHbzqXVdtOOM6BSoa4ULbnByA0Fhd1P1Pe5p-cMsxOhVA_E2gTx-1m50lsDGpTJvSBjUaIRwRRKdvHoRmNOfhtEakFK6y5hv-Z6r1Z9ihnYF2YIDzKXcbPGxP_4uajO-lJ4paZLlxz47YsVsWol_Z759C0BMB4L4Nq88M78K2iM-Jewci_22td2ok5qnOSC5"/>
            <div class="absolute top-6 left-6">
              <span class="bg-primary text-white px-4 py-1.5 rounded-full text-xs font-bold tracking-widest uppercase">Featured Story</span>
            </div>
          </div>
          <div class="lg:col-span-5 p-10 flex flex-col justify-center">
            <div class="flex items-center gap-2 text-secondary font-semibold text-sm mb-4 uppercase tracking-widest font-headline">
              <span class="material-symbols-outlined scale-75">calendar_today</span>
              October 24, 2024
            </div>
            <h2 class="font-headline text-3xl md:text-4xl font-bold text-on-background mb-6 leading-tight">
              Empowering the Highlands: BSU's New Strategy for Gender-Inclusive Research
            </h2>
            <p class="text-on-surface-variant mb-8 text-lg leading-relaxed">
              The Benguet State University Gender and Development (GAD) office unveils its comprehensive 5-year roadmap focusing on indigenous women in STEM.
            </p>
            <div class="flex items-center gap-4">
              <button class="bg-primary text-white px-8 py-3 rounded-full font-semibold hover:bg-primary-container transition-all flex items-center gap-2 group">
                Read Full Article
                <span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
              </button>
            </div>
          </div>
        </div>
      </section>

      <!-- Main Content & Sidebar Layout -->
      <div class="grid grid-cols-1 lg:grid-cols-12 gap-16">
        <!-- Latest Updates Grid -->
        <div class="lg:col-span-8">
          <div class="flex items-center justify-between mb-10">
            <h3 class="font-headline text-2xl font-bold text-primary">Latest Updates</h3>
            <div class="h-px flex-grow mx-8 bg-surface-container-highest"></div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
            <!-- Article Card 1 -->
            <article v-for="post in posts" :key="post.id" class="group">
              <div class="mb-6 overflow-hidden rounded-xl bg-surface-container aspect-[4/3] relative">
                <img :src="post.image" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" :alt="post.title" />
                <div class="absolute bottom-4 left-4">
                  <span class="bg-surface-container-lowest/90 backdrop-blur-sm text-primary px-3 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wider">{{ post.category }}</span>
                </div>
              </div>
              <div class="flex items-center gap-2 text-outline text-xs mb-3 font-medium">
                <span>{{ post.date }}</span>
                <span class="w-1 h-1 rounded-full bg-outline-variant"></span>
                <span>{{ post.readTime }}</span>
              </div>
              <h4 class="font-headline text-xl font-bold mb-3 text-on-background group-hover:text-primary transition-colors leading-snug">
                {{ post.title }}
              </h4>
              <p class="text-on-surface-variant text-sm line-clamp-2 mb-4 leading-relaxed">
                {{ post.excerpt }}
              </p>
              <a class="inline-flex items-center text-primary text-sm font-bold group/link" href="#">
                Read More 
                <span class="material-symbols-outlined text-lg ml-1 group-hover/link:translate-x-1 transition-transform">chevron_right</span>
              </a>
            </article>
          </div>
          <div class="mt-16 flex justify-center">
            <button class="border border-outline-variant/30 text-primary font-bold px-10 py-3 rounded-full hover:bg-surface-container-low transition-all">
              View More Articles
            </button>
          </div>
        </div>

        <!-- Sidebar -->
        <aside class="lg:col-span-4 space-y-12">
          <!-- Popular Topics -->
          <div class="bg-surface-container-lowest p-8 rounded-xl shadow-sm">
            <h5 class="font-headline text-lg font-bold text-primary mb-6 flex items-center gap-2">
              <span class="material-symbols-outlined text-secondary">trending_up</span>
              Popular Topics
            </h5>
            <div class="flex flex-wrap gap-2">
              <a v-for="topic in topics" :key="topic" class="bg-surface-container-low px-4 py-2 rounded-lg text-sm font-medium text-on-surface-variant hover:bg-primary/5 hover:text-primary transition-all" href="#">
                #{{ topic }}
              </a>
            </div>
          </div>

          <!-- Newsletter Bento -->
          <div class="bg-gradient-to-br from-primary to-primary-container p-8 rounded-xl text-white shadow-xl">
            <span class="material-symbols-outlined text-secondary-fixed text-4xl mb-4">mail</span>
            <h5 class="font-headline text-xl font-bold mb-3">Get Weekly Updates</h5>
            <p class="text-on-primary-container text-sm mb-6 leading-relaxed">
              Stay informed about GAD events and announcements delivered straight to your inbox.
            </p>
            <div class="space-y-3">
              <input class="w-full bg-white/10 border-white/20 rounded-lg py-3 px-4 text-sm placeholder:text-white/50 focus:ring-secondary focus:bg-white/20 transition-all border-none" placeholder="Email Address" type="email"/>
              <button class="w-full bg-secondary-container text-on-secondary-container font-bold py-3 rounded-lg hover:brightness-110 transition-all">
                Subscribe
              </button>
            </div>
          </div>

          <!-- Archives -->
          <div class="bg-surface-container-lowest p-8 rounded-xl shadow-sm">
            <h5 class="font-headline text-lg font-bold text-primary mb-6 flex items-center gap-2">
              <span class="material-symbols-outlined text-secondary">inventory_2</span>
              Archives
            </h5>
            <ul class="space-y-4">
              <li v-for="archive in archives" :key="archive.month">
                <a class="flex justify-between items-center group" href="#">
                  <span class="text-on-surface-variant group-hover:text-primary transition-colors">{{ archive.month }}</span>
                  <span class="bg-surface-container px-2 py-0.5 rounded text-[10px] font-bold text-outline">{{ archive.count }}</span>
                </a>
              </li>
            </ul>
          </div>

          <!-- Social Links -->
          <div class="flex items-center justify-center gap-6">
            <a v-for="link in socialLinks" :key="link.icon" class="w-12 h-12 rounded-full bg-surface-container-low flex items-center justify-center text-primary hover:bg-primary hover:text-white transition-all" href="#">
              <span class="material-symbols-outlined">{{ link.icon }}</span>
            </a>
          </div>
        </aside>
      </div>
  </div>
</template>

<script setup>
const posts = [
  {
    id: 1,
    category: 'Event',
    date: 'Oct 22, 2024',
    readTime: '5 min read',
    title: 'Safe Spaces Workshop: Fostering Inclusivity in the Classroom',
    excerpt: 'Faculty members from all colleges gathered to discuss pedagogical shifts towards a more gender-neutral learning environment.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA_G-T1Vpm2ZjLuRu755YEaAGpt3V7Ler9sk6h4sKNar4xApm8zyfHC3kF-6wSYQ4Lz83Ie_T35icsIgans2YFzQ0i42u_duHDfyoZ71YsjYtgNt5qVqmzVsjPofsx_HzCADKPMnYVZt6rm1pYAs2g5OOQj-EXH9NAfsld8Aa1StDuxzNi5Cg_QMdBRmzl6H_BZ_jPfuSs8hn9MnxN69ymwycoiQim49fZbjH04lU0YU6vtc4LYqsy7VArmW0kR148hQFKtZcvDqjCR'
  },
  {
    id: 2,
    category: 'Story',
    date: 'Oct 19, 2024',
    readTime: '8 min read',
    title: 'Voices of BSU: A Retrospective on 20 Years of GAD',
    excerpt: 'Interviewing the pioneers who established the first gender desk in the Cordillera administrative region.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBOd2mv2tzbeM8AuSFeoIXT0Z7VujFAuRd2-yjZVBXA2B9cPLJcDyMhOmoCLSCOa0xJQJu-63XnHgX8zR5wPNZpAbT6IqF1Y_HmVn3rvH6bRnEHgvNFP-ZrivtscjVp1ELzYQPAl68gUtDeqDBaDCszyqcICbZwJFtjyOhiiTE4kq5ko_NNMM4IbvRT6cx2KVdNu6ujkgZCK7ojvA0tGxMW1riRisFxi5RNeotfZYAi1NbTg76eEZ1STRpH6v-Y0TX1C8wNBg3wE8zh'
  },
  {
    id: 3,
    category: 'Announcement',
    date: 'Oct 15, 2024',
    readTime: '2 min read',
    title: 'Upcoming Seminar: Digital Citizenship and Online Gender Safety',
    excerpt: 'Join us this coming Friday for a webinar focusing on protecting students from cyber-harassment.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBS0v8kIFq1kNUaEUBVOnyek8ZRC8JZCXewDZT21S4xx5zhb_Re2o9fCwDvRI-ku437S4s985HvU48O0oOD0rU5gv242ae8U9L3L8smwKuuL5MO_-u6jPy7mW06xLoRuCw6U-8TM8CstK0fO0okIEsywIMLAoi4JKPiZDxOebJNP40kCr3EMY5MZZBAus5A0IznTHMqMwADeBs73wesw4ZkGpaWmqnMxW5BuDIXNLx6dpnYs11LpiMKcB1hF775-BDfuqHxdxj82ywx'
  },
  {
    id: 4,
    category: 'Event',
    date: 'Oct 12, 2024',
    readTime: '4 min read',
    title: 'Call for Proposals: 2025 Gender Equity Research Grants',
    excerpt: 'The GAD Council is now accepting research proposals that address urban-rural gender disparities in Cordillera.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBx0lc2Au-DLX0yKlhzfrMCQ_ggrg9nKcSi5wE0pSJ-2v8XsUYzcao1XYAzPXh5ZUaBknyQrVi6BDkppqnqpxs7QfwB5w5YkhKQIl4c7u58bAcrSoKelhFDGjQafAPyn9LTAvXS9BCpg77kPeuM7ytEb_pXMPrYakaDfXndimEwy6cKBQEVacgFmEM79oXGyiRoQCCFDtahmox_95wDjnGT-YJbB7OUojAaQD7cQ8Pa921avcVGYY9XRImAv8CwdZQ03IkuMXxni_BS'
  }
];

const topics = ['GenderEquality', 'IndigenousRights', 'WomenInSTEM', 'SafeSpaces', 'InstitutionalPolicies', 'Training'];

const archives = [
  { month: 'October 2024', count: 12 },
  { month: 'September 2024', count: 8 },
  { month: 'August 2024', count: 15 },
  { month: 'July 2024', count: 5 }
];

const socialLinks = [
  { icon: 'public' },
  { icon: 'share' },
  { icon: 'rss_feed' }
];
</script>

<style scoped>
</style>
