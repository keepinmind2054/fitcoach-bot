# FitCoach Bot — 健身小教練 Telegram Mini App

## 核心需求
- Telegram Mini App (React + Vite)
- FastAPI Python 後端
- SQLite 資料庫
- Claude AI 分析（訓練後即時回饋 + 週報）
- NanoClaw Bot 推播提醒

## 7天初學者課程（重訓+有氧）
| 天 | 類型 | 訓練內容 |
|---|---|---|
| 週一 | 上肢重訓 | 伏地挺身3×10、啞鈴肩推3×10、三頭撐體3×10 |
| 週二 | 有氧 | 快走/慢跑 30分鐘 |
| 週三 | 下肢重訓 | 深蹲3×12、弓步3×10、臀橋3×15 |
| 週四 | 核心+伸展 | 棒式3×30秒、捲腹3×15、全身伸展20分鐘 |
| 週五 | 上肢重訓 | 啞鈴划船3×10、滑輪下拉3×10、二頭彎舉3×12 |
| 週六 | HIIT有氧 | 20分鐘高強度間歇（波比跳/開合跳/衝刺） |
| 週日 | 休息 | 主動恢復，輕度伸展 |

## 資料模型
- User: telegram_id, name, level, created_at, weekly_start_day
- WorkoutLog: id, user_id, date, day_of_week, exercises_json, duration_min, notes, completed, ai_feedback
- WeeklyReport: id, user_id, week_start, completion_rate, volume_json, ai_summary

## API Endpoints
- POST /users/init — 初始化用戶（Telegram ID）
- GET /workout/today/{user_id} — 今日課程
- POST /workout/log — 記錄訓練
- GET /workout/history/{user_id} — 歷史記錄
- GET /workout/weekly-report/{user_id} — 週報告
- POST /analysis/workout — AI分析單次訓練
- POST /analysis/weekly — AI週報分析

## 前端頁面
1. Home — 今日課程卡片 + 開始訓練按鈕
2. Workout — 動作列表，逐一勾選完成，記錄重量/次數
3. History — 過去訓練日曆視圖
4. Report — AI週報 + 進度圖表
5. Settings — 個人設定

## AI 分析（Claude）
- 完成訓練後：分析完成率、給鼓勵、提供下次改進建議
- 每週日：生成週報，比較上週，調整難度建議

## 技術棧
- Frontend: React 18 + Vite + @twa-dev/sdk + TailwindCSS
- Backend: Python FastAPI + SQLAlchemy + SQLite
- Bot: python-telegram-bot (推播提醒)
- AI: anthropic Python SDK
- Deploy: Docker Compose

## 專案結構
```
fitcoach-bot/
├── frontend/          # React Telegram Mini App
│   ├── src/
│   │   ├── pages/     # Home, Workout, History, Report, Settings
│   │   ├── components/
│   │   └── api/       # API client
│   └── package.json
├── backend/           # FastAPI
│   ├── app/
│   │   ├── main.py
│   │   ├── models.py
│   │   ├── routes/
│   │   └── services/  # workout, ai_analysis
│   └── requirements.txt
├── bot/               # Telegram Bot
│   └── bot.py
├── docker-compose.yml
└── README.md
```
