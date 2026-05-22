export const WEEKLY_PROGRAM = [
  { day: 1, name: '週一', type: 'strength', title: '上肢重訓', color: '#FF6B6B', exercises: [
    { name: '伏地挺身', sets: 3, reps: 10, unit: 'reps' },
    { name: '啞鈴肩推', sets: 3, reps: 10, unit: 'reps' },
    { name: '三頭撐體', sets: 3, reps: 10, unit: 'reps' },
  ]},
  { day: 2, name: '週二', type: 'cardio', title: '有氧訓練', color: '#4ECDC4', exercises: [
    { name: '快走/慢跑', sets: 1, reps: 30, unit: 'min' },
  ]},
  { day: 3, name: '週三', type: 'strength', title: '下肢重訓', color: '#FF6B6B', exercises: [
    { name: '深蹲', sets: 3, reps: 12, unit: 'reps' },
    { name: '弓步蹲', sets: 3, reps: 10, unit: 'reps' },
    { name: '臀橋', sets: 3, reps: 15, unit: 'reps' },
  ]},
  { day: 4, name: '週四', type: 'core', title: '核心+伸展', color: '#A8E6CF', exercises: [
    { name: '平板支撐', sets: 3, reps: 30, unit: 'sec' },
    { name: '捲腹', sets: 3, reps: 15, unit: 'reps' },
    { name: '全身伸展', sets: 1, reps: 20, unit: 'min' },
  ]},
  { day: 5, name: '週五', type: 'strength', title: '上肢重訓(背)', color: '#FF6B6B', exercises: [
    { name: '啞鈴划船', sets: 3, reps: 10, unit: 'reps' },
    { name: '彈力帶下拉', sets: 3, reps: 10, unit: 'reps' },
    { name: '二頭彎舉', sets: 3, reps: 12, unit: 'reps' },
  ]},
  { day: 6, name: '週六', type: 'hiit', title: 'HIIT有氧', color: '#FFD93D', exercises: [
    { name: '波比跳', sets: 4, reps: 10, unit: 'reps' },
    { name: '開合跳', sets: 4, reps: 30, unit: 'reps' },
    { name: '高抬腿', sets: 4, reps: 20, unit: 'reps' },
  ]},
  { day: 7, name: '週日', type: 'rest', title: '休息恢復', color: '#95E1D3', exercises: [] },
]

export function getTodayProgram() {
  const jsDay = new Date().getDay()
  const day = jsDay === 0 ? 7 : jsDay
  return WEEKLY_PROGRAM.find(p => p.day === day)
}

export function getProgramByDay(day) {
  return WEEKLY_PROGRAM.find(p => p.day === day)
}

export function formatUnit(unit, value) {
  switch (unit) {
    case 'reps': return `${value} 下`
    case 'min': return `${value} 分鐘`
    case 'sec': return `${value} 秒`
    default: return `${value}`
  }
}
