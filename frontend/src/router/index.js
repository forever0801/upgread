import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import LoginView from '@/views/LoginView.vue';
import JoinView from '@/views/JoinView.vue';
import ChallengeView from '@/views/ChallengeView.vue';
import ChallengeAll from '@/components/challenge/ChallengeAll.vue';
import ChallengeJoin from '@/components/challenge/ChallengeJoin.vue';
import ChallengeHistory from '@/components/challenge/ChallengeHistory.vue';

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
        }],
      redirect: 'challenge/all',
    },
    {
      path: '/:pathMatch(.*)*',
      redirect: '/home'
    }
  ],
});

export default router;
