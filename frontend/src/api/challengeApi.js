import api from '@/api/index.js';

export const getAllChallenges = async () => {
  try {
    const response = await api.get('/challenge/all')
    return response.data
  } catch (e) {
    throw new Error("조회에 실패했습니다")
  }
}
