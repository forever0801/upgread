<template>
  <div class="d-flex flex-column justify-content-center align-items-center p-5">
    <div class="card w-50 p-4">
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input v-model="formData.email" type="email" class="form-control" id="email" placeholder="example@example.com">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input v-model="formData.password" type="password" class="form-control" id="password" placeholder="********">
      </div>
      <div class="mb-3">
        <label for="password-confirm" class="form-label">비밀번호 확인</label>
        <input type="password" class="form-control" id="password-confirm" placeholder="********">
      </div>
      <div class="mb-3">
        <label for="username" class="form-label">닉네임</label>
        <input v-model="formData.username" type="text" class="form-control" id="username" placeholder="아코">
      </div>
      <div class="mb-3">
        <label for="birth-date" class="form-label">생년월일</label>
        <input v-model="formData.birth" type="date" class="form-control" id="birth-date">
      </div>
      <div class="mb-3">
        <div class="form-label">성별</div>
        <div>
          <div class="form-check">
            <input v-model="formData.gender" class="form-check-input" type="radio" name="gender" value="female"
                   id="female">
            <label class="form-check-label" for="female">
              여
            </label>
          </div>
          <div class="form-check">
            <input v-model="formData.gender" class="form-check-input" type="radio" name="gender" id="male" value="male"
                   checked>
            <label class="form-check-label" for="male">
              남
            </label>
          </div>
        </div>
      </div>
      <div class="mb-3">
        <label for="city" class="form-label">도시</label>
        <input v-model="formData.city" type="text" class="form-control" id="city">
      </div>
      <button type="submit" class="btn btn-primary mb-3 my-2" @click="handleJoinClick">회원가입</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { postJoin } from '@/api/userApi.js';
import router from '@/router/index.js';

const formData = ref({
  email: '',
  password: '',
  username: '',
  birth: '',
  gender: 'male',
  city: '',
});

const handleJoinClick = async () => {
  try {
    await postJoin(formData.value);
    alert("회원가입에 성공했습니다!")
    await router.push({ name: 'login' })
  } catch (e) {
    alert(e.message)
  }
};
</script>

<style scoped>

</style>
