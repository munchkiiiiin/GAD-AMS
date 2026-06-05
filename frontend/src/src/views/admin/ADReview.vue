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
        <!-- LEFT SECTION - Design Preview (60%) -->
        <section class="flex-06 glass-card">
          <div class="report-header">
            <div class="meta-header">
            <div class="status-badge-review">
              <div class="status-dot-pulse"></div>
              <span class="status-text">Under Review</span>
            </div>
            <span class="control-number">{{ design.control || 'PENDING ASSIGNMENT' }}</span>
          </div>

            <h2 class="report-title">{{ design.activity_title }}</h2>

          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Office / Unit</span>
              <span class="info-value-purple">{{ design.office }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Date Submitted</span>
                <span class="info-value-white">{{ design.date || '---' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Category</span>
                <span class="info-value-white">Activity Design</span>
            </div>
            <div class="info-item">
              <span class="info-label">Form Type</span>
                <span class="info-value-white uppercase">{{ design.formLabel }}</span>
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
                  <label class="info-label">Implementation Period</label>
                  <p class="text-sm-light" style="color: #fff;">
                    {{ formatDate(design.start_date) }} — {{ formatDate(design.end_date) }}
                  </p>
                </div>
                <div>
                  <label class="info-label">Proposed Time</label>
                  <p class="text-sm-light" style="color: #fff;">
                    {{ formatTime(design.start_time) }} to {{ formatTime(design.end_time) }}
                  </p>
                </div>
                <div class="full-width-info">
                  <label class="info-label">Target Venue</label>
                  <p class="text-sm-light mt-1" style="color: #fff;">
                    {{ design.venue }}
                  </p>
                </div>
              </div>
            </div>

            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">payments</span>
                <h3 class="section-title">Budget & Participants</h3>
              </div>
              <div class="grid-2">
                <div class="metric-box">
                  <p class="metric-value">₱{{ formatCurrency(design.proposed_budget) }}</p>
                  <p class="metric-label">Total Proposed Budget</p>
                </div>
                <div class="metric-box">
                  <p class="metric-value">{{ design.target_participants }}</p>
                  <p class="metric-label">Expected Participants</p>
                </div>
              </div>
            </div>

            <div v-if="design.attachment" class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">description</span>
                <h3 class="section-title">Supporting Documents</h3>
              </div>
              <div class="doc-item">
                <div class="doc-info">
                  <span class="material-symbols-outlined doc-pdf-icon">picture_as_pdf</span>
                  <div>
                    <p class="doc-title">Activity_Design_Framework.pdf</p>
                    <p class="doc-meta">Reference: {{ design.attachment }}</p>
                  </div>
                </div>
                <button @click="previewFile(design.attachment)" class="preview-btn">
                  👁️ Preview
                </button>
              </div>
            </div>
          </div>
        </section>

        <!-- RIGHT SECTION - Sidebar (40%) -->
        <section class="flex-04-sidebar">
          <div class="assessment-card-custom">
            <div class="assessment-header">
              <div class="assessment-icon">📋</div>
              <div class="assessment-title">Design Assessment</div>
            </div>

            <div class="assessment-form">
              <div>
                <label class="form-label">Assign Control Number</label>
                <input 
                  v-model="controlNumber"
                  type="text" 
                  class="modal-input" 
                  placeholder="2026-0000"
                >
              </div>

              <div>
                <label class="form-label">Date of Assessment</label>
                <input 
                  v-model="assessmentDate"
                  type="date" 
                  class="modal-input"
                >
              </div>

              <div>
                <label class="form-label">Accomplishment Deadline</label>
                <input 
                  v-model="accomplishmentDeadline"
                  type="date" 
                  class="modal-input"
                >
              </div>

              <div>
                <label class="form-label">Remarks/Comments (Optional)</label>
                <textarea 
                  v-model="assessmentRemarks"
                  rows="3" 
                  class="form-textarea" 
                  placeholder="Add observations..."
                ></textarea>
              </div>

              <div class="action-buttons">
                <button @click="handleApprove" class="btn-approve" :disabled="submitting">
                  <span class="material-symbols-outlined">check_circle</span> 
                  {{ submitting ? 'Processing...' : 'Approve & Archive' }}
                </button>
                <button @click="showRevisionModal = true" class="btn-revision">
                  <span class="material-symbols-outlined">edit_note</span> REVISION
                </button>
                <button @click="showCancelModal = true" class="btn-cancel-req">
                  <span class="material-symbols-outlined">cancel</span> CANCEL REQUEST
                </button>
                <button @click="router.back()" class="btn-back">
                  ← Back to Submissions
                </button>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>

    <!-- Revision Modal -->
    <div v-if="showRevisionModal" class="revision-modal show">
      <div class="revision-modal-content">
        <div class="revision-modal-header">
          <h3><span class="material-symbols-outlined">edit_note</span> Request Revision</h3>
        </div>
        <div class="revision-modal-body">
          <div class="activity-preview">
            <p>Target Activity:</p>
            <h4>{{ design.activity_title }}</h4>
          </div>

          <div class="form-group">
            <label>Revision Remarks / Comments</label>
            <textarea 
              v-model="revisionRemarks"
              class="modal-textarea"
              rows="4" 
              placeholder="Please provide detailed comments..."
            ></textarea>
          </div>

          <div class="form-group">
            <label>Revision Deadline</label>
            <input type="date" v-model="revisionDeadline" class="modal-input">
            <p class="input-hint">Proponent must resubmit by this date.</p>
          </div>
        </div>
        <div class="revision-modal-footer">
          <button @click="showRevisionModal = false" class="btn-cancel-modal">Cancel</button>
          <button @click="handleSendRevision" class="btn-send">
            <span class="material-symbols-outlined">send</span> Send Request
          </button>
        </div>
      </div>
    </div>

    <!-- Cancel Modal -->
    <div v-if="showCancelModal" class="revision-modal show">
      <div class="revision-modal-content border-red-500/50">
        <div class="revision-modal-header from-red-600 to-red-400">
          <h3><span class="material-symbols-outlined">warning</span> Confirm Cancellation</h3>
        </div>
        <div class="revision-modal-body">
          <p class="text-sm-light mb-4">Are you sure you want to cancel this request? This action will move it to the archive as 'Cancelled'.</p>
          
          <div class="form-group">
            <label class="text-red-400">Reason for Cancellation</label>
            <textarea 
              v-model="cancelReason" 
              class="modal-textarea border-red-500/30" 
              rows="3" 
              placeholder="Required reason..."
            ></textarea>
          </div>
        </div>
        <div class="revision-modal-footer">
          <button @click="showCancelModal = false" class="btn-cancel-modal">Go Back</button>
          <button @click="handleConfirmCancel" class="btn-send from-red-600 to-red-400">
            <span class="material-symbols-outlined">check_circle</span> Confirm
          </button>
        </div>
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

const assessmentRemarks = ref('');
const controlNumber = ref('');
const assessmentDate = ref(new Date().toISOString().split('T')[0]);
const accomplishmentDeadline = ref('');

const showRevisionModal = ref(false);
const revisionRemarks = ref('');
const revisionDeadline = ref('');
const showCancelModal = ref(false);
const cancelReason = ref('');

const fetchDesignDetails = async () => {
  loading.value = true;
  try {
    const id = route.params.id;
    const response = await axios.get(`http://localhost:8080/api/activity-design/${id}`);
    if (response.data.success) {
      design.value = response.data.data;
      // Pre-fill control number if already assigned
      if (design.value.control && design.value.control !== 'PENDING ASSIGNMENT') {
        controlNumber.value = design.value.control;
      }
    } else {
      error.value = "Activity design not found.";
    }
  } catch (err) {
    console.error('Error fetching design:', err);
    error.value = "Failed to load activity design.";
  } finally {
    loading.value = false;
  }
};

const handleApprove = async () => {
  if (!controlNumber.value) return alert('Please assign a control number before approval.');
  if (!accomplishmentDeadline.value) return alert('Please set a deadline for the accomplishment report.');

  if (!confirm('Are you sure you want to approve this activity design? It will be moved to the archive.')) return;
  
  submitting.value = true;
  try {
    const id = design.value.act_design_id;
    const response = await axios.post(`http://localhost:8080/api/archive-design/${id}`, {
      control_number: controlNumber.value,
      assessment_date: assessmentDate.value,
      accomplishment_deadline: accomplishmentDeadline.value,
      remarks: assessmentRemarks.value
    });
    if (response.data.success) {
      alert('Activity Design approved and successfully archived.');
      router.push('/admin/ad-list');
    }
  } catch (err) {
    console.error('Error approving design:', err);
    alert('Failed to approve activity design.');
  } finally {
    submitting.value = false;
  }
};

const handleSendRevision = () => {
  if (!revisionRemarks.value || !revisionDeadline.value) return alert('Please provide feedback and deadline.');
  alert('Revision request sent to proponent.');
  router.push('/admin/ad-list');
};

const handleConfirmCancel = () => {
  if (!cancelReason.value) return alert('Please provide a reason for cancellation.');
  alert('Request cancelled and archived.');
  router.push('/admin/ad-list');
};

const formatDate = (date) => {
  if (!date) return '---';
  return new Date(date).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
};

const formatTime = (time) => {
  if (!time) return '---';
  const [hours, minutes] = time.split(':');
  const period = hours >= 12 ? 'PM' : 'AM';
  const h = hours % 12 || 12;
  return `${h}:${minutes} ${period}`;
};

const formatCurrency = (amount) => {
  if (!amount) return '0.00';
  return parseFloat(amount).toLocaleString(undefined, { minimumFractionDigits: 2 });
};

const uploadBaseUrl = globalThis.__UPLOAD_BASE_URL__ || globalThis.__API_BASE_URL__ || 'http://localhost:8080';

const previewFile = (fileName) => {
  if (!fileName) return;
  window.open(`${uploadBaseUrl}/uploads/${fileName}`, '_blank');
};

onMounted(() => {
  if (!user.value.id || user.value.role !== 'admin') {
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
.error-back-btn:hover { text-decoration: underline; }

.layout-grid { display: flex; gap: 32px; padding: 2.5rem; max-width: 80rem; margin: 0 auto; }
.flex-06 { flex: 0.6; display: flex; flex-direction: column; overflow: hidden; }
.flex-04-sidebar { flex: 0.4; position: sticky; top: 20px; align-self: flex-start; }

button { transition: all 0.2s ease-in-out; cursor: pointer; }

/* Page & Cards */
.page-container {
  min-height: 100vh;
  
}

.glass-card {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  backdrop-filter: blur(24px);
  border-radius: 1.5rem;
  border: 1px solid rgba(185, 121, 204, 0.2);
}

.report-header { padding: 2rem; border-bottom: 1px solid rgba(185, 121, 204, 0.15); background: rgba(0, 0, 0, 0.2); }
.meta-header { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem; }
.report-body { flex: 1; overflow-y: auto; padding: 2rem; }
.report-body > * + * { margin-top: 1.5rem; }
.assessment-form { display: flex; flex-direction: column; gap: 1rem; }

.status-badge-review {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background-color: rgba(236, 210, 36, 0.15);
  color: #ecd224;
  padding: 4px 12px;
  border-radius: 9999px;
  border: 1px solid rgba(236, 210, 36, 0.3);
}
.status-dot-pulse { width: 8px; height: 8px; background-color: #ecd224; border-radius: 9999px; animation: pulse 2s infinite; }
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
.status-text { font-size: 10px; font-weight: 900; text-transform: uppercase; letter-spacing: 0.1em; }

.control-number { font-size: 11px; font-weight: 700; color: #b979cc; text-transform: uppercase; margin-left: 12px; font-family: monospace; }
.report-title { font-family: 'Times New Roman', serif; font-size: 26px; color: white; line-height: 1.25; margin-bottom: 16px; margin-top: 16px; }

.info-grid { display: flex; flex-wrap: wrap; gap: 24px; padding-top: 16px; border-top: 1px solid rgba(185, 121, 204, 0.1); }
.info-item { display: flex; flex-direction: column; }
.info-label { font-size: 10px; text-transform: uppercase; letter-spacing: 0.1em; color: #cbd5e1; font-weight: 700; margin-bottom: 4px; }
.info-value-white { font-size: 14px; font-weight: 600; color: white; }
.info-value-purple { font-size: 14px; font-weight: 600; color: #b979cc; }

.icon-pink { color: #b979cc; }
.text-sm-light { font-size: 0.875rem; color: #cbd5e1; font-weight: 500; margin-top: 0.25rem; }
.full-width-info { grid-column: span 2; margin-top: 1rem; }

.section-card { background-color: rgba(0, 0, 0, 0.2); border-radius: 16px; padding: 24px; border: 1px solid rgba(185, 121, 204, 0.15); }
.section-header-row { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem; }
.section-title { font-weight: 800; font-size: 13px; text-transform: uppercase; letter-spacing: 0.1em; color: #b979cc; }

.grid-2 { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
.metric-box { background-color: rgba(0, 0, 0, 0.3); border-radius: 12px; padding: 16px; text-align: center; border: 1px solid rgba(185, 121, 204, 0.1); }
.metric-value { font-size: 24px; font-weight: 700; color: white; }
.metric-label { font-size: 10px; color: #cbd5e1; text-transform: uppercase; margin-top: 4px; }

.doc-item { display: flex; align-items: center; justify-content: space-between; padding: 16px; background-color: rgba(0, 0, 0, 0.3); border-radius: 12px; border: 1px solid rgba(185, 121, 204, 0.15); }
.doc-info { display: flex; align-items: center; gap: 12px; }
.doc-pdf-icon { font-size: 1.875rem; color: #ef4444; }
.doc-title { font-size: 13px; font-weight: 700; color: white; }
.doc-meta { font-size: 11px; color: #cbd5e1; margin-top: 2px; }
.preview-btn { color: #b979cc; font-size: 11px; padding: 6px 12px; border-radius: 8px; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.15); font-weight: 700; }
.preview-btn:hover { border-color: #b979cc; color: white; background: rgba(185, 121, 204, 0.1); }

.assessment-card-custom {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  border-radius: 1.5rem;
  padding: 2rem;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(185, 121, 204, 0.2);
}

.assessment-header { display: flex; align-items: center; gap: 12px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid rgba(185, 121, 204, 0.15); }
.assessment-icon { width: 44px; height: 44px; background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%); border-radius: 14px; display: flex; align-items: center; justify-content: center; color: white; font-size: 22px; }
.assessment-title { font-size: 14px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: #b979cc; }

.form-label { display: block; font-size: 10px; font-weight: 800; text-transform: uppercase; color: #cbd5e1; letter-spacing: 1px; margin-bottom: 8px; }
.form-textarea { width: 100%; border: 1px solid rgba(185, 121, 204, 0.2); border-radius: 12px; padding: 14px 16px; font-size: 13px; font-family: inherit; background: rgba(0, 0, 0, 0.3); color: white; resize: vertical; }
.form-textarea:focus { outline: none; border-color: #b979cc; }

.action-buttons { display: flex; flex-direction: column; gap: 12px; margin-top: 24px; padding-top: 20px; border-top: 1px solid rgba(185, 121, 204, 0.15); }

.btn-approve {
  width: 100%;
  background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%);
  color: white; border: none; border-radius: 14px; padding: 14px;
  font-size: 12px; font-weight: 800; text-transform: uppercase;
  display: flex; align-items: center; justify-content: center; gap: 10px;
}
.btn-approve:hover:not(:disabled) { transform: translateY(-2px); box-shadow: 0 8px 16px rgba(153, 13, 209, 0.25); }

.btn-revision {
  width: 100%; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.3); color: white;
  border-radius: 14px; padding: 14px; font-size: 12px; font-weight: 800; text-transform: uppercase;
  display: flex; align-items: center; justify-content: center; gap: 10px;
}
.btn-revision:hover { background: rgba(0,0,0,0.5); border-color: rgba(185, 121, 204, 0.5); }

.btn-cancel-req {
  width: 100%; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(239, 68, 68, 0.3); color: #ef4444;
  border-radius: 14px; padding: 14px; font-size: 12px; font-weight: 800; text-transform: uppercase;
  display: flex; align-items: center; justify-content: center; gap: 10px;
}
.btn-cancel-req:hover { background: rgba(239, 68, 68, 0.1); border-color: #ef4444; }

.btn-back { display: block; width: 100%; padding: 12px; font-size: 11px; color: #cbd5e1; text-align: center; border-radius: 12px; background: transparent; border: 1px solid rgba(185, 121, 204, 0.15); margin-top: 8px; }
.btn-back:hover { color: white; border-color: #b979cc; background: rgba(185, 121, 204, 0.05); }

/* Modals */
.revision-modal { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.7); backdrop-filter: blur(8px); display: flex; align-items: center; justify-content: center; z-index: 1000; display: none; }
.revision-modal.show { display: flex; }
.revision-modal-content { background: #1a1a2e; border: 1px solid rgba(185, 121, 204, 0.3); border-radius: 24px; max-width: 520px; width: 90%; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); overflow: hidden; }
.revision-modal-header { background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%); padding: 24px 28px; color: white; }
.revision-modal-header h3 { font-size: 22px; font-weight: 800; display: flex; align-items: center; gap: 12px; }
.revision-modal-body { padding: 28px; }
.revision-modal-footer { padding: 20px 28px; background: rgba(0, 0, 0, 0.2); display: flex; gap: 14px; justify-content: flex-end; border-top: 1px solid rgba(185, 121, 204, 0.15); }

.activity-preview { background: rgba(0, 0, 0, 0.3); padding: 20px; border-radius: 16px; margin-bottom: 24px; border: 1px solid rgba(185, 121, 204, 0.1); }
.activity-preview p { font-size: 11px; color: #cbd5e1; opacity: 0.6; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 1px; }
.activity-preview h4 { font-size: 16px; font-weight: 700; color: white; }

.form-group { margin-bottom: 24px; }
.form-group label { display: block; font-size: 11px; font-weight: 800; text-transform: uppercase; color: #cbd5e1; letter-spacing: 1px; margin-bottom: 10px; }
.modal-textarea { width: 100%; padding: 14px 18px; border: 1px solid rgba(185, 121, 204, 0.2); background: rgba(0, 0, 0, 0.4); color: white; border-radius: 14px; font-size: 13px; font-family: inherit; }
.modal-input { width: 100%; padding: 12px 18px; border: 1px solid rgba(185, 121, 204, 0.2); background: rgba(0, 0, 0, 0.4); color: white; border-radius: 12px; font-size: 13px; }
.modal-input:focus { outline: none; border-color: #b979cc; }
.input-hint { font-size: 9px; color: #cbd5e1; opacity: 0.6; margin-top: 8px; }

.btn-send { background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%); color: white; border: none; padding: 14px 28px; border-radius: 14px; font-weight: 800; font-size: 12px; text-transform: uppercase; cursor: pointer; display: flex; align-items: center; gap: 10px; }
.btn-send:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(153, 13, 209, 0.3); }
.btn-cancel-modal { background: rgba(0, 0, 0, 0.3); color: #cbd5e1; border: 1px solid rgba(185, 121, 204, 0.15); padding: 14px 28px; border-radius: 14px; font-weight: 800; font-size: 12px; text-transform: uppercase; cursor: pointer; }
.btn-cancel-modal:hover { background: rgba(0, 0, 0, 0.5); border-color: #b979cc; color: white; }

.loading-spinner { width: 40px; height: 40px; border: 3px solid #f3f3f3; border-top: 3px solid #990dd1; border-radius: 50%; animation: spin 1s linear infinite; }
@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
</style>