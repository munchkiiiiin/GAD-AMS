<template>
  <div class="about-page bg-background text-on-background font-body selection:bg-primary-fixed selection:text-on-primary-fixed pt-20">
    <!-- Hero Section -->
      <section class="relative h-[614px] flex items-center overflow-hidden">
        <div class="absolute inset-0 z-0">
          <img class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBrNICNtQ6fvyb5aPPVpkrbfEAk8SlL00ge87KeoMUR8o62cNTisej7lS8mfRe13-ZIVRT5gJA47W0KVUyRqaqBcsQe58i9wxMqRZnAemct-Cr7IHt4KF1thnbe_ufFZUnhBSoR5uy45p_PiguXcg_jQzvGcTWE9Gt19AI3o4s9Yqq5EmT2yl_WVQPNnHBjrrSY7IjKr9LftK2ku7RCrJcGNTUFQcyEiLaFg5_2X-uglrbFO7OTmarnXNPBgs7yUkG_RiN0h2M07Txc"/>
          <div class="absolute inset-0 bg-gradient-to-r from-primary/90 to-transparent"></div>
        </div>
        <div class="relative z-10 px-12 max-w-4xl mx-auto md:mx-0">
          <span class="text-secondary-fixed font-label text-sm uppercase tracking-[0.2em] mb-4 block">Institutional Profile</span>
          <h1 class="text-white font-headline text-6xl font-extrabold tracking-tight mb-6 leading-tight">
            Advancing Gender Equality <br/>in Higher Education
          </h1>
          <p class="text-primary-fixed font-body text-xl max-w-2xl leading-relaxed opacity-90">
            The Benguet State University Gender and Development Office is dedicated to fostering an inclusive academic environment where all individuals thrive regardless of gender.
          </p>
        </div>
      </section>

      <!-- Mission & Vision Asymmetric Layout -->
      <section class="py-24 px-12 max-w-7xl mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-12 gap-16 items-start">
          <!-- Vision -->
          <div class="md:col-span-5 space-y-8">
            <div class="inline-flex items-center gap-3 text-primary">
              <span class="w-12 h-[2px] bg-secondary"></span>
              <span class="font-label font-bold uppercase tracking-widest text-xs">Our Vision</span>
            </div>
            <h2 class="font-headline text-4xl font-bold text-on-background leading-tight">
              A premier university delivering world-class education that champions gender-fair society.
            </h2>
            <div class="p-8 bg-surface-container-low rounded-xl border-l-4 border-secondary">
              <p class="text-on-surface-variant font-body leading-loose italic">
                "The GAD Office envisions a University community where gender equality and women empowerment are institutionalized in all its programs and projects."
              </p>
            </div>
          </div>
          <!-- Mission Image Block (Asymmetric offset) -->
          <div class="md:col-span-7 mt-12 md:mt-0">
            <div class="relative">
              <img class="rounded-xl shadow-2xl w-full h-[500px] object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCkOMlG-5z1nzb3Ce6tVy3S0JBIwCbSsfRSkDcW_SYpER0fe4VHZYEMX1QKewSxtWivqG2da_nsog0Yd-y0bm3oM1v-i_quzbbX5f_Zx8AZqknSzQRwyNpmAsM87JP_1ZGNOPcwAcsrvKUlPzghmEwHRGTa2blTgTUIYfCVgScPeQ1WVy7tpFkLZihMgLTYHwqxJYw65mdqO_hph2xpNiXQMO2EGbdopLWzQB0F8e6yv6IT9leS3w1IjTjlGpl8v0JNMoA2yVZK8W-5"/>
              <div class="absolute -bottom-12 -left-12 p-10 bg-surface-container-lowest shadow-xl rounded-xl max-w-md hidden lg:block border border-outline-variant/10">
                <div class="font-label font-bold uppercase tracking-widest text-xs text-secondary mb-4">Our Mission</div>
                <p class="text-on-surface font-body text-lg leading-relaxed">
                  To mainstream gender perspectives in the University's functions of instruction, research, extension, and production through policy development and advocacy.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Core Values Bento Grid -->
      <section class="py-24 bg-surface-container-lowest">
        <div class="max-w-7xl mx-auto px-12">
          <div class="text-center mb-16">
            <h2 class="font-headline text-3xl font-bold text-on-background">Our Core Pillars</h2>
            <div class="w-16 h-1 bg-secondary mx-auto mt-4"></div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Social Justice -->
            <div class="p-10 bg-surface rounded-xl hover:shadow-lg transition-all border border-outline-variant/15 flex flex-col items-center text-center group">
              <div class="w-16 h-16 rounded-full bg-primary-fixed flex items-center justify-center text-primary mb-6 group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-3xl">balance</span>
              </div>
              <h3 class="font-headline text-xl font-bold mb-4">Social Justice</h3>
              <p class="text-on-surface-variant text-sm leading-relaxed">
                Ensuring fair distribution of resources and opportunities while removing barriers for marginalized groups within the academic community.
              </p>
            </div>
            <!-- Gender Equality -->
            <div class="p-10 bg-surface rounded-xl hover:shadow-lg transition-all border border-outline-variant/15 flex flex-col items-center text-center group">
              <div class="w-16 h-16 rounded-full bg-secondary-fixed flex items-center justify-center text-secondary mb-6 group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-3xl">groups</span>
              </div>
              <h3 class="font-headline text-xl font-bold mb-4">Gender Equality</h3>
              <p class="text-on-surface-variant text-sm leading-relaxed">
                Promoting equal rights, responsibilities, and opportunities for everyone regardless of their gender identity or orientation.
              </p>
            </div>
            <!-- Empowerment -->
            <div class="p-10 bg-surface rounded-xl hover:shadow-lg transition-all border border-outline-variant/15 flex flex-col items-center text-center group">
              <div class="w-16 h-16 rounded-full bg-tertiary-fixed flex items-center justify-center text-tertiary mb-6 group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-3xl">bolt</span>
              </div>
              <h3 class="font-headline text-xl font-bold mb-4">Empowerment</h3>
              <p class="text-on-surface-variant text-sm leading-relaxed">
                Strengthening the capacity of individuals to make choices and transform those choices into desired actions and outcomes.
              </p>
            </div>
          </div>
        </div>
      </section>

      <!-- Commitment Section -->
      <section class="py-24 px-12 max-w-7xl mx-auto">
        <div class="bg-primary rounded-[2rem] p-12 md:p-20 relative overflow-hidden flex flex-col md:flex-row items-center gap-12">
          <div class="absolute top-0 right-0 w-64 h-64 bg-primary-container rounded-full blur-[100px] opacity-20 -mr-32 -mt-32"></div>
          <div class="absolute bottom-0 left-0 w-64 h-64 bg-secondary rounded-full blur-[100px] opacity-10 -ml-32 -mb-32"></div>
          <div class="relative z-10 flex-1">
            <h2 class="font-headline text-4xl font-bold text-white mb-8">Our Commitment to the Community</h2>
            <div class="space-y-6">
              <div class="flex gap-4">
                <span class="material-symbols-outlined text-secondary-fixed fill-icon">check_circle</span>
                <p class="text-primary-fixed leading-relaxed">Conducting gender-sensitive research that informs evidence-based policies and academic curricula.</p>
              </div>
              <div class="flex gap-4">
                <span class="material-symbols-outlined text-secondary-fixed fill-icon">check_circle</span>
                <p class="text-primary-fixed leading-relaxed">Providing training and workshops to eliminate gender bias in classrooms and administrative offices.</p>
              </div>
              <div class="flex gap-4">
                <span class="material-symbols-outlined text-secondary-fixed fill-icon">check_circle</span>
                <p class="text-primary-fixed leading-relaxed">Facilitating community outreach programs that promote gender awareness in the Cordillera region.</p>
              </div>
            </div>
            <button class="mt-10 bg-secondary hover:bg-secondary-container text-on-secondary-container px-8 py-3 rounded-full font-headline font-bold transition-all shadow-lg">
              Download GAD Strategic Plan
            </button>
          </div>
          <div class="relative z-10 w-full md:w-1/3">
            <div class="aspect-square bg-white/10 backdrop-blur-md rounded-2xl p-8 border border-white/20">
              <div class="text-center">
                <div class="text-5xl font-black text-secondary-fixed mb-2">100%</div>
                <div class="text-white text-sm font-label tracking-widest uppercase">Institutional Compliance</div>
              </div>
              <div class="mt-8 pt-8 border-t border-white/10 text-center">
                <div class="text-3xl font-bold text-white mb-2">PCW</div>
                <div class="text-white/70 text-xs">Accredited by Philippine Commission on Women</div>
              </div>
            </div>
          </div>
        </div>
      </section>
  </div>
</template>

<script setup>
</script>

<style scoped>
.fill-icon {
  font-variation-settings: 'FILL' 1;
}
</style>
