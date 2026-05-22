import { Routes, Route } from 'react-router-dom'
import WebApp from '@twa-dev/sdk'
import TabBar from './components/TabBar'
import Home from './pages/Home'
import Workout from './pages/Workout'
import History from './pages/History'
import Report from './pages/Report'
import Settings from './pages/Settings'

WebApp.ready()
WebApp.expand()

const telegramUser = WebApp.initDataUnsafe?.user || {
  id: 'test123',
  first_name: 'Tester',
  last_name: '',
  username: 'tester',
}

export default function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<Home user={telegramUser} />} />
        <Route path="/workout" element={<Workout user={telegramUser} />} />
        <Route path="/history" element={<History />} />
        <Route path="/report" element={<Report />} />
        <Route path="/settings" element={<Settings user={telegramUser} />} />
      </Routes>
      <TabBar />
    </>
  )
}
