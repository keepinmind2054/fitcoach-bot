# 🏋️ FitCoach Bot — AI健身小教練

> Telegram Mini App + AI 個人教練，7天訓練課程，智能分析進步

## Features
- 📅 **7天課程** — 重訓+有氧初學者計畫
- 📝 **訓練記錄** — 每次完成自動記錄
- 🤖 **AI回饋** — Claude即時分析，鼓勵+建議
- 📊 **週報告** — 完成率、趨勢、下週建議
- 📱 **Telegram Mini App** — 不用下載，點開即用

## Tech Stack
- **Frontend**: React 18 + Vite + @twa-dev/sdk + TailwindCSS
- **Backend**: Python FastAPI + SQLAlchemy + SQLite
- **AI**: Anthropic Claude Haiku
- **Deploy**: Docker Compose

## Quick Start

### Backend
```bash
cd backend
pip install -r requirements.txt
ANTHROPIC_API_KEY=your_key uvicorn app.main:app --reload
```

### Frontend
```bash
cd frontend
npm install
VITE_API_URL=http://localhost:8000 npm run dev
```

### Docker Compose
```bash
ANTHROPIC_API_KEY=your_key docker-compose up
```

## 7-Day Program
| Day | Type | Training |
|-----|------|----------|
| Mon | 💪 Strength | 上肢重訓（胸肩三頭）|
| Tue | 🏃 Cardio | 有氧30分鐘 |
| Wed | 🦵 Strength | 下肢重訓（腿臀）|
| Thu | 🧘 Core | 核心+伸展 |
| Fri | 💪 Strength | 上肢重訓（背二頭）|
| Sat | ⚡ HIIT | 高強度間歇20分鐘 |
| Sun | 😴 Rest | 休息恢復 |

## Repo
https://github.com/my2054white/fitcoach-bot
