import api from '@/api/index.js';

export const getLogin = async () => {
  try {
    const response = await api.get('/user/login')
    return response.data
  } catch (e) {
    throw new Error("로그인 상태가 아닙니다")
  }
}

export const postLogin = async ({ email, password }) => {
  try{
    const response = await api.post('/user/login', { email, password })
    return response.data
  } catch (e) {
    throw new Error(e.message)
  }
}

export const postLogout = async () => {
  try {
    const response = await api.post('/user/logout')
    return response.data
  } catch (e) {
    throw new Error(e.message)
  }
}
