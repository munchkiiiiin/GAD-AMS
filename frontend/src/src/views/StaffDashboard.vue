<template>
  <div class="staff-dashboard">
    <DashboardSidebar 
      roleLabel="GAD Staff" 
      :menuItems="staffMenu" 
      @logout="handleLogout" 
    />      

    <div class="dashboard-main">
      <header class="dashboard-header">
      </header>
        
      <main class="dashboard-main-content">
        <div class="content-wrapper">
          <router-view /> 
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import DashboardSidebar from '../components/DashboardSidebar.vue';

const router = useRouter();

const staffMenu = [
  { label: 'New Submission', icon: 'add', href: '/staff/submit' },
  { label: 'Dashboard', icon: 'dashboard', href: '/staff/dashboard' },
  { label: 'Submitted List', icon: 'list', href: '/staff/submitted-list' },
  { label: 'Activity Design List', icon: 'list', href: '/staff/ad-list' },
  { label: 'Accomplishment Report List', icon: 'list', href: '/staff/ar-list' },
  { label: 'Archives', icon: 'archive', href: '/staff/archive' },
  { label: 'Mandates', icon: 'gavel', href: '/staff/mandates' },
  { label: 'Report Monitoring', icon: 'description', href: '/staff/reports' },
  { label: 'Budget Monitoring', icon: 'payments', href: '/staff/budget' },
  { label: 'User Manual', icon: 'menu_book', href: '/staff/user-manual' },
  { label: 'Data Privacy Policy', icon: 'privacy_tip', href: '/staff/data-privacy-policy' }
];

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
  const user = JSON.parse(localStorage.getItem('user') || '{}');
  if (!user.id || user.role !== 'gad_staff') {
    router.push('/login');
  }
});
</script>

<style scoped>
.staff-dashboard {
  min-height: 100vh;
  display: flex;
  color: #cbd5e1;
  font-family: system-ui, -apple-system, sans-serif;
}

.dashboard-main {
  flex-grow: 1;
  margin-left: 256px;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.dashboard-header {
  background: #1a1a2e;
  border-bottom: 1px solid rgba(147, 51, 234, 0.3);
}

.dashboard-main-content {
  flex-grow: 1;
  display: block;
  width: 100%;
}

.content-wrapper {
  padding: 40px;
  width: 100%;
}

@media (max-width: 1024px) {
  .dashboard-main {
    margin-left: 0;
  }
}
</style>