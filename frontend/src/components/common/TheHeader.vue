<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
    <div class="container-fluid">
      <router-link :to="{ name: 'home' }" class="navbar-brand">
        <img src="@/assets/book-icon.png" alt="" width="32">
        Upgread</router-link>
      <ul class="navbar-nav">
        <li v-if="!userStore.isLoggedIn" class="nav-item">
          <router-link :to="{ name: 'login'}" class="nav-link active">로그인</router-link>
        </li>
        <li v-if="!userStore.isLoggedIn" class="nav-item">
          <router-link :to="{ name: 'join' }" class="nav-link active">회원가입</router-link>
        </li>
        <li v-if="userStore.isLoggedIn" class="nav-item">
          <button class="nav-link active" @click="handleLogoutClick">로그아웃</button>
        </li>
      </ul>
    </div>
  </nav>
  <ul class="nav nav-tabs nav-justified px-3 bg-light">
    <router-link :to="{ name: 'bookRecommend' }" class="nav-link" :class="{ active: route.name?.startsWith('bookRecommend') }">책추천</router-link>
    <router-link :to="{ name: 'challenge' }" class="nav-link" :class="{ active: route.name?.startsWith('challenge') }">챌린지</router-link>
    <router-link :to="{ name: 'setting' }" class="nav-link" :class="{ active: route.name === 'setting' }">설정</router-link>
  </ul>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { onMounted } from 'vue';
import { getLogin, postLogout } from '@/api/userApi.js';
import { useUser } from '@/stores/user.js';

const route = useRoute()
const userStore = useUser()

const handleLogoutClick = async () => {
  try {
    await postLogout()
    alert("로그아웃 되었습니다")
  } catch {
    alert("로그인 상태가 아닙니다")
  }
  location.reload()
}

onMounted(async () => {
  try {
    await getLogin()
    userStore.login()
  } catch {
    userStore.logout()
  }
})


</script>

<style scoped>

</style>
