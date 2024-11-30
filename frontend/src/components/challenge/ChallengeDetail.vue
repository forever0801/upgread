<template>
  <div>
    <div class="card my-2">
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
        <p class="card-text col-8 mt-5 mb-2 fs-4">나의 진행도 : 70%</p>
        <p>
          <button class="btn btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            진행상황 입력
          </button>
        </p>
        <div class="collapse" id="collapseExample">
          <label for="progress" class="form-label">현재 진행상황 (페이지)</label>
          <input type="number" class="form-control" id="progress" value="30">
          <button class="btn btn-outline-primary my-2">저장하기</button>
        </div>
        <h5 class="card-title mt-5">참여중인 사람</h5>
        <span class="badge bg-primary fs-5 me-3">이하경</span>
        <span class="badge bg-primary fs-5">이수진</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router';

const route = useRoute();
</script>

<style scoped>

</style>
