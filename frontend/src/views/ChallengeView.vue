<template>
  <div class="row px-3 py-5">
    <ul class="col-3 list-group list-group-flush">
      <router-link :to="{ name: 'challengeAll' }" class="list-group-item list-group-item-action" :class="{ active: route.name === 'challengeAll'}">전체</router-link>
      <router-link :to="{ name: 'challengeJoin' }" class="list-group-item list-group-item-action" :class="{ active: route.name === 'challengeJoin'}">참여중</router-link>
      <router-link :to="{ name: 'challengeHistory' }" class="list-group-item list-group-item-action" :class="{ active: route.name === 'challengeHistory'}">기록</router-link>
    </ul>
    <router-view class="col-9"></router-view>
  </div>
</template>

<script setup>
  import { useRoute } from 'vue-router';

  const route = useRoute()
</script>

<style scoped>

</style>
