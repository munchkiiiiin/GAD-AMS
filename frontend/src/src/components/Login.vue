<template>
  <div class="login-container">
    <h2>Login to GAD Portal</h2>
    <form @submit.prevent="handleLogin">
      <div class="form-group">
        <label>Username or Email</label>
        <input v-model="identity" type="text" required placeholder="Enter username or email" />
      </div>
      <div class="form-group">
        <label>Password</label>
        <input v-model="password" type="password" required placeholder="Enter password" />
      </div>
      <button type="submit" :disabled="loading">
        {{ loading ? 'Logging in...' : 'Login' }}
      </button>
      <p v-if="error" class="error">{{ error }}</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

const identity = ref('');
const password = ref('');
const loading = ref(false);
const error = ref('');

const handleLogin = async () => {
  loading.value = true;
  error.value = '';
  
  try {
    const response = await axios.post('http://localhost:8080/api/login', {
      identity: identity.value,
      password: password.value
    });
    
    alert('Login successful! Welcome ' + response.data.user.username);
    // Here you would typically store the user data and redirect
  } catch (err) {
    console.error('Login error:', err);
    
    if (err.response) {
      // Backend responded with error
      error.value = err.response.data?.message || err.response.data?.messages?.error || 'Login failed. Please try again.';
    } else if (err.request) {
      // Request made but no response
      error.value = 'No response from the backend. Please check the configured API URL.';
    } else {
      // Other errors
      error.value = 'An error occurred. Please try again.';
    }
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.login-container {
  max-width: 400px;
  margin: 50px auto;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background: white;
}
.form-group {
  margin-bottom: 15px;
}
label {
  display: block;
  margin-bottom: 5px;
}
input {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 10px;
  background-color: #6100a4;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
button:disabled {
  background-color: #ccc;
}
.error {
  color: red;
  margin-top: 10px;
}
</style>
