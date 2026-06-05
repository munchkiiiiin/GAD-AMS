<template>
  <main class="main-viewport">
    <div v-if="loading" class="loading-wrapper">
      <div class="loading-spinner"></div>
    </div>

    <div v-else-if="error" class="error-container">
      <div class="error-box">
        <p class="error-title">Error Loading Data</p>
        <p class="error-message">{{ error }}</p>
        <button @click="router.back()" class="error-back-btn">← Go Back</button>
      </div>
    </div>

    <div v-else class="page-container">
      <div class="layout-grid">
        <!-- LEFT SECTION - Edit Form -->
        <section class="flex-06 glass-card">
          <div class="report-header">
            <div class="meta-header">
              <div class="status-badge-revision">
                <div class="status-dot-pulse"></div>
                <span class="status-text">Revision Mode</span>
              </div>
              <span class="control-number">{{ design.control || 'PENDING ASSIGNMENT' }}</span>
            </div>

            <div class="form-group-top">
              <label class="form-label">Activity Title</label>
              <input 
                v-model="formData.activity_title" 
                type="text" 
                class="modal-input title-input" 
                placeholder="Enter Activity Title"
              >
            </div>

            <div class="info-grid">
              <div class="info-item">
                <span class="info-label">Office / Unit</span>
                <span class="info-value-white">{{ formData.office }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Form Type</span>
                <select v-model="formData.form_type" class="modal-input select-input">
                  <option value="employee">Employee Training</option>
                  <option value="inset">INSET Training</option>
                  <option value="extension">Extension Program</option>
                  <option value="student">Student Activity</option>
                </select>
              </div>
            </div>
          </div>

          <div class="report-body">
            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">calendar_month</span>
                <h3 class="section-title">Schedule & Venue</h3>
              </div>
              <div class="grid-2">
                <div>
                  <label class="form-label">Start Date</label>
                  <input v-model="formData.start_date" type="date" class="modal-input">
                </div>
                <div>
                  <label class="form-label">End Date</label>
                  <input v-model="formData.end_date" type="date" class="modal-input">
                </div>
                <div>
                  <label class="form-label">Start Time</label>
                  <input v-model="formData.start_time" type="time" class="modal-input">
                </div>
                <div>
                  <label class="form-label">End Time</label>
                  <input v-model="formData.end_time" type="time" class="modal-input">
                </div>
                <div class="full-width-info">
                  <label class="form-label">Target Venue</label>
                  <input v-model="formData.venue" type="text" class="modal-input" placeholder="Enter Venue">
                </div>
              </div>
            </div>

            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">payments</span>
                <h3 class="section-title">Budget & Participants</h3>
              </div>
              <div class="grid-2">
                <div class="metric-box-edit">
                  <label class="form-label">Proposed Budget (₱)</label>
                  <input v-model="formData.proposed_budget" type="number" step="0.01" class="modal-input text-center">
                </div>
                <div class="metric-box-edit">
                  <label class="form-label">Target Participants</label>
                  <input v-model="formData.target_participants" type="number" class="modal-input text-center">
                </div>
              </div>
            </div>

            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">description</span>
                <h3 class="section-title">Supporting Documents</h3>
              </div>
              <div class="doc-item">
                <div class="doc-info">
                  <span class="material-symbols-outlined doc-pdf-icon">picture_as_pdf</span>
                  <div>
                    <p class="doc-title" v-if="!newFile">{{ design.attachment || 'No file uploaded' }}</p>
                    <p class="doc-title" v-else>{{ newFile.name }}</p>
                    <p class="doc-meta" v-if="design.attachment && !newFile">Current File</p>
                  </div>
                </div>
                <label class="preview-btn cursor-pointer">
                  <span>Change File</span>
                  <input type="file" @change="handleFileChange" class="hidden" accept=".pdf,.doc,.docx">
                </label>
              </div>
            </div>
          </div>
        </section>

        <!-- RIGHT SECTION - Feedback & Actions -->
        <section class="flex-04-sidebar">
          <div class="assessment-card-custom">
            <div class="assessment-header">
              <div class="assessment-icon">📋</div>
              <div class="assessment-title">Reviewer Feedback</div>
            </div>

            <div class="assessment-form">
              <div class="info-item mb-4">
                <span class="info-label">Previous Remarks</span>
                <div class="read-only-remarks">
                  {{ design.remarks || 'No remarks provided.' }}
                </div>
              </div>

              <div class="action-buttons">
                <button @click="handleUpdate" class="btn-approve" :disabled="submitting">
                  <span class="material-symbols-outlined">send</span> 
                  {{ submitting ? 'Updating...' : 'Resubmit for Review' }}
                </button>
                <button @click="router.back()" class="btn-back">
                  Cancel Changes
                </button>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

const route = useRoute();
const router = useRouter();
const user = ref(JSON.parse(localStorage.getItem('user') || '{}'));

const design = ref({});
const loading = ref(true);
const submitting = ref(false);
const error = ref(null);
const newFile = ref(null);

const formData = ref({
  activity_title: '',
  office: '',
  form_type: '',
  start_date: '',
  end_date: '',
  start_time: '',
  end_time: '',
  venue: '',
  proposed_budget: 0,
  target_participants: 0
});

const fetchDesignDetails = async () => {
  loading.value = true;
  try {
    const id = route.params.id;
    const response = await axios.get(`http://localhost:8080/api/activity-design/${id}`);
    if (response.data.success) {
      const fetchedDesign = response.data.data;
      const currentUserId = user.value.id || user.value.user_id;

      if (Number(fetchedDesign.user_id) !== Number(currentUserId)) {
        error.value = "Access Denied: You can only revise Activity Designs that you have submitted.";
        return;
      }

      design.value = fetchedDesign;
      formData.value = {
        activity_title: design.value.activity_title,
        office: design.value.office,
        form_type: design.value.form_type,
        start_date: design.value.start_date,
        end_date: design.value.end_date,
        start_time: design.value.start_time,
        end_time: design.value.end_time,
        venue: design.value.venue,
        proposed_budget: design.value.proposed_budget,
        target_participants: design.value.target_participants
      };
    } else {
      error.value = "Activity design not found.";
    }
  } catch (err) {
    error.value = "Failed to load activity design details.";
  } finally {
    loading.value = false;
  }
};

const handleFileChange = (e) => {
  newFile.value = e.target.files[0];
};

const handleUpdate = async () => {

  submitting.value = true;
  try {
    const id = route.params.id;
    const submitData = new FormData();
    Object.keys(formData.value).forEach(key => {
      submitData.append(key, formData.value[key]);
    });
    submitData.append('status', 'Pending'); // Reset status so admin can review again
    if (newFile.value) {
      submitData.append('attachment', newFile.value);
    }

    const response = await axios.post(`http://localhost:8080/api/update-design/${id}`, submitData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    });

    if (response.data.success) {
      alert('Activity Design updated and resubmitted successfully.');
      router.push('/staff/ad-list');
    } else {
      alert(response.data.message || 'Failed to update activity design.');
    }
  } catch (err) {
    console.error('Error updating design:', err);
    const errorMsg = err.response?.data?.message || 'Failed to update activity design. Please check your network or server logs.';
    alert(errorMsg);
  } finally {
    submitting.value = false;
  }
};

onMounted(() => {
  if (!user.value.id || user.value.role !== 'gad_staff') {
    router.push('/login');
  } else {
    fetchDesignDetails();
  }
});
</script>

<style scoped>
.main-viewport { flex: 1; overflow-y: auto; background: transparent; }
.loading-wrapper { display: flex; justify-content: center; align-items: center; min-height: 400px; }
.error-container { max-width: 48rem; margin: 0 auto; padding: 2.5rem 1.5rem; }
.error-box { background-color: #fef2f2; border-left: 4px solid #ef4444; padding: 1rem; border-radius: 0 0.75rem 0.75rem 0; }
.error-title { color: #b91c1c; font-weight: 700; }
.error-message { color: #dc2626; font-size: 0.875rem; }
.error-back-btn { margin-top: 1rem; font-size: 0.875rem; font-weight: 700; color: #b91c1c; background: transparent; border: none; cursor: pointer; }

.page-container { min-height: 100vh; }
.layout-grid { display: flex; gap: 32px; padding: 2.5rem; max-width: 80rem; margin: 0 auto; }
.flex-06 { flex: 0.6; display: flex; flex-direction: column; overflow: hidden; }
.flex-04-sidebar { flex: 0.4; position: sticky; top: 20px; align-self: flex-start; }

.glass-card { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); backdrop-filter: blur(24px); border-radius: 1.5rem; border: 1px solid rgba(185, 121, 204, 0.2); }
.report-header { padding: 2rem; border-bottom: 1px solid rgba(185, 121, 204, 0.15); background: rgba(0, 0, 0, 0.2); }
.meta-header { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1.5rem; }
.report-body { flex: 1; overflow-y: auto; padding: 2rem; }
.report-body > * + * { margin-top: 1.5rem; }

.status-badge-revision { display: inline-flex; align-items: center; gap: 8px; background-color: rgba(245, 158, 11, 0.15); color: #f59e0b; padding: 4px 12px; border-radius: 9999px; border: 1px solid rgba(245, 158, 11, 0.3); }
.status-dot-pulse { width: 8px; height: 8px; background-color: #f59e0b; border-radius: 9999px; animation: pulse 2s infinite; }
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
.status-text { font-size: 10px; font-weight: 900; text-transform: uppercase; letter-spacing: 0.1em; }

.control-number { font-size: 11px; font-weight: 700; color: #b979cc; text-transform: uppercase; margin-left: 12px; font-family: monospace; }
.form-group-top { margin-bottom: 1.5rem; }
.title-input { font-size: 1.5rem !important; font-family: 'Times New Roman', serif; font-weight: 700; }

.info-grid { display: flex; flex-wrap: wrap; gap: 24px; padding-top: 16px; border-top: 1px solid rgba(185, 121, 204, 0.1); }
.info-item { display: flex; flex-direction: column; }
.info-label { font-size: 10px; text-transform: uppercase; letter-spacing: 0.1em; color: #cbd5e1; font-weight: 700; margin-bottom: 4px; }
.info-value-white { font-size: 14px; font-weight: 600; color: white; }

.icon-pink { color: #b979cc; }
.full-width-info { grid-column: span 2; margin-top: 1rem; }

.section-card { background-color: rgba(0, 0, 0, 0.2); border-radius: 16px; padding: 24px; border: 1px solid rgba(185, 121, 204, 0.15); }
.section-header-row { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem; }
.section-title { font-weight: 800; font-size: 13px; text-transform: uppercase; letter-spacing: 0.1em; color: #b979cc; }

.grid-2 { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
.metric-box-edit { background-color: rgba(0, 0, 0, 0.3); border-radius: 12px; padding: 16px; border: 1px solid rgba(185, 121, 204, 0.1); }

.doc-item { display: flex; align-items: center; justify-content: space-between; padding: 16px; background-color: rgba(0, 0, 0, 0.3); border-radius: 12px; border: 1px solid rgba(185, 121, 204, 0.15); }
.doc-info { display: flex; align-items: center; gap: 12px; }
.doc-pdf-icon { font-size: 1.875rem; color: #ef4444; }
.doc-title { font-size: 13px; font-weight: 700; color: white; }
.doc-meta { font-size: 11px; color: #cbd5e1; margin-top: 2px; }
.preview-btn { color: #b979cc; font-size: 11px; padding: 6px 12px; border-radius: 8px; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.15); font-weight: 700; text-align: center; }
.preview-btn:hover { border-color: #b979cc; color: white; background: rgba(185, 121, 204, 0.1); }

.assessment-card-custom { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); border-radius: 1.5rem; padding: 2rem; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2); border: 1px solid rgba(185, 121, 204, 0.2); }
.assessment-header { display: flex; align-items: center; gap: 12px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid rgba(185, 121, 204, 0.15); }
.assessment-icon { width: 44px; height: 44px; background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%); border-radius: 14px; display: flex; align-items: center; justify-content: center; color: white; font-size: 22px; }
.assessment-title { font-size: 14px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: #b979cc; }
.assessment-form { display: flex; flex-direction: column; }

.read-only-remarks { width: 100%; border: 1px solid rgba(185, 121, 204, 0.2); border-radius: 12px; padding: 14px 16px; font-size: 13px; background: rgba(0, 0, 0, 0.3); color: #cbd5e1; min-height: 100px; line-height: 1.5; }

.form-label { display: block; font-size: 10px; font-weight: 800; text-transform: uppercase; color: #cbd5e1; letter-spacing: 1px; margin-bottom: 8px; }
.modal-input { width: 100%; padding: 12px 18px; border: 1px solid rgba(185, 121, 204, 0.2); background: rgba(0, 0, 0, 0.4); color: white; border-radius: 12px; font-size: 13px; }
.modal-input:focus { outline: none; border-color: #b979cc; }
.select-input { appearance: none; cursor: pointer; }

.action-buttons { display: flex; flex-direction: column; gap: 12px; margin-top: 24px; padding-top: 20px; border-top: 1px solid rgba(185, 121, 204, 0.15); }
.btn-approve { width: 100%; background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%); color: white; border: none; border-radius: 14px; padding: 14px; font-size: 12px; font-weight: 800; text-transform: uppercase; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 10px; }
.btn-approve:disabled { opacity: 0.6; cursor: not-allowed; }
.btn-approve:hover:not(:disabled) { transform: translateY(-2px); box-shadow: 0 8px 16px rgba(153, 13, 209, 0.25); }

.btn-back { display: block; width: 100%; padding: 12px; font-size: 11px; color: #cbd5e1; text-align: center; border-radius: 12px; background: transparent; border: 1px solid rgba(185, 121, 204, 0.15); margin-top: 8px; cursor: pointer; }
.btn-back:hover { color: white; border-color: #b979cc; background: rgba(185, 121, 204, 0.05); }

.loading-spinner { width: 40px; height: 40px; border: 3px solid #f3f3f3; border-top: 3px solid #990dd1; border-radius: 50%; animation: spin 1s linear infinite; }
@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
</style>