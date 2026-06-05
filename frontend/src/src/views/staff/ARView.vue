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
        <!-- LEFT SECTION -->
        <section class="flex-055 glass-card">
          <div class="report-header">
            <div class="meta-header">
              <div class="status-badge-view completed">
                <span class="status-text">Completed</span>
              </div>
              <span class="control-number">{{ report.control || 'NO CONTROL NUMBER' }}</span>
            </div>

            <h2 class="report-title">{{ report.activity_title }}</h2>

            <div class="info-grid">
              <div class="info-item">
                <span class="info-label">Submitted By</span>
                <span class="info-value-purple">{{ report.username }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Office</span>
                <span class="info-value-white">{{ report.office }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Date Submitted</span>
                <span class="info-value-white">{{ report.date || '---' }}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Category</span>
                <span class="info-value-white">Accomplishment Report</span>
              </div>
            </div>
          </div>

          <div class="report-body">
            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">event_available</span>
                <h3 class="section-title">Execution Period & Venue</h3>
              </div>
              <div class="grid-2">
                <div>
                  <label class="info-label">Activity Date</label>
                  <p class="text-sm-light">{{ formatDate(report.start_date) }} — {{ formatDate(report.end_date) }}</p>
                </div>
                <div>
                  <label class="info-label">Actual Time</label>
                  <p class="text-sm-light">{{ formatTime(report.start_time) }} to {{ formatTime(report.end_time) }}</p>
                </div>
                <div class="full-width-info">
                  <label class="info-label">Venue</label>
                  <p class="text-sm-light mt-1">{{ report.venue }}</p>
                </div>
              </div>
            </div>

            <div class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">groups</span>
                <h3 class="section-title">Participation & Rating</h3>
              </div>
              <div class="grid-3">
                <div class="metric-box">
                  <p class="metric-value">{{ report.attendees }}</p>
                  <p class="metric-label">Total Attendees</p>
                </div>
                <div class="metric-box">
                  <p class="metric-value metric-split">
                    <span class="male-val">{{ report.male }}</span> <span class="divider">/</span> <span class="female-val">{{ report.female }}</span>
                  </p>
                  <p class="metric-label">Male / Female</p>
                </div>
                <div class="metric-box">
                  <p class="metric-value">{{ report.rating }}</p>
                  <p class="metric-label">/ 5.0 Rating</p>
                </div>
              </div>
            </div>

            <div v-if="report.attachment" class="section-card">
              <div class="section-header-row">
                <span class="material-symbols-outlined icon-pink">attachment</span>
                <h3 class="section-title">Uploaded Documents</h3>
              </div>
              <div class="doc-item">
                <div class="doc-info">
                  <span class="material-symbols-outlined doc-pdf-icon">picture_as_pdf</span>
                  <div>
                    <p class="doc-title">Report_Attachment.pdf</p>
                    <p class="doc-meta">Reference: {{ report.attachment }}</p>
                  </div>
                </div>
                <div class="doc-actions">
                  <button @click="previewFile()" class="preview-btn">👁️ Preview</button>
                  <button @click="downloadFile()" class="download-btn-icon">
                    <span class="material-symbols-outlined">download</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- RIGHT SECTION - Assessment Sidebar -->
        <section class="flex-045-sidebar">
          <div class="assessment-card-custom">
            <div class="assessment-header">
              <div class="assessment-icon">📋</div>
              <div class="assessment-title">Final Assessment</div>
            </div>

            <div class="assessment-form">
              <div class="info-item">
                <span class="info-label">Assessor Remarks</span>
                <div class="read-only-remarks">
                  {{ report.remarks || 'No remarks recorded for this accomplishment report.' }}
                </div>
              </div>

              <div class="action-buttons">
                <button @click="router.back()" class="btn-back">
                  ← Back to Archive
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
const report = ref({});
const loading = ref(true);
const error = ref(null);

const fetchReportDetails = async () => {
  loading.value = true;
  try {
    const id = route.params.id;
    const response = await axios.get(`http://localhost:8080/api/activity-report/${id}`);
    if (response.data.success) report.value = response.data.data;
    else error.value = "Accomplishment report not found.";
  } catch (err) {
    error.value = "Failed to load report data.";
  } finally {
    loading.value = false;
  }
};

const formatDate = (date) => date ? new Date(date).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' }) : '---';
const formatTime = (time) => {
  if (!time) return '---';
  const [h, m] = time.split(':');
  return `${h % 12 || 12}:${m} ${h >= 12 ? 'PM' : 'AM'}`;
};
const apiBaseUrl = globalThis.__API_BASE_URL__ || 'http://localhost:8080';
const previewFile = () => window.open(`${apiBaseUrl}/api/activity-report/attachment/${report.value.id}`, '_blank');
const downloadFile = () => {
  const link = document.createElement('a');
  link.href = `${apiBaseUrl}/api/activity-report/attachment/${report.value.id}`;
  link.download = `Accomplishment_Report_${report.value.control || report.value.id}.pdf`;
  link.click();
};

onMounted(() => {
  if (!user.value.id || user.value.role !== 'gad_staff') router.push('/login');
  else fetchReportDetails();
});
</script>

<style scoped>
.main-viewport { flex: 1; overflow-y: auto; background: transparent; }
.loading-wrapper { display: flex; justify-content: center; align-items: center; min-height: 400px; }
.error-container { max-width: 48rem; margin: 0 auto; padding: 2.5rem; }
.error-box { background: rgba(239, 68, 68, 0.1); border-left: 4px solid #ef4444; padding: 1rem; border-radius: 0.75rem; }
.error-title { color: #ef4444; font-weight: 700; }
.error-message { color: #cbd5e1; font-size: 0.875rem; }
.error-back-btn { margin-top: 1rem; font-size: 0.875rem; font-weight: 700; color: #ef4444; background: transparent; border: none; cursor: pointer; }
.page-container { min-height: 100vh;  }
.glass-card { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); backdrop-filter: blur(24px); border-radius: 1.5rem; border: 1px solid rgba(185, 121, 204, 0.2); }

.layout-grid { display: flex; gap: 32px; padding: 2.5rem; max-width: 80rem; margin: 0 auto; }
.flex-055 { flex: 0.55; display: flex; flex-direction: column; overflow: hidden; }
.flex-045-sidebar { flex: 0.45; position: sticky; top: 20px; align-self: flex-start; }

.report-header { padding: 2rem; border-bottom: 1px solid rgba(185, 121, 204, 0.15); background: rgba(0, 0, 0, 0.2); }
.meta-header { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem; }
.report-title { font-family: 'Times New Roman', serif; font-size: 26px; color: white; line-height: 1.25; margin: 1rem 0; }
.status-badge-view { padding: 4px 12px; border-radius: 9999px; font-size: 10px; font-weight: 900; text-transform: uppercase; letter-spacing: 0.1em; }
.status-badge-view.completed { background: rgba(34, 197, 94, 0.15); color: #22c55e; border: 1px solid rgba(34, 197, 94, 0.3); }
.control-number { font-size: 11px; font-weight: 700; color: #b979cc; text-transform: uppercase; margin-left: 12px; font-family: monospace; }
.info-grid { display: flex; flex-wrap: wrap; gap: 24px; padding-top: 16px; border-top: 1px solid rgba(185, 121, 204, 0.1); }
.info-item { display: flex; flex-direction: column; }
.info-label { font-size: 10px; text-transform: uppercase; color: #cbd5e1; font-weight: 700; margin-bottom: 4px; }
.info-value-white { font-size: 14px; font-weight: 600; color: white; }
.info-value-purple { font-size: 14px; font-weight: 600; color: #b979cc; }
.report-body { padding: 2rem; }
.report-body > * + * { margin-top: 1.5rem; }
.section-card { background: rgba(0, 0, 0, 0.2); border-radius: 16px; padding: 24px; border: 1px solid rgba(185, 121, 204, 0.15); }
.section-header-row { display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem; }
.section-title { font-weight: 800; font-size: 13px; text-transform: uppercase; color: #b979cc; }
.icon-pink { color: #b979cc; }
.text-sm-light { font-size: 0.875rem; color: #cbd5e1; font-weight: 500; }
.grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
.divider { color: rgba(203, 213, 225, 0.4); margin: 0 0.25rem; }
.male-val { color: #60a5fa; }
.female-val { color: #f472b6; }
.metric-split { display: flex; align-items: center; justify-content: center; }
.metric-box { background: rgba(0, 0, 0, 0.3); border-radius: 12px; padding: 16px; text-align: center; border: 1px solid rgba(185, 121, 204, 0.1); }
.metric-value { font-size: 24px; font-weight: 700; color: white; }
.metric-label { font-size: 10px; color: #cbd5e1; text-transform: uppercase; margin-top: 4px; }
.doc-item { display: flex; align-items: center; justify-content: space-between; padding: 16px; background: rgba(0, 0, 0, 0.3); border-radius: 12px; border: 1px solid rgba(185, 121, 204, 0.15); }
.doc-info { display: flex; align-items: center; gap: 12px; }
.doc-pdf-icon { font-size: 1.875rem; color: #ef4444; }
.doc-title { font-size: 13px; font-weight: 700; color: white; }
.doc-meta { font-size: 11px; color: #cbd5e1; margin-top: 2px; }
.preview-btn { color: #b979cc; font-size: 11px; padding: 6px 16px; border-radius: 8px; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.15); font-weight: 700; cursor: pointer; transition: all 0.2s; }
.preview-btn:hover { border-color: #b979cc; color: white; background: rgba(185, 121, 204, 0.1); }
.download-btn-icon { background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.15); color: #cbd5e1; padding: 6px; border-radius: 8px; cursor: pointer; display: flex; align-items: center; justify-content: center; }
.download-btn-icon:hover { border-color: #b979cc; color: white; }

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
.assessment-form { display: flex; flex-direction: column; }

.read-only-remarks {
  width: 100%;
  border: 1px solid rgba(185, 121, 204, 0.2);
  border-radius: 12px;
  padding: 14px 16px;
  font-size: 13px;
  background: rgba(0, 0, 0, 0.3);
  color: #cbd5e1;
  min-height: 100px;
  line-height: 1.5;
}

.action-buttons { margin-top: 24px; padding-top: 20px; border-top: 1px solid rgba(185, 121, 204, 0.15); }
.btn-back { width: 100%; padding: 12px; font-size: 11px; font-weight: 800; text-transform: uppercase; color: #cbd5e1; border-radius: 12px; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(185, 121, 204, 0.15); cursor: pointer; transition: all 0.2s; }
.btn-back:hover { color: white; border-color: #b979cc; background: rgba(185, 121, 204, 0.05); }
</style>