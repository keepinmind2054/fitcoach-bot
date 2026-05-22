import { useState } from 'react'

export default function Settings({ user }) {
  const [notifications, setNotifications] = useState(true)

  return (
    <div className="flex-1 px-4 pt-6 pb-20">
      <h1 className="text-2xl font-bold mb-6">設定</h1>

      <div className="bg-card rounded-2xl p-5 mb-4">
        <div className="flex items-center gap-4">
          <div className="w-14 h-14 rounded-full bg-primary/20 flex items-center justify-center text-2xl">
            {user.first_name?.[0] || '?'}
          </div>
          <div>
            <p className="font-bold text-lg">{user.first_name} {user.last_name || ''}</p>
            {user.username && (
              <p className="text-text-muted text-sm">@{user.username}</p>
            )}
          </div>
        </div>
      </div>

      <div className="bg-card rounded-2xl divide-y divide-[#333]">
        <div className="flex items-center justify-between p-5">
          <div>
            <p className="font-medium">訓練提醒通知</p>
            <p className="text-text-muted text-xs mt-0.5">每天訓練時間前 30 分鐘提醒</p>
          </div>
          <button
            onClick={() => setNotifications(!notifications)}
            className={`relative w-12 h-7 rounded-full transition-colors ${
              notifications ? 'bg-primary' : 'bg-[#333]'
            }`}
          >
            <div
              className={`absolute top-0.5 w-6 h-6 rounded-full bg-white transition-transform ${
                notifications ? 'left-[22px]' : 'left-0.5'
              }`}
            />
          </button>
        </div>
      </div>

      <div className="bg-card rounded-2xl p-5 mt-4">
        <h3 className="font-bold mb-3">關於 FitCoach</h3>
        <div className="space-y-2 text-sm text-text-muted">
          <p>FitCoach 是你的 AI 健身教練，透過 Telegram 陪你養成運動習慣。</p>
          <p>版本 1.0.0</p>
        </div>
      </div>
    </div>
  )
}
