<template>
    <div class="bg-white p-8 rounded-2xl border border-slate-100 shadow-sm">
      <h1 class="text-3xl font-bold text-slate-900">Welcome, (Director) to your Dashboard!</h1>
      <p class="text-slate-500 mt-2">Manage your GAD programs, monitor activity designs, and oversee budget utilization from here.</p>
    </div><br>
    
  <div class="dashboard-grid">
    <div class="main-content-area">
      
      <section class="stats-section">
        <div v-for="stat in metricsStats" :key="stat.label" class="stat-card">
            <div class="stat-card-inner">
            <div :class="['stat-icon', stat.bgClass]">
                <span class="material-symbols-outlined stat-icon-symbol" :class="stat.iconColor">{{ stat.icon }}</span>
            </div>
            <div class="stat-info">
                <h3 class="stat-value">{{ stat.value }}</h3>
                <p class="stat-label">{{ stat.label }}</p>
            </div>
            </div>
        </div>
      </section>

      <div class="table-card">
        <div class="table-header-section">
          <h3 class="table-title">Your Submissions</h3>
          <router-link to="/college/submit">
            <button class="new-submission-btn">
              <span class="material-symbols-outlined">add</span>
              New Submission
            </button>
          </router-link>
        </div>
        
        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr class="table-header-row">
                <th class="table-header-cell">Control No.</th>
                <th class="table-header-cell">Title</th>
                <th class="table-header-cell">Status</th>
                <th class="table-header-cell text-right">Actions</th>
              </tr>
            </thead>
            <tbody class="table-body">
              <tr v-if="submissions.length === 0" class="empty-row">
                <td colspan="4" class="empty-cell">
                  <div class="empty-content">
                    <span class="material-symbols-outlined empty-icon">history_edu</span>
                    <p>No submissions recorded yet</p>
                  </div>
                </td>
              </tr>
              <tr v-else v-for="sub in submissions" :key="sub.id" class="clickable-row">
                <td class="control-number-cell">{{ sub.control }}</td>
                <td class="title-cell">{{ sub.title }}</td>
                <td class="status-cell">
                  <span :class="['status-pill', sub.statusClass]">
                    {{ sub.status }}
                  </span>
                </td>
                <td class="actions-cell text-right">
                  <button class="view-button">
                    <span class="material-symbols-outlined view-icon">visibility</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="sidebar-area">
      
      <div class="calendar-card">
        <h3 class="widget-title">Calendar</h3>
        <div class="calendar-container">
          <div class="weekdays-grid">
            <span v-for="day in ['S', 'M', 'T', 'W', 'T', 'F', 'S']" :key="day" class="weekday-label">{{ day }}</span>
          </div>
          <div class="dates-grid">
            <div 
              v-for="n in 31" 
              :key="n" 
              class="date-cell"
              :class="{ 'date-active': n === 18 }"
            >
              {{ n }}
              <span v-if="[20, 22, 25].includes(n)" class="event-indicator"></span>
            </div>
          </div>
        </div>
      </div>

      <div class="deadlines-card">
        <h3 class="widget-title">Upcoming Deadlines</h3>
        <div class="deadlines-list">
          <div v-if="deadlines.length === 0" class="empty-deadlines">
            <span class="material-symbols-outlined empty-icon-small">event_busy</span>
            <p>All clear! No upcoming deadlines.</p>
          </div>
          <div v-else v-for="deadline in deadlines" :key="deadline.id" class="deadline-item">
            <div class="deadline-header-row">
              <span :class="['deadline-badge', deadline.badgeClass]">
                {{ deadline.type }}
              </span>
              <span class="deadline-date-text">{{ deadline.date }}</span>
            </div>
            <h4 class="deadline-title">{{ deadline.title }}</h4>
            <p class="deadline-control-text">Control: {{ deadline.control }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const metricsStats = ref([
  { label: 'Pending Reviews', value: '0', icon: 'schedule', iconColor: 'text-amber-400', bgClass: 'bg-amber-500/10' },
  { label: 'Total Act Designs', value: '0', icon: 'description', iconColor: 'text-purple-400', bgClass: 'bg-purple-500/10' },
  { label: 'Total Acc Reports', value: '0', icon: 'analytics', iconColor: 'text-blue-400', bgClass: 'bg-blue-500/10' },
]);


const submissions = ref([]);
const deadlines = ref([]);

const fetchSubmissions = async () => {};
const fetchDeadlines = async () => {};

const loadDashboardData = async () => {
  await Promise.all([fetchSubmissions(), fetchDeadlines()]);
};

onMounted(() => {
  loadDashboardData();
});
</script>

<style scoped>
.dashboard-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
}

@media (min-width: 1200px) {
  .dashboard-grid {
    grid-template-columns: 2.2fr 1fr;
  }
}

.main-content-area, .sidebar-area {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

/* Base Card Layout Rules */
.table-card, .calendar-card, .deadlines-card {
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  border: 1px solid rgba(185, 121, 204, 0.15);
  padding: 1.75rem;
  border-radius: 1.25rem;
  box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.601);
}

.table-title, .widget-title {
  font-size: 1rem;
  font-weight: 700;
  color: #ffffff;
  margin: 0;
  letter-spacing: -0.01em;
}

.stats-section {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.stat-card {
  padding: 1rem;
  border-radius: 0.75rem;
  border: 1px solid rgba(147, 51, 234, 0.15);
  background: #16213e;
  transition: transform 0.2s ease;
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
  border-radius: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat-icon-symbol {
  font-size: 1.125rem;
}

.stat-value {
    font-size: 1.25rem;
    font-weight: 800;
    color:#fff;
}

.stat-label {
    font-size: 0.65rem;
    font-weight: 400;
    color: #cbd5e1;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.new-submission-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.813rem;
  font-weight: 700;
  color: #ffffff;
  background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%);
  border: none;
  border-radius: 0.75rem;
  padding: 0.625rem 1.25rem;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(153, 13, 209, 0.4);
  transition: all 0.2s ease;
}

.new-submission-btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 20px rgba(153, 13, 209, 0.6);
  filter: brightness(1.1);
}

.table-header-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.25rem;
}

.table-responsive {
  overflow-x: auto;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.table-header-row {
  font-size: 0.60rem;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #b979cc;
  border-bottom: 1px solid rgba(185, 121, 204, 0.2);
}

.table-header-cell {
  padding: 0.75rem 1rem 1rem 1rem;
}

.clickable-row {
  border-bottom: 1px solid rgba(255, 255, 255, 0.04);
  transition: background-color 0.2s ease;
}

.clickable-row:hover {
  background-color: rgba(185, 121, 204, 0.06);
}

.control-number-cell {
  padding: 1.25rem 1rem;
  font-weight: 700;
  color: #b979cc;
  font-size: 0.875rem;
}

.title-cell {
  padding: 1.25rem 1rem;
  color: #ffffff;
  font-size: 0.875rem;
}

.status-cell {
  padding: 1.25rem 1rem;
}

.status-pill {
  display: inline-flex;
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 700;
}

.status-approved { background-color: rgba(34, 197, 94, 0.15); color: #4ade80; }
.status-review { background-color: rgba(59, 130, 246, 0.15); color: #60a5fa; }
.status-revision { background-color: rgba(239, 68, 68, 0.15); color: #f87171; }

.actions-cell {
  padding: 1.25rem 1rem;
}

.text-right {
  text-align: right;
}

.view-button {
  background: rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(185, 121, 204, 0.15);
  border-radius: 0.5rem;
  padding: 0.45rem;
  cursor: pointer;
  color: #cbd5e1;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.view-button:hover {
  color: #ffffff;
  background: rgba(153, 13, 209, 0.2);
  border-color: #b979cc;
}

.view-icon {
  font-size: 1.2rem;
}

.empty-cell {
  padding: 5rem 2rem;
  text-align: center;
}

.empty-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
}

.empty-icon {
  font-size: 3rem;
  color: rgba(185, 121, 204, 0.3);
}

.empty-content p, .empty-deadlines p {
  color: #cbd5e1;
  font-size: 0.70rem;
  margin: 0;
  opacity: 0.7;
}

.calendar-card .widget-title {
  margin-bottom: 1.5rem;
}

.weekdays-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  text-align: center;
  margin-bottom: 0.75rem;
}

.weekday-label {
  font-size: 0.75rem;
  font-weight: 700;
  color: #b979ccc1;
}

.dates-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 0.35rem;
  text-align: center;
}

.date-cell {
  position: relative;
  padding: 0.6rem 0;
  font-size: 0.70rem;
  font-weight: 600;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.15s ease;
  color: #ffffffd2;
}

.date-cell:hover:not(.date-active) {
  background-color: rgba(185, 121, 204, 0.15);
}

.date-active {
  background: linear-gradient(135deg, #990dd1 0%, #b979cc 100%);
  color: #ffffff;
  font-weight: 800;
  box-shadow: 0 4px 12px rgba(153, 13, 209, 0.4);
}

.event-indicator {
  position: absolute;
  bottom: 0.25rem;
  left: 50%;
  transform: translateX(-50%);
  width: 0.25rem;
  height: 0.25rem;
  background-color: #ef4444;
  border-radius: 50%;
}

/* Contextual Target Evaluation Logs */
.deadlines-card .widget-title {
  margin-bottom: 1.5rem;
}

.deadlines-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.empty-deadlines {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  padding: 2.5rem 1rem;
}

.empty-icon-small {
  font-size: 2.25rem;
  color: rgba(185, 121, 204, 0.3);
}

.deadline-item {
  padding: 1rem;
  border-radius: 0.875rem;
  background: rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(185, 121, 204, 0.1);
  transition: all 0.2s ease;
}

.deadline-item:hover {
  border-color: rgba(185, 121, 204, 0.3);
  background: rgba(0, 0, 0, 0.3);
}

.deadline-header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.625rem;
}

.deadline-badge {
  padding: 0.15rem 0.5rem;
  border-radius: 0.375rem;
  font-size: 0.688rem;
  font-weight: 700;
  text-transform: uppercase;
}

.badge-revision { background-color: rgba(239, 68, 68, 0.15); color: #f87171; }
.badge-submission { background-color: rgba(234, 179, 8, 0.15); color: #facc15; }

.deadline-date-text {
  font-size: 0.75rem;
  font-weight: 600;
  color: #cbd5e1;
  opacity: 0.8;
}

.deadline-title {
  font-size: 0.875rem;
  font-weight: 700;
  color: #ffffff;
  margin: 0 0 0.375rem 0;
  line-height: 1.4;
}

.deadline-control-text {
  font-size: 0.75rem;
  color: #b979cc;
  margin: 0;
}
</style>