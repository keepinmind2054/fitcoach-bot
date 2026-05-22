import { useState, useEffect, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { getTodayProgram, formatUnit } from '../data/program'

export default function Workout({ user }) {
  const navigate = useNavigate()
  const today = getTodayProgram()
  const [completed, setCompleted] = useState({})
  const [values, setValues] = useState({})
  const [showFeedback, setShowFeedback] = useState(false)
  const [timer, setTimer] = useState(0)
  const [timerRunning, setTimerRunning] = useState(false)
  const intervalRef = useRef(null)

  const isCardio = today.type === 'cardio'

  useEffect(() => {
    if (timerRunning) {
      intervalRef.current = setInterval(() => setTimer(t => t + 1), 1000)
    }
    return () => clearInterval(intervalRef.current)
  }, [timerRunning])

  const toggleComplete = (i) => {
    setCompleted(prev => ({ ...prev, [i]: !prev[i] }))
  }

  const updateValue = (i, field, val) => {
    setValues(prev => ({
      ...prev,
      [i]: { ...prev[i], [field]: val },
    }))
  }

  const allDone = today.exercises.every((_, i) => completed[i])

  const handleFinish = () => {
    setShowFeedback(true)
  }

  const formatTimer = (s) => {
    const m = Math.floor(s / 60)
    const sec = s % 60
    return `${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
  }

  if (today.type === 'rest') {
    navigate('/')
    return null
  }

  return (
    <div className="flex-1 px-4 pt-4 pb-6">
      <div className="flex items-center justify-between mb-4">
        <button onClick={() => navigate('/')} className="text-text-muted text-sm">
          ← 返回
        </button>
        <h1 className="text-lg font-bold">{today.title}</h1>
        <div className="w-12" />
      </div>

      {isCardio && (
        <div className="bg-card rounded-2xl p-5 mb-4 text-center">
          <p className="text-4xl font-mono font-bold text-primary mb-3">
            {formatTimer(timer)}
          </p>
          <div className="flex gap-3 justify-center">
            <button
              onClick={() => setTimerRunning(!timerRunning)}
              className="px-6 py-2 rounded-xl font-bold text-sm bg-primary text-white"
            >
              {timerRunning ? '暫停' : '開始'}
            </button>
            <button
              onClick={() => { setTimer(0); setTimerRunning(false) }}
              className="px-6 py-2 rounded-xl font-bold text-sm bg-surface text-text-muted"
            >
              重置
            </button>
          </div>
        </div>
      )}

      <div className="space-y-3 mb-6">
        {today.exercises.map((ex, i) => (
          <div
            key={i}
            className={`rounded-2xl p-4 transition-colors ${
              completed[i] ? 'bg-primary/10 border border-primary/30' : 'bg-card'
            }`}
          >
            <div className="flex items-center gap-3 mb-2">
              <button
                onClick={() => toggleComplete(i)}
                className={`w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs shrink-0 ${
                  completed[i]
                    ? 'bg-primary border-primary text-white'
                    : 'border-text-muted'
                }`}
              >
                {completed[i] && '✓'}
              </button>
              <div className="flex-1">
                <p className={`font-medium ${completed[i] ? 'line-through text-text-muted' : ''}`}>
                  {ex.name}
                </p>
                <p className="text-text-muted text-xs">
                  {ex.sets} 組 x {formatUnit(ex.unit, ex.reps)}
                </p>
              </div>
            </div>
            {!completed[i] && ex.unit === 'reps' && (
              <div className="flex items-center gap-2 ml-10">
                <label className="text-text-muted text-xs">實際:</label>
                <input
                  type="number"
                  placeholder={String(ex.reps)}
                  value={values[i]?.reps || ''}
                  onChange={(e) => updateValue(i, 'reps', e.target.value)}
                />
                <label className="text-text-muted text-xs">下</label>
                <input
                  type="number"
                  placeholder="kg"
                  value={values[i]?.weight || ''}
                  onChange={(e) => updateValue(i, 'weight', e.target.value)}
                />
                <label className="text-text-muted text-xs">kg</label>
              </div>
            )}
          </div>
        ))}
      </div>

      <button
        onClick={handleFinish}
        disabled={!allDone}
        className={`w-full py-4 rounded-2xl font-bold text-base transition-colors ${
          allDone
            ? 'bg-primary text-white'
            : 'bg-card text-text-muted cursor-not-allowed'
        }`}
      >
        完成訓練
      </button>

      {showFeedback && (
        <div className="fixed inset-0 bg-black/70 flex items-center justify-center z-50 px-4">
          <div className="bg-card rounded-2xl p-6 max-w-sm w-full text-center">
            <div className="text-5xl mb-3">🎉</div>
            <h2 className="text-xl font-bold mb-2">訓練完成！</h2>
            <p className="text-text-muted text-sm mb-4">
              太棒了！你完成了今天的{today.title}。持續保持，你正在變得更強壯！
            </p>
            <button
              onClick={() => { setShowFeedback(false); navigate('/') }}
              className="w-full py-3 rounded-xl bg-primary text-white font-bold"
            >
              回到首頁
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
