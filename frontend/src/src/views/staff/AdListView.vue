<template>
      <main class="main-content">
        <div class="content-wrapper">
          
          <div class="page-header">
            <h1 class="page-title">Activity Designs Tracker</h1>
            <p class="page-subtitle">Review, monitor compliance status, and manage submitted institutional activity plan frameworks.</p>
          </div>

          <section class="stats-section">
            <div 
              v-for="stat in metricsStats" 
              :key="stat.label" 
              class="stat-card"
            >
              <div class="stat-card-inner">
                <div :class="['stat-icon', stat.bgClass]">
                  <span class="material-symbols-outlined stat-icon-symbol" :class="stat.iconColor">
                    {{ stat.icon }}
                  </span>
                </div>
                <div class="stat-info">
                  <h3 class="stat-value">
                    {{ stat.value }}
                  </h3>
                  <p class="stat-label">
                    {{ stat.label }}
                  </p>
                </div>
              </div>
            </div>
          </section>

          <section class="filter-section">
            <div class="filter-controls">
              <div class="search-wrapper">
                <span class="search-icon">🔍</span>
                <input 
                  v-model="filters.search"
                  type="text" 
                  placeholder="Search control identifier or title..." 
                  class="search-input"
                />
              </div>

              <div class="select-wrapper">
                <select 
                  v-model="filters.office"
                  class="filter-select"
                >
                  <option value="all">All Offices & Units</option>
                  <option v-for="off in officeOptions" :key="off" :value="off">{{ off }}</option>
                </select>
                <span class="select-arrow">▼</span>
              </div>

              <div class="select-wrapper">
                <select 
                  v-model="filters.status"
                  class="filter-select"
                >
                  <option value="all">All Statuses</option>
                  <option value="Pending">Pending Review</option>
                  <option value="Approved">Approved</option>
                  <option value="Revision Required">Revision Required</option>
                </select>
                <span class="select-arrow">▼</span>
              </div>
            </div>

            <div class="per-page-controls">
              <span class="per-page-label">Show</span>
              <select 
                v-model="perPage"
                class="per-page-select"
              >
                <option :value="5">5</option>
                <option :value="10">10</option>
                <option :value="25">25</option>
              </select>
              <span class="per-page-label">records</span>
            </div>
          </section>

          <div class="table-container">
            <div class="table-wrapper">
              <table class="data-table">
                <thead>
                  <tr class="table-header-row">
                    <th class="table-header-cell">Control No.</th>
                    <th class="table-header-cell">Activity Title</th>
                    <th class="table-header-cell">Office / Unit</th>
                    <th class="table-header-cell">Form Type</th>
                    <th class="table-header-cell">Date Created</th>
                    <th class="table-header-cell">Status</th>
                  </tr>
                </thead>
                <tbody class="table-body">
                  <tr v-if="filteredDesigns.length === 0">
                    <td colspan="6" class="empty-state">
                      No matching activity design submissions found in the repository index.
                    </td>
                  </tr>
                  <tr 
                    v-else
                    v-for="item in paginatedDesigns" 
                    :key="item.act_design_id"
                    @click="viewItem(item)"
                    class="table-row"
                  >
                    <td class="table-cell control-cell">
                      {{ item.control || 'PENDING' }}
                    </td>
                    <td class="table-cell title-cell">
                      {{ item.title }}
                    </td>
                    <td class="table-cell office-cell">
                      {{ item.office }}
                    </td>
                    <td class="table-cell">
                      <span class="mandate-badge">
                        {{ item.formLabel }}
                      </span>
                    </td>
                    <td class="table-cell date-cell">
                      {{ item.date }}
                    </td>
                    <td class="table-cell">
                      <span 
                        class="status-badge"
                        :class="statusBadgeClass(item.status)"
                      >
                        {{ item.status }}
                      </span>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class="pagination-container">
              <p class="pagination-info">
                Showing <span class="pagination-highlight">{{ paginationMeta.from || 0 }}</span> to <span class="pagination-highlight">{{ paginationMeta.to || 0 }}</span> of <span class="pagination-highlight">{{ paginationMeta.total || 0 }}</span> design records
              </p>
              
              <div class="pagination-controls">
                <button 
                  :disabled="currentPage === 1"
                  @click="currentPage--"
                  class="pagination-btn"
                >
                  ←
                </button>
                <button 
                  v-for="page in paginationMeta.last_page" 
                  :key="page"
                  @click="currentPage = page"
                  :class="['pagination-page', currentPage === page && 'pagination-page-active']"
                >
                  {{ page }}
                </button>
                <button 
                  :disabled="currentPage === paginationMeta.last_page"
                  @click="currentPage++"
                  class="pagination-btn"
                >
                  →
                </button>
              </div>
            </div>
          </div>

        </div>
      </main>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const router = useRouter();
const user = ref(JSON.parse(localStorage.getItem('user') || '{}'));

const filters = ref({
  search: '',
  office: 'all',
  status: 'all'
});

const officeOptions = ref([]);

const activityDesigns = ref([]);
const currentPage = ref(1);
const perPage = ref(10);

const metricsStats = ref([
  { label: 'Total Designs', value: '0', icon: 'description', iconColor: 'text-purple-400', bgClass: 'bg-purple-500/10' },
  { label: 'Pending Reviews', value: '0', icon: 'schedule', iconColor: 'text-amber-400', bgClass: 'bg-amber-500/10' },
  { label: 'Approved Plans', value: '0', icon: 'verified', iconColor: 'text-green-400', bgClass: 'bg-green-500/10' },
  { label: 'Revision Required', value: '0', icon: 'assignment_return', iconColor: 'text-red-400', bgClass: 'bg-red-500/10' }
]);

// Reset to first page when filtering or changing page size
watch([filters, perPage], () => {
  currentPage.value = 1;
}, { deep: true });

const filteredDesigns = computed(() => {
  let records = activityDesigns.value;
  if (filters.value.search) {
    const q = filters.value.search.toLowerCase();
    records = records.filter(i => 
      (i.title && i.title.toLowerCase().includes(q)) || 
      (i.control && i.control.toLowerCase().includes(q)) || 
      (i.office && i.office.toLowerCase().includes(q))
    );
  }
  if (filters.value.office !== 'all') {
    records = records.filter(i => i.office === filters.value.office);
  }
  if (filters.value.status !== 'all') {
    records = records.filter(i => i.status === filters.value.status);
  }
  return records;
});

const paginatedDesigns = computed(() => {
  const start = (currentPage.value - 1) * perPage.value;
  const end = start + perPage.value;
  return filteredDesigns.value.slice(start, end);
});

const paginationMeta = computed(() => {
  const total = filteredDesigns.value.length;
  const lastPage = Math.ceil(total / perPage.value) || 1;
  const from = total === 0 ? 0 : (currentPage.value - 1) * perPage.value + 1;
  const to = Math.min(currentPage.value * perPage.value, total);
  
  return {
    total,
    from,
    to,
    last_page: lastPage
  };
});

const statusBadgeClass = (status) => {
  const s = status?.toLowerCase() || '';
  if (s === 'approved') return 'status-badge-approved';
  if (s.includes('revision')) return 'status-badge-revision';
  return 'status-badge-pending';
};

const viewItem = (item) => {
  const id = item.act_design_id || item.id;
  const currentUserId = user.value.id || user.value.user_id;

  if (item.type === 'design' || !item.type) { 
    if (item.status && item.status.toLowerCase().includes('revision')) {
      // Check if the staff member is the owner of the submission
      if (Number(item.user_id) === Number(currentUserId)) {
        router.push(`/staff/ad-revision/${id}`);
      } else {
        // If not the owner, redirect to read-only view even if status is revision
        router.push(`/staff/ad-view/${id}`);
      }
    } else {
      router.push(`/staff/ad-view/${id}`);
    }
  } else {
    router.push(`/staff/ar-view/${id}`);
  }
};

const fetchDesigns = async () => {
  try {
    const response = await axios.get('http://localhost:8080/api/activity-designs');
    
    if (response.data.success) {
      activityDesigns.value = response.data.data;
      
      // Update Statistics
      metricsStats.value[0].value = activityDesigns.value.length.toString();
      metricsStats.value[1].value = activityDesigns.value.filter(d => d.status === 'Pending').length.toString();
      metricsStats.value[2].value = activityDesigns.value.filter(d => d.status === 'Approved').length.toString();
      metricsStats.value[3].value = activityDesigns.value.filter(d => d.status === 'Revision Required').length.toString();

      // Extract Unique Offices for Filter
      const offices = [...new Set(activityDesigns.value.map(r => r.office).filter(Boolean))];
      officeOptions.value = offices.sort();
    }
  } catch (err) {
    activityDesigns.value = []; // Ensure table shows empty state on error
    metricsStats.value.forEach(s => s.value = '0');
    console.error("Error fetching activity designs:", err);
  }
};

const handleLogout = async () => {
  try {
    await axios.get('http://localhost:8080/api/logout');
    localStorage.removeItem('user');
    router.push('/login');
  } catch (err) {
    localStorage.removeItem('user');
    router.push('/login');
  }
};

onMounted(() => {
  const userId = user.value.id || user.value.user_id;
  if (!userId || !['gad_staff', 'college'].includes(user.value.role)) {
    router.push('/login');
  } else {
    fetchDesigns();
  }
});
</script>

<style scoped>
.main-container {
  flex-grow: 1;
  margin-left: 256px;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.app-header {
  position: fixed;
  top: 0;
  left: 256px;
  right: 0;
  height: 80px;
  background: rgba(26, 26, 46, 0.4);
  backdrop-filter: blur(24px);
  z-index: 40;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 40px;
  border-bottom: 1px solid rgba(185, 121, 204, 0.1);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.header-title {
  font-size: 1.5rem;
  font-weight: 900;
  letter-spacing: -0.025em;
  background: linear-gradient(135deg, white, #cbd5e1, #b979cc);
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
}

.header-subtitle-wrapper {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-top: 0.125rem;
}

.header-subtitle {
  font-size: 0.5625rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #b979cc;
  font-weight: 800;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.notification-wrapper {
  position: relative;
}

.notification-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(185, 121, 204, 0.2);
  font-size: 1.125rem;
  cursor: pointer;
}


.main-content {
  padding-left: 0;
  flex-grow: 1;
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.page-header {
  padding: 0 0.25rem;
}

.page-title {
  font-size: 1.5rem;
  font-weight: 900;
  letter-spacing: -0.025em;
  color: #16213e;
}

.page-subtitle {
  font-size: 0.75rem;
  color: #94a3b8;
  margin-top: 0.25rem;
}

.stats-section {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
}

.stat-card {
  padding: 1rem;
  border-radius: 1rem;
  border: 1px solid rgba(185, 121, 204, 0.15);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(8px);
  transition: all 0.3s;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
}

.stat-card:hover {
  transform: translateY(-4px);
}

.stat-card-inner {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.stat-icon {
  width: 40px;
  height: 40px;
  border-radius: 0.75rem;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.stat-icon-symbol {
  font-weight: 500;
  font-size: 1.125rem;
}

.text-purple-400 { color: #c084fc; }
.text-amber-400 { color: #fbbf24; }
.text-green-400 { color: #4ade80; }
.text-red-400 { color: #ef4444; }

.bg-purple-500\/10 { background: rgba(168, 85, 247, 0.1); }
.bg-amber-500\/10 { background: rgba(245, 158, 11, 0.1); }
.bg-green-500\/10 { background: rgba(34, 197, 94, 0.1); }
.bg-red-500\/10 { background: rgba(239, 68, 68, 0.1); }

.stat-info {
  min-width: 0;
}

.stat-value {
  font-size: 1.25rem;
  font-weight: 900;
  letter-spacing: -0.025em;
  color: white;
  line-height: 1.25;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.stat-label {
  font-size: 0.625rem;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: rgba(203, 213, 225, 0.7);
  margin-top: 0.125rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.filter-section {
  padding: 1rem;
  border-radius: 1rem;
  border: 1px solid rgba(185, 121, 204, 0.15);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.25);
  backdrop-filter: blur(8px);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
}

.filter-controls {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.75rem;
  width: auto;
}

.search-wrapper {
  position: relative;
  width: 288px;
}

.search-icon {
  position: absolute;
  left: 14px;
  top: 50%;
  transform: translateY(-50%);
  color: #94a3b8;
  font-size: 0.75rem;
}

.search-input {
  width: 100%;
  padding: 0.5rem 1rem 0.5rem 2.25rem;
  border-radius: 0.75rem;
  background: rgba(0, 0, 0, 0.4);
  border: 1px solid rgba(185, 121, 204, 0.2);
  font-size: 0.75rem;
  font-weight: 600;
  color: white;
  transition: all 0.3s;
}

.search-input:focus {
  outline: none;
  border-color: rgba(185, 121, 204, 0.5);
}

.search-input::placeholder {
  color: #64748b;
}

.select-wrapper {
  position: relative;
  width: 176px;
}

.filter-select {
  width: 100%;
  padding: 0.5rem 0.75rem;
  border-radius: 0.75rem;
  background: rgba(0, 0, 0, 0.4);
  border: 1px solid rgba(185, 121, 204, 0.2);
  font-size: 0.75rem;
  font-weight: 600;
  color: white;
  appearance: none;
  cursor: pointer;
  transition: all 0.3s;
}

.filter-select:focus {
  outline: none;
  border-color: rgba(185, 121, 204, 0.5);
}

.select-arrow {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #94a3b8;
  font-size: 0.625rem;
  pointer-events: none;
}

.per-page-controls {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.per-page-label {
  font-size: 0.6875rem;
  color: #94a3b8;
  font-weight: 500;
}

.per-page-select {
  padding: 0.375rem 0.625rem;
  border-radius: 0.5rem;
  background: rgba(0, 0, 0, 0.4);
  border: 1px solid rgba(185, 121, 204, 0.2);
  font-size: 0.75rem;
  font-weight: 700;
  color: white;
  cursor: pointer;
  transition: all 0.3s;
}

.per-page-select:focus {
  outline: none;
  border-color: rgba(185, 121, 204, 0.5);
}

.table-container {
  border-radius: 1rem;
  border: 1px solid rgba(185, 121, 204, 0.15);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  backdrop-filter: blur(8px);
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
}

.table-wrapper {
  overflow-x: auto;
}

.data-table {
  width: 100%;
  text-align: left;
  border-collapse: collapse;
}

.table-header-row {
  border-bottom: 1px solid rgba(185, 121, 204, 0.1);
  background: rgba(0, 0, 0, 0.3);
}

.table-header-cell {
  padding: 1rem 1.5rem;
  font-size: 0.625rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #b979cc;
}

.table-body {
  display: table-row-group;
}

.empty-state {
  padding: 3rem 1.5rem;
  text-align: center;
  font-size: 0.75rem;
  color: #94a3b8;
  font-weight: 500;
}

.table-row {
  transition: all 0.3s;
  border-bottom: 1px solid rgba(185, 121, 204, 0.05);
  cursor: pointer;
}

.table-row:hover {
  background: rgba(255, 255, 255, 0.05);
}

.table-cell {
  padding: 1rem 1.5rem;
}

.control-cell {
  font-family: monospace;
  font-size: 0.75rem;
  font-weight: 700;
  color: #b979cc;
}

.title-cell {
  font-weight: 600;
  color: #e2e8f0;
  transition: color 0.3s;
}

.table-row:hover .title-cell {
  color: #b979cc;
}

.office-cell {
  color: rgba(203, 213, 225, 0.8);
}

.date-cell {
  color: #94a3b8;
  font-family: monospace;
  font-size: 0.75rem;
}

.mandate-badge {
  padding: 0.25rem 0.625rem;
  border-radius: 0.5rem;
  font-size: 0.5625rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: #cbd5e1;
}

.status-badge {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  border-radius: 0.5rem;
  font-size: 0.5625rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.status-badge-pending {
  background: rgba(245, 158, 11, 0.2);
  color: #fbbf24;
  border: 1px solid rgba(245, 158, 11, 0.3);
}

.status-badge-approved {
  background: rgba(34, 197, 94, 0.2);
  color: #4ade80;
  border: 1px solid rgba(34, 197, 94, 0.3);
}

.status-badge-revision {
  background: rgba(239, 68, 68, 0.15);
  color: #ef4444;
  border: 1px solid rgba(239, 68, 68, 0.25);
}

.pagination-container {
  padding: 1rem 1.5rem;
  border-top: 1px solid rgba(185, 121, 204, 0.1);
  background: rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.pagination-info {
  font-size: 0.75rem;
  color: #94a3b8;
  font-weight: 500;
}

.pagination-highlight {
  font-weight: 700;
  color: white;
}

.pagination-controls {
  display: flex;
  align-items: center;
  gap: 0.375rem;
}

.pagination-btn {
  width: 32px;
  height: 32px;
  border-radius: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
  font-weight: 700;
  color: white;
  border: 1px solid rgba(185, 121, 204, 0.1);
  background: rgba(0, 0, 0, 0.3);
  cursor: pointer;
  transition: all 0.2s;
}

.pagination-btn:hover:not(:disabled) {
  border-color: rgba(185, 121, 204, 0.4);
}

.pagination-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.pagination-page {
  width: 32px;
  height: 32px;
  border-radius: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
  font-weight: 700;
  transition: all 0.2s;
  cursor: pointer;
  color: #94a3b8;
  border: 1px solid rgba(185, 121, 204, 0.1);
  background: rgba(0, 0, 0, 0.2);
}

.pagination-page:hover {
  border-color: rgba(185, 121, 204, 0.3);
}

.pagination-page-active {
  color: white;
  background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  border: none;
}

::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.1);
}

::-webkit-scrollbar-thumb {
  background: rgba(185, 121, 204, 0.3);
  border-radius: 99px;
}

::-webkit-scrollbar-thumb:hover {
  background: rgba(153, 13, 209, 0.5);
}

@media (max-width: 1024px) {
  .main-container {
    margin-left: 0;
  }
  
  .app-header {
    left: 0;
  }
  
  .stats-section {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .filter-section {
    flex-direction: column;
    align-items: stretch;
  }
  
  .filter-controls {
    width: 100%;
    flex-direction: column;
  }
  
  .search-wrapper,
  .select-wrapper {
    width: 100%;
  }
  
  .pagination-container {
    flex-direction: column;
  }
}

@media (max-width: 768px) {
  .content-wrapper {
    padding: 20px;
  }
  
  .stats-section {
    grid-template-columns: 1fr;
  }
}
</style>