import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import LoginView from '@/views/LoginView.vue';
import JoinView from '@/views/JoinView.vue';
import ChallengeView from '@/views/ChallengeView.vue';
import ChallengeAll from '@/components/challenge/ChallengeAll.vue';
import ChallengeJoin from '@/components/challenge/ChallengeJoin.vue';
import ChallengeHistory from '@/components/challenge/ChallengeHistory.vue';
import BookRecommendView from '@/views/BookRecommendView.vue';
import SettingView from '@/views/SettingView.vue';
import ChallengeDetail from '@/components/challenge/ChallengeDetail.vue';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/home',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
    },
    {
      path: '/join',
      name: 'join',
      component: JoinView,
    },
    {
      path: '/book-recommend',
      name: 'book-recommend',
      component: BookRecommendView,
    },
    {
      path: '/challenge',
      name: 'challenge',
      component: ChallengeView,
      children: [
        {
          path: 'all',
          name: 'challengeAll',
          component: ChallengeAll,
        },
        {
          path: 'join',
          name: 'challengeJoin',
          component: ChallengeJoin,
        },
        {
          path: 'history',
          name: 'challengeHistory',
          component: ChallengeHistory,
        },
        {
          path: ':id',
          name: 'challengeDetail',
          component: ChallengeDetail,
        }],
      redirect: 'challenge/all',
    },
    {
      path: '/setting',
      name: 'setting',
      component: SettingView,
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/home'
    }
  ],
});

export default router;