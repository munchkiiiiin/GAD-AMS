<template>
      <main class="twg-view-wrapper">
        <div class="max-w-3xl mx-auto py-10 px-6 w-full">
          <div class="mb-8">
            <h1 class="text-3xl font-extrabold tracking-tight form-main-title">Submit Activity Report</h1>
            <p class="text-xs text-slate-400 mt-1.5">Fill out the accomplishment report form below. All fields marked with * are required.</p>
          </div>

          <div class="form-container-box">
            <form @submit.prevent="submitReport" class="space-y-6">
              <div class="space-y-2">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Activity Title *</label>
                <textarea 
                  v-model="form.activity_title" 
                  required 
                  rows="3" 
                  class="custom-input-field resize-none"
                  placeholder="Enter the complete title of the activity"
                ></textarea>
              </div>

              <div class="space-y-2">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Activity Design Control Number *</label>
                <select 
                  v-model="form.control_number" 
                  required 
                  class="custom-input-field select-arrow-fix"
                  @change="onControlNumberChange"
                >
                  <option value="" class="dark-option" disabled>Select approved activity design control number...</option>
                  <option v-for="ctrl in availableControls" :key="ctrl.control_number" :value="ctrl.control_number" class="dark-option">
                    {{ ctrl.control_number }}
                  </option>
                </select>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Start Date of Implementation *</label>
                  <input 
                    type="date" 
                    v-model="form.start_date" 
                    required 
                    class="custom-input-field code-icon-calendar"
                  >
                </div>
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">End Date of Implementation *</label>
                  <input 
                    type="date" 
                    v-model="form.end_date" 
                    required 
                    class="custom-input-field code-icon-calendar"
                  >
                </div>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Start Time *</label>
                  <input 
                    type="time" 
                    v-model="form.start_time" 
                    required 
                    class="custom-input-field code-icon-clock"
                  >
                </div>
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">End Time *</label>
                  <input 
                    type="time" 
                    v-model="form.end_time" 
                    required 
                    class="custom-input-field code-icon-clock"
                  >
                </div>
              </div>

              <div class="space-y-2">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Venue *</label>
                <input 
                  type="text" 
                  v-model="form.venue" 
                  required 
                  class="custom-input-field"
                  placeholder="e.g., Convention Center, Main Hall"
                >
              </div>

              <div class="space-y-2">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Number of Attendees *</label>
                <input 
                  type="number" 
                  v-model="form.attendees" 
                  required 
                  min="0"
                  class="custom-input-field"
                  placeholder="0"
                >
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Male Participants *</label>
                  <input 
                    type="number" 
                    v-model="form.male" 
                    required 
                    min="0"
                    class="custom-input-field"
                    placeholder="0"
                  >
                </div>
                <div class="space-y-2">
                  <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Female Participants *</label>
                  <input 
                    type="number" 
                    v-model="form.female" 
                    required 
                    min="0"
                    class="custom-input-field"
                    placeholder="0"
                  >
                </div>
              </div>

              <div class="space-y-2">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Activity Rating (Percentage) *</label>
                <input 
                  type="number" 
                  v-model="form.rating" 
                  min="0" 
                  max="100" 
                  step="1" 
                  required 
                  class="custom-input-field"
                  placeholder="0-100%"
                >
                
                <div class="mt-4 rating-guide-panel">
                  <p class="text-11px font-bold text-slate-200 mb-2.5 tracking-wide uppercase">Rating Guide:</p>
                  <div class="space-y-2 text-10px line-height-relaxed text-slate-300">
                    <p><span class="font-bold text-emerald-400">81%-100% - Excellent:</span> Activity was completed successfully, highly engaging, impactful, and well-organized. Exceeded expectations.</p>
                    <p><span class="font-bold text-teal-400">61%-80% - Very Satisfactory:</span> Activity was completed with minor issues but was still productive, engaging, and met most objectives.</p>
                    <p><span class="font-bold text-cyan-400">41%-60% - Satisfactory:</span> Activity had some issues or lacked full engagement but met basic objectives.</p>
                    <p><span class="font-bold text-amber-400">21%-40% - Needs Improvement:</span> Activity faced significant challenges, lacked engagement or clear outcomes. Did not fully meet objectives.</p>
                    <p><span class="font-bold text-rose-400">1%-20% - Unsatisfactory:</span> Activity had major issues, minimal engagement, and failed to meet most objectives.</p>
                    <p><span class="font-bold text-rose-500">0% - Canceled:</span> Activity was canceled or did not occur at all.</p>
                  </div>
                </div>
              </div>

              <div class="space-y-3">
                <label class="block text-11px font-bold uppercase tracking-wider label-highlight">Upload Documents (PDF/ZIP - Multiple files allowed) *</label>
                <div 
                  class="upload-dropzone-box group"
                  @click="$refs.fileInput.click()"
                >
                  <input 
                    ref="fileInput"
                    type="file" 
                    @change="handleFileUpload"
                    accept=".pdf" 
                    required 
                    class="hidden"
                  >
                  <span class="text-3xl mb-2 group-hover:scale-110 transition-transform duration-200">upload</span>
                  <p class="text-xs font-semibold text-white group-hover:text-[#b979cc] transition-colors">Upload Accomplishment Report & Attachments</p>
                  <p class="text-10px text-slate-400 mt-1">PDF format allowed (Max 10MB)</p>
                  
                  <div v-if="reportFile" class="mt-4 w-full space-y-1.5" @click.stop>
                    <div class="uploaded-file-tag">
                      <span class="truncate">📄 {{ reportFile.name }}</span>
                      <span class="text-10px opacity-60 flex-shrink-0">({{ (reportFile.size / 1024).toFixed(2) }} KB)</span>
                      <button type="button" @click="removeFile" class="text-rose-400 font-bold hover:text-rose-500 text-xs ml-2 flex-shrink-0">Remove</button>
                    </div>
                  </div>
                </div>
              </div>

              <div class="flex justify-end pt-6">
                <button 
                  type="submit" 
                  class="submit-action-btn"
                >
                  Submit Report →
                </button>
              </div>
            </form>
          </div>
        </div>
      </main>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const user = ref(JSON.parse(localStorage.getItem('user') || '{}'));
const isSubmitting = ref(false);
const availableControls = ref([]);

const form = ref({
  activity_title: '',
  control_number: '',
  start_date: '',
  end_date: '',
  start_time: '',
  end_time: '',
  venue: '',
  attendees: '',
  male: '',
  female: '',
  rating: ''
});

const reportFile = ref(null);
const fileInput = ref(null);

const fetchControls = async () => {
  try {
    const userId = user.value.id || user.value.user_id;
    // Assuming you have an endpoint that joins control_number with activity_designs
    const response = await axios.get(`http://localhost:8080/api/approved-controls/${userId}`);
    if (response.data.success) {
      availableControls.value = response.data.data;
    }
  } catch (error) {
    console.error('Error fetching control numbers:', error);
  }
};

const onControlNumberChange = () => {
  const selected = availableControls.value.find(c => c.control_number === form.value.control_number);
  if (selected) {
    form.value.activity_title = selected.activity_title;
    form.value.start_date = selected.start_date;
    form.value.end_date = selected.end_date;
    
    // Formatting time from HH:MM:SS to HH:MM if necessary for HTML input
    form.value.start_time = selected.start_time?.substring(0, 5);
    form.value.end_time = selected.end_time?.substring(0, 5);
    
    form.value.venue = selected.venue;
    
    // Optional: Prefill attendees if available from activity design
    if (selected.target_participants) {
      form.value.attendees = selected.target_participants;
    }
  }
};

const handleFileUpload = (event) => {
  if (event.target.files.length > 0) {
    reportFile.value = event.target.files[0];
  }
};

const removeFile = () => {
  reportFile.value = null;
  if (fileInput.value) fileInput.value.value = '';
};

const submitReport = async () => {
  if (isSubmitting.value) return;
  isSubmitting.value = true;

  try {
    const formData = new FormData();
    const userId = user.value.id || user.value.user_id;
    
    formData.append('activity-title', form.value.activity_title);
    formData.append('control-number', form.value.control_number);
    formData.append('start-date', form.value.start_date);
    formData.append('end-date', form.value.end_date);
    formData.append('start-time', form.value.start_time);
    formData.append('end-time', form.value.end_time);
    formData.append('venue', form.value.venue);
    formData.append('attendees', form.value.attendees);
    formData.append('male', form.value.male);
    formData.append('female', form.value.female);
    formData.append('rating', form.value.rating);
    formData.append('user_id', userId);

    if (reportFile.value) {
      formData.append('attachment', reportFile.value);
    } else {
      alert('Please upload the Accomplishment Report PDF.');
      isSubmitting.value = false;
      return;
    }

    const response = await axios.post('http://localhost:8080/api/submit-activity-report', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    });

    if (response.data.success) {
      alert('Activity Report submitted successfully!');
      router.push('/college/dashboard');
    } else {
      alert(response.data.message || 'Failed to submit report.');
    }
  } catch (error) {
    console.error('AR Submission error:', error);
    alert(error.response?.data?.message || 'Server error during submission.');
  } finally {
    isSubmitting.value = false;
  }
};

onMounted(() => {
  const userId = user.value.id || user.value.user_id;
  if (!userId || !['gad_staff', 'college'].includes(user.value.role)) {
    router.push('/login');
  } else {
    fetchControls();
  }
});
</script>

<style scoped>
/* Reusing AD Styles for consistency */
.twg-view-wrapper { flex: 1; overflow-y: auto; display: flex; background: transparent; }
.text-11px { font-size: 11px; }
.form-main-title { color: #16213e; letter-spacing: -0.02em; }
.form-container-box {
  background: linear-gradient(145deg, #1a1a2e 0%, #16213e 100%);
  border: 1px solid rgba(185, 121, 204, 0.2);
  border-radius: 20px; padding: 20px;
  box-shadow: 0 20px 40px rgba(10, 10, 20, 0.4);
}
.label-highlight { color: #b979cc; letter-spacing: 0.05em; }
.custom-input-field {
  width: 100%; background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px; padding: 14px 20px; font-size: 14px; color: #ffffff;
}
.custom-input-field:focus { border-color: #b979cc; outline: none; }
.dark-option { background-color: #16213e; color: #ffffff; }
.code-icon-calendar::-webkit-calendar-picker-indicator,
.code-icon-clock::-webkit-calendar-picker-indicator {
  filter: invert(1);
  cursor: pointer;
  opacity: 0.7;
}
.upload-dropzone-box {
  border: 2px dashed rgba(185, 121, 204, 0.3);
  background: rgba(185, 121, 204, 0.02);
  border-radius: 14px; padding: 30px;
  display: flex; flex-direction: column; align-items: center; cursor: pointer;
}
.uploaded-file-tag {
  display: flex; align-items: center; justify-content: space-between;
  background: rgba(255, 255, 255, 0.05); padding: 8px 14px; border-radius: 8px;
}
.submit-action-btn {
  background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%);
  color: #ffffff; padding: 14px 40px; border-radius: 12px; font-weight: 700;
}
.submit-action-btn:disabled { opacity: 0.5; cursor: not-allowed; }
.select-arrow-fix {
  appearance: none;
  background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23b979cc' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
  background-repeat: no-repeat; background-position: right 20px center; background-size: 16px;
}
</style>