<template>
  <div class="resources-page bg-background text-on-surface font-body selection:bg-primary-fixed selection:text-on-primary-fixed pt-20 pb-24 max-w-7xl mx-auto px-8">
    <!-- Hero Section -->
      <section class="mb-20">
        <div class="grid lg:grid-cols-2 gap-12 items-center">
          <div class="space-y-6">
            <span class="inline-block px-4 py-1.5 rounded-full bg-secondary-container text-on-secondary-container font-label text-xs font-bold uppercase tracking-widest">Legal Frameworks</span>
            <h1 class="text-5xl md:text-6xl font-headline font-extrabold text-primary leading-tight tracking-tight">Resources & <br/>Mandates</h1>
            <p class="text-on-surface-variant text-lg max-w-lg leading-relaxed">
              Access the fundamental legal documents, international treaties, and institutional policies that shape the Gender and Development landscape at Benguet State University.
            </p>
          </div>
          <div class="relative h-[400px] rounded-xl overflow-hidden shadow-2xl">
            <img alt="Academic Library" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD7hEbm9jNmGbj6NmgWnmMdbTUD5MLfDz3zuiHR_0EK0wP3Vv0_z1urZJZSJnrmoVNafOqgAJQ6_Bb50hBeMav_Ge29stm52vtVCZ1Mok6CFcaNYuyM69fXoleXp1XPmfAl0GzNdPy-ghV4vd5H8juyoEQIDm7bBNRNAOApXW0TnBvDYYzOKuul9oiOxAsF925nyU83PMp23bQpaxTwXTt864E7mJmzhzhoaRE8GXP9ORafcjyyohbbqUdXEOY-o6TtwvQx62VT4xhV"/>
            <div class="absolute inset-0 bg-primary/20 mix-blend-multiply"></div>
          </div>
        </div>
      </section>

      <!-- Filter & Search Bar -->
      <section class="mb-16">
        <div class="bg-surface-container-lowest p-6 rounded-xl shadow-[0_4px_20px_rgba(0,0,0,0.03)] border border-outline-variant/15 flex flex-col md:flex-row gap-4 items-center justify-between">
          <div class="relative w-full md:max-w-md">
            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline">search</span>
            <input v-model="searchQuery" class="w-full pl-12 pr-4 py-3 bg-surface-container-low border-none rounded-lg focus:ring-2 focus:ring-primary text-on-surface placeholder:text-outline/60" placeholder="Search laws, policies, or mandates..." type="text"/>
          </div>
          <div class="flex gap-3 overflow-x-auto w-full md:w-auto pb-2 md:pb-0">
            <button v-for="cat in categories" :key="cat" @click="activeCategory = cat" :class="activeCategory === cat ? 'bg-primary text-white' : 'bg-surface-container-high text-on-surface/70 hover:bg-primary-fixed'" class="px-5 py-2 rounded-full transition-colors font-label text-sm whitespace-nowrap">
              {{ cat }}
            </button>
          </div>
        </div>
      </section>

      <!-- Bento Grid Layout -->
      <div class="grid grid-cols-1 md:grid-cols-12 gap-8 mb-20">
        <!-- International Mandates -->
        <div class="md:col-span-12 lg:col-span-8 space-y-8">
          <div class="flex items-center gap-4 mb-2">
            <h2 class="text-2xl font-headline font-bold text-primary">International Mandates</h2>
            <div class="h-px flex-grow bg-outline-variant/20"></div>
          </div>
          <div class="grid md:grid-cols-2 gap-6">
            <div v-for="mandate in filteredMandates" :key="mandate.title" class="group bg-surface-container-lowest p-8 rounded-xl border border-outline-variant/10 hover:shadow-xl transition-all duration-300">
              <div class="flex justify-between items-start mb-6">
                <div class="w-12 h-12 academic-gradient rounded-lg flex items-center justify-center text-white">
                  <span class="material-symbols-outlined">{{ mandate.icon }}</span>
                </div>
                <span class="material-symbols-outlined text-outline/40 group-hover:text-primary transition-colors">{{ mandate.fileIcon }}</span>
              </div>
              <h3 class="text-xl font-headline font-bold mb-3 group-hover:text-primary transition-colors">{{ mandate.title }}</h3>
              <p class="text-sm text-on-surface-variant leading-relaxed mb-6">{{ mandate.description }}</p>
              <div class="flex items-center justify-between mt-auto">
                <span class="text-xs font-label uppercase tracking-widest font-bold text-secondary">{{ mandate.type }}</span>
                <a class="text-primary font-label text-sm font-bold underline underline-offset-4 decoration-2" href="#">{{ mandate.action }}</a>
              </div>
            </div>
          </div>
        </div>

        <!-- Sidebar / National Focus -->
        <div class="md:col-span-12 lg:col-span-4 bg-primary text-white p-8 rounded-xl relative overflow-hidden flex flex-col">
          <div class="relative z-10">
            <h2 class="text-2xl font-headline font-bold mb-6">National Policy Spotlight</h2>
            <ul class="space-y-6">
              <li v-for="policy in nationalPolicies" :key="policy.id" class="group cursor-pointer">
                <p class="text-primary-fixed font-bold text-xs uppercase tracking-widest mb-1">{{ policy.id }}</p>
                <p class="font-headline font-semibold text-lg group-hover:translate-x-1 transition-transform">{{ policy.title }}</p>
              </li>
            </ul>
            <button class="mt-12 w-full py-4 rounded-full bg-white text-primary font-bold font-headline text-sm hover:bg-primary-fixed transition-colors">View All National Laws</button>
          </div>
          <div class="absolute -bottom-10 -right-10 w-48 h-48 bg-primary-container rounded-full opacity-30 blur-3xl"></div>
        </div>
      </div>

      <!-- Institutional Policies -->
      <div class="md:col-span-12 mb-20">
        <div class="flex items-center gap-4 mb-8">
          <h2 class="text-2xl font-headline font-bold text-primary">Institutional Policies</h2>
          <div class="h-px flex-grow bg-outline-variant/20"></div>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div v-for="policy in institutionalPolicies" :key="policy.title" class="flex flex-col gap-4 p-1 bg-surface-container rounded-2xl">
            <div class="bg-surface-container-lowest p-6 rounded-xl h-full">
              <div class="flex items-center gap-3 mb-4">
                <span class="material-symbols-outlined text-secondary">{{ policy.icon }}</span>
                <span class="font-label text-xs font-bold text-secondary uppercase tracking-widest">{{ policy.tag }}</span>
              </div>
              <h4 class="font-headline font-bold text-lg mb-2">{{ policy.title }}</h4>
              <p class="text-sm text-on-surface-variant mb-6">{{ policy.description }}</p>
              <div class="flex items-center gap-4 text-xs font-bold text-primary">
                <span class="material-symbols-outlined text-lg">{{ policy.actionIcon }}</span>
                <span>{{ policy.actionText }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Help Section -->
      <section class="mt-24 bg-surface-container-low rounded-3xl p-12 text-center max-w-4xl mx-auto">
        <h2 class="text-3xl font-headline font-extrabold text-primary mb-4">Cannot find a specific document?</h2>
        <p class="text-on-surface-variant mb-8 text-lg">Our office maintains an extensive physical archive of gender-related legislations and university memos. Please reach out if you need assistance.</p>
        <div class="flex flex-col sm:flex-row justify-center gap-4">
          <button class="px-8 py-3 rounded-full bg-primary text-white font-bold font-headline hover:opacity-90 transition-all">Request Document</button>
          <button class="px-8 py-3 rounded-full border border-primary text-primary font-bold font-headline hover:bg-primary/5 transition-all">Contact GAD Office</button>
        </div>
      </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const searchQuery = ref('');
const activeCategory = ref('All Resources');
const categories = ['All Resources', 'International', 'National', 'Institutional'];

const mandates = [
  { 
    title: 'CEDAW', 
    description: 'Convention on the Elimination of All Forms of Discrimination Against Women. Often described as an international bill of rights for women.', 
    icon: 'public', 
    fileIcon: 'picture_as_pdf', 
    type: 'UN Treaty', 
    action: 'Download Document',
    category: 'International'
  },
  { 
    title: 'BPFA', 
    description: "Beijing Platform for Action. An agenda for women's empowerment that aims at accelerating the implementation of the Nairobi Forward-looking Strategies.", 
    icon: 'flag', 
    fileIcon: 'link', 
    type: 'Strategic Agenda', 
    action: 'View Reference',
    category: 'International'
  }
];

const nationalPolicies = [
  { id: 'Republic Act 9710', title: 'Magna Carta of Women' },
  { id: 'Administrative Order', title: 'GAD Budget Guidelines' },
  { id: 'Republic Act 7877', title: 'Anti-Sexual Harassment Act' }
];

const institutionalPolicies = [
  {
    title: 'BSU GAD Guidelines',
    description: 'Internal operational frameworks for gender mainstreaming across all BSU campuses.',
    icon: 'school',
    tag: 'BSU Specific',
    actionIcon: 'download',
    actionText: 'PDF (2.4 MB)'
  },
  {
    title: 'Safe Spaces Act Implementation',
    description: 'Localized implementation protocols for the BSU community regarding safe spaces.',
    icon: 'policy',
    tag: 'Code of Conduct',
    actionIcon: 'open_in_new',
    actionText: 'External Portal'
  },
  {
    title: 'GAD 5-Year Strategic Roadmap',
    description: 'Future objectives and developmental milestones for gender parity at BSU.',
    icon: 'history_edu',
    tag: 'Strategic Plan',
    actionIcon: 'download',
    actionText: 'PDF (5.1 MB)'
  }
];

const filteredMandates = computed(() => {
  return mandates.filter(m => {
    const matchesSearch = m.title.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                         m.description.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesCategory = activeCategory.value === 'All Resources' || m.category === activeCategory.value;
    return matchesSearch && matchesCategory;
  });
});
</script>

<style scoped>
.academic-gradient {
  background: linear-gradient(135deg, #422b68 0%, #5a4281 100%);
}
</style>
