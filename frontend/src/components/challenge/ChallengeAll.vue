<template>
  <div>
    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#makeModal">챌린지 만들기
    </button>
    <router-link v-for="challenge in challenges" :to="{ name: 'challengeDetail', params: { id: challenge.challengeId }}" class="card my-2" style="text-decoration: none">
      <div class="card-body">
        <h5 class="card-title">{{ challenge.challengeName }}</h5>
        <div class="row">
          <div class="col-8">
            <h6 class="card-subtitle mb-2 text-muted">{{ challenge.participantCount }}명 참여중</h6>
            <p class="card-text">{{ challenge.description }}</p>
          </div>
          <div class="col-4">
            <h6 class="card-subtitle mb-2 text-muted">기간 : {{ challenge.duration }}일</h6>
            <h6 class="card-subtitle mb-2 text-muted">목표 : {{ challenge.goal }}{{ challenge.type === 'pages' ? "페이지" : "권" }}</h6>

          </div>
        </div>
        <button v-if="challenge.participationStatus === 'not_joined'" class="btn btn-primary mt-2" @click.stop.prevent="">참여하기</button>
        <button v-else class="btn btn-primary mt-2" @click.stop.prevent="">탈퇴하기</button>
      </div>
    </router-link>
    <div class="modal fade" id="makeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">챌린지 생성</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="mb-3">
              <label for="title" class="form-label">챌린지 이름</label>
              <input type="text" class="form-control" id="title" placeholder="2024 독서모임">
            </div>
            <div class="mb-3">
              <label for="description" class="form-label">설명</label>
              <input type="text" class="form-control" id="description" placeholder="올해는 책을 읽어보자">
            </div>
            <div class="mb-3">
              <div class="form-label">목표</div>
              <input type="number" class="form-control mb-1" id="goal" placeholder="100">
              <div class="form-check">
                <input class="form-check-input" type="radio" name="type" id="pages" value="pages" checked>
                <label class="form-check-label" for="pages">
                  페이지
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="radio" name="type" id="books" value="books">
                <label class="form-check-label" for="books">
                  권
                </label>
              </div>
            </div>
            <div class="mb-3">
              <label for="duration" class="form-label">목표 기간 (일)</label>
              <input type="number" class="form-control" id="duration" placeholder="7">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary">생성하기</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import ChallengeCard from '@/components/challenge/ChallengeCard.vue';
import { onMounted, ref } from 'vue';
import { getAllChallenges } from '@/api/challengeApi.js';
import router from '@/router/index.js';

const challenges = ref([])

onMounted(async () => {
  try {
    challenges.value = await getAllChallenges()
  } catch (e) {
    alert(e.message)
    await router.push({ name: 'home' })
  }
})
</script>

<style scoped>

</style>
