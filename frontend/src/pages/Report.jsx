const weeklyData = [
  { label: '3週前', rate: 60 },
  { label: '2週前', rate: 75 },
  { label: '上週', rate: 83 },
  { label: '本週', rate: 67 },
]

export default function Report() {
  const completionRate = 67
  const totalWorkouts = 4
  const circumference = 2 * Math.PI * 45

  return (
    <div className="flex-1 px-4 pt-6 pb-20">
      <h1 className="text-2xl font-bold mb-6">週報</h1>

      <div className="bg-card rounded-2xl p-5 mb-4 flex items-center gap-6">
        <div className="relative w-28 h-28 shrink-0">
          <svg className="w-28 h-28 -rotate-90" viewBox="0 0 100 100">
            <circle cx="50" cy="50" r="45" fill="none" stroke="#333" strokeWidth="8" />
            <circle
              cx="50" cy="50" r="45"
              fill="none"
              stroke="#30d158"
              strokeWidth="8"
              strokeLinecap="round"
              strokeDasharray={circumference}
              strokeDashoffset={circumference * (1 - completionRate / 100)}
            />
          </svg>
          <div className="absolute inset-0 flex items-center justify-center">
            <span className="text-2xl font-bold">{completionRate}%</span>
          </div>
        </div>
        <div>
          <p className="text-text-muted text-sm">本週完成率</p>
          <p className="text-3xl font-bold">{totalWorkouts}<span className="text-lg text-text-muted">/6</span></p>
          <p className="text-text-muted text-sm mt-1">次訓練完成</p>
        </div>
      </div>

      <div className="bg-card rounded-2xl p-5 mb-4">
        <h3 className="text-sm font-bold text-text-muted mb-3">AI 週報總結</h3>
        <p className="text-sm leading-relaxed">
          這週表現不錯！你完成了 4 次訓練，上肢力量訓練的表現特別好。
          建議下週可以稍微增加深蹲的重量，並注意週二的有氧訓練不要跳過。
          整體來看，你的訓練一致性正在穩步提升，繼續保持！💪
        </p>
      </div>

      <div className="bg-card rounded-2xl p-5">
        <h3 className="text-sm font-bold text-text-muted mb-4">最近四週完成率</h3>
        <div className="flex items-end gap-3 h-40">
          {weeklyData.map((w, i) => (
            <div key={i} className="flex-1 flex flex-col items-center gap-1">
              <span className="text-xs font-bold">{w.rate}%</span>
              <div className="w-full bg-surface rounded-lg overflow-hidden" style={{ height: '120px' }}>
                <div
                  className="w-full rounded-lg transition-all"
                  style={{
                    height: `${w.rate}%`,
                    backgroundColor: w.rate >= 80 ? '#30d158' : w.rate >= 50 ? '#ffd60a' : '#ff453a',
                    marginTop: `${100 - w.rate}%`,
                  }}
                />
              </div>
              <span className="text-xs text-text-muted">{w.label}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
