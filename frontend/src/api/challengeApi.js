import api from '@/api/index.js';

export const getAllChallenges = async () => {
  try {
    const response = await api.get('/challenge/all')
    return response.data
  } catch (e) {
    throw new Error("조회에 실패했습니다")
  }
}

export const postJoinChallenge = async (challengeId) => {
  try {
    const response = await api.post(`/challenge/join/${challengeId}`)
    return response.data
  } catch (e) {
    throw new Error("챌린지 참여에 실패했습니다")
  }
}
