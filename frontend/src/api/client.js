import axios from 'axios'

const API_BASE = import.meta.env.VITE_API_URL || 'http://localhost:8000'

const api = axios.create({
  baseURL: API_BASE,
  timeout: 10000,
  headers: { 'Content-Type': 'application/json' },
})

export async function initUser(telegramUser) {
  const res = await api.post('/api/users/init', {
    telegram_id: telegramUser.id,
    first_name: telegramUser.first_name,
    last_name: telegramUser.last_name || '',
    username: telegramUser.username || '',
  })
  return res.data
}

export async function getTodayWorkout(telegramId) {
  const res = await api.get(`/api/workouts/today`, { params: { telegram_id: telegramId } })
  return res.data
}

export async function logWorkout(telegramId, payload) {
  const res = await api.post('/api/workouts/log', {
    telegram_id: telegramId,
    ...payload,
  })
  return res.data
}

export async function getHistory(telegramId, weeks = 4) {
  const res = await api.get('/api/workouts/history', {
    params: { telegram_id: telegramId, weeks },
  })
  return res.data
}

export async function getWeeklyReport(telegramId) {
  const res = await api.get('/api/reports/weekly', {
    params: { telegram_id: telegramId },
  })
  return res.data
}
