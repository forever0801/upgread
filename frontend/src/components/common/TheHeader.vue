<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
    <div class="container-fluid">
      <router-link :to="{ name: 'home' }" class="navbar-brand">
        <img src="@/assets/book-icon.png" alt="" width="32">
        Upgread</router-link>
      <ul class="navbar-nav">
        <li class="nav-item">
          <router-link :to="{ name: 'login'}" class="nav-link active">로그인</router-link>
        </li>
        <li class="nav-item">
          <router-link :to="{ name: 'join' }" class="nav-link active">회원가입</router-link>
        </li>
      </ul>
    </div>
  </nav>
  <ul class="nav nav-tabs nav-justified px-3 bg-light">
    <router-link :to="{ name: 'book-recommend' }" class="nav-link" :class="{ active: route.name === 'book-recommend' }">책추천</router-link>
    <router-link :to="{ name: 'challenge' }" class="nav-link" :class="{ active: route.name?.startsWith('challenge') }">챌린지</router-link>
    <router-link :to="{ name: 'setting' }" class="nav-link" :class="{ active: route.name === 'setting' }">설정</router-link>
  </ul>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { onMounted } from 'vue';

const route = useRoute()
onMounted(() => {
  console.log(route.name)
})
</script>

<style scoped>

</style>
