import { useLocation, useNavigate } from 'react-router-dom'

const tabs = [
  { path: '/', label: '首頁', icon: '🏠' },
  { path: '/history', label: '紀錄', icon: '📅' },
  { path: '/report', label: '報告', icon: '📊' },
  { path: '/settings', label: '設定', icon: '⚙️' },
]

export default function TabBar() {
  const location = useLocation()
  const navigate = useNavigate()

  if (location.pathname === '/workout') return null

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-surface border-t border-[#333] flex justify-around items-center h-16 z-50">
      {tabs.map(tab => {
        const active = location.pathname === tab.path
        return (
          <button
            key={tab.path}
            onClick={() => navigate(tab.path)}
            className={`flex flex-col items-center gap-0.5 py-2 px-4 text-xs transition-colors ${
              active ? 'text-primary' : 'text-text-muted'
            }`}
          >
            <span className="text-xl">{tab.icon}</span>
            <span>{tab.label}</span>
          </button>
        )
      })}
    </nav>
  )
}
