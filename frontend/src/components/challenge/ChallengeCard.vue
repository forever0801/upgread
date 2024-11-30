<template>
  <router-link :to="{ name: 'challengeDetail', params: { id: 1 } }" class="card my-2" style="text-decoration: none">
    <div class="card-body">
      <h5 class="card-title">2024 독서모임</h5>
      <div class="row">
        <div class="col-8">
          <h6 class="card-subtitle mb-2 text-muted">25명 참여중</h6>
          <p class="card-text">올해에는 책을 좀 읽어봅시다</p>
        </div>
        <div class="col-4">
          <h6 class="card-subtitle mb-2 text-muted">기간 : 7일</h6>
          <h6 class="card-subtitle mb-2 text-muted">목표 : 100페이지</h6>

        </div>
      </div>
      <button class="btn btn-primary mt-2" @click.stop.prevent="">참여하기</button>
    </div>
  </router-link>
</template>

<script setup>
</script>

<style scoped>
</style>
