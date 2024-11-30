import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useUser = defineStore('user', () => {
  const isLoggedIn = ref(false)
  
  const login =() => {
    isLoggedIn.value = true
  }
  
  const logout = () => {
    isLoggedIn.value = false
  }
  
  return {
    isLoggedIn,
    login,
    logout,
  }
})
