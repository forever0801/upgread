<template>
  <div class="row px-3 py-5">
    <ul class="col-3 list-group list-group-flush">
      <router-link :to="{ name: 'bookRecommendGenre' }" class="list-group-item list-group-item-action"
                   :class="{ active: route.name === 'bookRecommendGenre'}">장르별
      </router-link>
      <router-link :to="{ name: 'bookRecommendGrade' }" class="list-group-item list-group-item-action"
                   :class="{ active: route.name === 'bookRecommendGrade'}">평점별
      </router-link>
      <router-link :to="{ name: 'bookRecommendDifficulty' }" class="list-group-item list-group-item-action"
                   :class="{ active: route.name === 'bookRecommendDifficulty'}">난이도별
      </router-link>
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
