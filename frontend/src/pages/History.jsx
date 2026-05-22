import { useState } from 'react'
import { getProgramByDay } from '../data/program'

function generateCalendarData() {
  const today = new Date()
  const weeks = []
  const current = new Date(today)
  current.setDate(current.getDate() - 27)

  for (let w = 0; w < 4; w++) {
    const week = []
    for (let d = 0; d < 7; d++) {
      const date = new Date(current)
      const isPast = date < new Date(today.getFullYear(), today.getMonth(), today.getDate())
      const isToday = date.toDateString() === today.toDateString()
      const isFuture = date > today
      const jsDay = date.getDay()
      const day = jsDay === 0 ? 7 : jsDay
      const program = getProgramByDay(day)
      const isRest = program.type === 'rest'

      let status = 'future'
      if (isPast || isToday) {
        if (isRest) {
          status = 'rest'
        } else {
          status = Math.random() > 0.3 ? 'completed' : 'missed'
        }
      }
      if (isToday) status = 'today'

      week.push({
        date: new Date(date),
        day: date.getDate(),
        status,
        program,
        isToday,
      })
      current.setDate(current.getDate() + 1)
    }
    weeks.push(week)
  }
  return weeks
}

const statusColors = {
  completed: 'bg-primary',
  missed: 'bg-danger',
  rest: 'bg-[#333]',
  future: 'bg-surface',
  today: 'bg-primary ring-2 ring-white',
}

export default function History() {
  const [selectedDay, setSelectedDay] = useState(null)
  const weeks = generateCalendarData()

  return (
    <div className="flex-1 px-4 pt-6 pb-20">
      <h1 className="text-2xl font-bold mb-6">訓練紀錄</h1>

      <div className="bg-card rounded-2xl p-4 mb-4">
        <div className="grid grid-cols-7 gap-1 mb-2">
          {['一', '二', '三', '四', '五', '六', '日'].map(d => (
            <div key={d} className="text-center text-text-muted text-xs py-1">{d}</div>
          ))}
        </div>
        {weeks.map((week, wi) => (
          <div key={wi} className="grid grid-cols-7 gap-1 mb-1">
            {week.map((d, di) => (
              <button
                key={di}
                onClick={() => setSelectedDay(d)}
                className={`aspect-square rounded-lg flex items-center justify-center text-xs font-medium ${statusColors[d.status]}`}
              >
                {d.day}
              </button>
            ))}
          </div>
        ))}
      </div>

      <div className="flex gap-3 justify-center mb-4">
        <span className="flex items-center gap-1 text-xs text-text-muted">
          <span className="w-3 h-3 rounded bg-primary inline-block" /> 完成
        </span>
        <span className="flex items-center gap-1 text-xs text-text-muted">
          <span className="w-3 h-3 rounded bg-danger inline-block" /> 未完成
        </span>
        <span className="flex items-center gap-1 text-xs text-text-muted">
          <span className="w-3 h-3 rounded bg-[#333] inline-block" /> 休息
        </span>
      </div>

      {selectedDay && (
        <div className="fixed inset-x-0 bottom-0 bg-card rounded-t-2xl p-5 z-50 max-h-[50vh] overflow-y-auto">
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-bold">
              {selectedDay.date.toLocaleDateString('zh-TW', { month: 'long', day: 'numeric' })}
              {' — '}
              {selectedDay.program.title}
            </h3>
            <button
              onClick={() => setSelectedDay(null)}
              className="text-text-muted text-lg"
            >
              ✕
            </button>
          </div>
          {selectedDay.program.exercises.length > 0 ? (
            <div className="space-y-2">
              {selectedDay.program.exercises.map((ex, i) => (
                <div key={i} className="flex justify-between bg-surface rounded-xl px-4 py-3">
                  <span className="text-sm">{ex.name}</span>
                  <span className="text-text-muted text-sm">
                    {ex.sets} 組 x {ex.reps} {ex.unit === 'reps' ? '下' : ex.unit === 'min' ? '分鐘' : '秒'}
                  </span>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-text-muted text-sm">休息日</p>
          )}
        </div>
      )}
    </div>
  )
}
