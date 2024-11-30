<template>
  <div class="d-flex flex-column justify-content-center align-items-center p-5">
    <div class="card w-50 p-4 m-4">
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input v-model="formData.email" type="email" class="form-control" id="email" placeholder="example@example.com">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input v-model="formData.password" type="password" class="form-control" id="password" placeholder="********">
      </div>
      <button type="submit" class="btn btn-primary mb-3 my-2" @click="handleLoginClick">로그인</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { postLogin } from '@/api/userApi.js';
import router from '@/router/index.js';

const formData = ref({
  email: "",
  password: "",
})

const handleLoginClick = async () => {
  const { email, password } = formData.value;
  try {
    await postLogin({
      email,
      password
    })
    alert("로그인 되었습니다")
    await router.push({ name: 'home' })
    location.reload()
  } catch (e) {
    alert(e.message)
  }
}
</script>

<style scoped>

</style>
