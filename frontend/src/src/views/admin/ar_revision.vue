<template>
  <div class="min-h-screen bg-[#f8f9fb] antialiased">
    <main class="pl-64 pt-16">
      <div class="p-10 flex gap-8">
        <section class="flex-[0.6] bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden read-only-dim">
          <div class="p-8 border-b border-slate-100">
            <h2 class="font-serif text-[28px] font-bold text-black mb-4">
              {{ report.title }}
            </h2>
            <span class="text-[9px] font-bold text-slate-500 uppercase tracking-widest">
              {{ report.controlNumber }}
            </span>
          </div>
          <div class="p-8">
            <p class="text-[11px] text-slate-700 leading-relaxed">{{ report.content }}</p>
          </div>
        </section>

        <section class="flex-[0.4] sticky top-20 self-start">
          <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
            <h3 class="text-xs font-bold uppercase text-purple-700 mb-6">✏️ Request Revision</h3>
            
            <form @submit.prevent="submitRevision" class="space-y-6">
              <div>
                <label class="block text-[9px] font-bold text-purple-700 uppercase mb-2">Revision Remarks</label>
                <textarea 
                  v-model="remarks" 
                  rows="4" 
                  class="w-full border border-slate-200 rounded-xl p-4 text-[11px]" 
                  placeholder="Enter revision comments..."
                ></textarea>
              </div>

              <div>
                <label class="block text-[9px] font-bold text-purple-700 uppercase mb-2">Revision Deadline</label>
                <input 
                  type="date" 
                  v-model="deadline" 
                  class="w-full border border-slate-200 rounded-xl p-4 text-[11px]"
                >
              </div>

              <button type="submit" class="w-full bg-[#ecd224] text-black p-3 rounded-xl font-bold text-[11px] hover:bg-[#d4bc20] transition">
                Send Revision Request
              </button>
            </form>
          </div>
        </section>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue';

// Reactive data
const remarks = ref('');
const deadline = ref('');

const report = ref({
  controlNumber: 'AR-2026-088',
  title: 'Lorem Ipsum Dolor Sit Amet',
  content: 'Report content preview here...'
});

const submitRevision = () => {
  if (!remarks.value || !deadline.value) {
    alert('Please fill in all fields.');
    return;
  }
  alert(`Revision requested. Deadline: ${deadline.value}`);
  // Add API call logic here
};
</script>

<style scoped>
.read-only-dim { opacity: 0.7; }
</style>