import { useNavigate } from 'react-router-dom'
import { getTodayProgram, formatUnit } from '../data/program'

export default function Home({ user }) {
  const navigate = useNavigate()
  const today = getTodayProgram()

  return (
    <div className="flex-1 px-4 pt-6 pb-20">
      <div className="mb-6">
        <p className="text-text-muted text-sm">
          {new Date().toLocaleDateString('zh-TW', { month: 'long', day: 'numeric', weekday: 'long' })}
        </p>
        <h1 className="text-2xl font-bold mt-1">
          嗨，{user.first_name}
        </h1>
      </div>

      <div
        className="rounded-2xl p-5 mb-4"
        style={{ backgroundColor: today.color + '18', border: `1px solid ${today.color}33` }}
      >
        <div className="flex items-center justify-between mb-3">
          <div>
            <p className="text-text-muted text-sm">{today.name}</p>
            <h2 className="text-xl font-bold" style={{ color: today.color }}>
              {today.title}
            </h2>
          </div>
          <div
            className="w-12 h-12 rounded-full flex items-center justify-center text-lg"
            style={{ backgroundColor: today.color + '33' }}
          >
            {today.type === 'strength' ? '💪' :
             today.type === 'cardio' ? '🏃' :
             today.type === 'core' ? '🧘' :
             today.type === 'hiit' ? '🔥' :
             today.type === 'rest' ? '😴' : '🏋️'}
          </div>
        </div>

        {today.exercises.length > 0 ? (
          <div className="space-y-2 mb-4">
            {today.exercises.map((ex, i) => (
              <div key={i} className="flex items-center justify-between bg-[#0f0f0f80] rounded-xl px-4 py-3">
                <span className="text-sm font-medium">{ex.name}</span>
                <span className="text-text-muted text-sm">
                  {ex.sets} 組 x {formatUnit(ex.unit, ex.reps)}
                </span>
              </div>
            ))}
          </div>
        ) : (
          <p className="text-text-muted text-sm mb-4">今天是休息日，好好放鬆吧！</p>
        )}

        {today.type !== 'rest' && (
          <button
            onClick={() => navigate('/workout')}
            className="w-full py-3 rounded-xl font-bold text-white text-base transition-colors"
            style={{ backgroundColor: today.color }}
          >
            開始訓練
          </button>
        )}
      </div>

      <div className="rounded-2xl bg-card p-4">
        <h3 className="text-sm font-bold text-text-muted mb-3">本週計畫</h3>
        <div className="flex gap-2">
          {['一', '二', '三', '四', '五', '六', '日'].map((d, i) => {
            const isToday = i + 1 === today.day
            return (
              <div
                key={d}
                className={`flex-1 text-center py-2 rounded-lg text-xs ${
                  isToday ? 'bg-primary text-white font-bold' : 'bg-surface text-text-muted'
                }`}
              >
                {d}
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
