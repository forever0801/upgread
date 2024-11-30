<template>
  <div class="d-flex flex-column justify-content-center align-items-center p-5">
    <div class="card w-50 p-4">
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control" id="email" placeholder="example@example.com">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="password" placeholder="********">
      </div>
      <div class="mb-3">
        <label for="password-confirm" class="form-label">비밀번호 확인</label>
        <input type="password" class="form-control" id="password-confirm" placeholder="********">
      </div>
      <div class="mb-3">
        <label for="nickname" class="form-label">닉네임</label>
        <input type="text" class="form-control" id="nickname" placeholder="아코">
      </div>
      <div class="mb-3">
        <label for="birth-date" class="form-label">생년월일</label>
        <input type="date" class="form-control" id="birth-date">
      </div>
      <div class="mb-3">
        <div class="form-label">성별</div>
        <div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="gender" id="female">
            <label class="form-check-label" for="female">
              여
            </label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="gender" id="male" checked>
            <label class="form-check-label" for="male">
              남
            </label>
          </div>
        </div>
      </div>
      <div class="mb-3">
        <label for="address" class="form-label">주소</label>
        <input type="text" class="form-control" id="address">
      </div>
      <button type="submit" class="btn btn-primary mb-3 my-2">회원가입</button>
    </div>
  </div>
</template>

<script setup>

</script>

<style scoped>

</style>
