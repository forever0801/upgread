<template>
  <div>

    {{ route.params.id }}번 챌린지를 보여줘
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router';

const route = useRoute()
</script>

<style scoped>

</style>
