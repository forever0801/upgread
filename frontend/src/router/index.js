import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import LoginView from '@/views/LoginView.vue';
import JoinView from '@/views/JoinView.vue';
import ChallengeView from '@/views/ChallengeView.vue';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/home",
      name: "home",
      component: HomeView
    },
    {
      path: "/login",
      name: "login",
      component: LoginView
    },
    {
      path: "/join",
      name: "join",
      component: JoinView
    },
    {
      path: "/challenge",
      name: "challenge",
      component: ChallengeView
    }
  ]
})

export default router
