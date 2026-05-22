# 🏋️ FitCoach Bot

> AI 健身小教練 — 7天訓練課程 × Claude AI 分析 × Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Python](https://img.shields.io/badge/Python-3.11-3776AB?logo=python)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.109-009688?logo=fastapi)](https://fastapi.tiangolo.com)
[![License](https://img.shields.io/badge/License-MIT-green)](#)

---

## ✨ Features

| 功能 | 說明 |
|------|------|
| 📅 7天週計畫 | 重訓（上肢/下肢/背部）× 有氧 × HIIT × 核心 × 休息 |
| 💪 訓練記錄 | 勾選完成項目、輸入實際次數、計時器 |
| 🤖 AI 即時回饋 | Claude Haiku 分析訓練表現，繁體中文輸出 |
| 📊 週報告 | 完成率、進度趨勢、個人化建議 |
| 📅 歷程行事曆 | 21天日曆格，一眼看出連續訓練 |
| 📱 跨平台 | Flutter — iOS / Android / Web 一份程式碼 |

---

## 🗂️ Project Structure

```
fitcoach-bot/
├── backend/              # FastAPI + SQLite
│   ├── app/
│   │   ├── main.py       # API routes
│   │   ├── models.py     # SQLAlchemy ORM models
│   │   └── services/
│   │       ├── ai_service.py       # Claude Haiku integration
│   │       └── workout_service.py  # 7-day program logic
│   └── requirements.txt
├── flutter/              # Flutter cross-platform app
│   ├── lib/
│   │   ├── main.dart               # App entry, theme, navigation
│   │   ├── constants/program.dart  # 7-day program data
│   │   ├── models/workout_log.dart # Data models
│   │   ├── services/api_service.dart # HTTP client
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   ├── workout_screen.dart
│   │   │   ├── history_screen.dart
│   │   │   ├── report_screen.dart
│   │   │   └── settings_screen.dart
│   │   └── widgets/bottom_nav.dart
│   └── pubspec.yaml
├── SPEC.md               # Product specification
├── CHANGELOG.md          # Release history
└── docker-compose.yml    # Full stack
```

---

## 🚀 Quick Start

### Backend

```bash
cd backend
pip install -r requirements.txt
export ANTHROPIC_API_KEY=sk-ant-...
uvicorn app.main:app --reload --port 8000
```

### Flutter App

```bash
cd flutter
flutter pub get

# Web (Telegram Mini App)
flutter run -d chrome

# iOS Simulator
flutter run -d ios

# Android
flutter run -d android
```

### Docker Compose (Full Stack)

```bash
ANTHROPIC_API_KEY=your_key docker-compose up
```

---

## 📱 Screens

### 🏠 Home
Today's workout card with type colour coding + 7-day weekly strip

### 💪 Workout
Exercise checklist → actual reps input → countdown timer → AI feedback dialog

### 📅 History
21-day calendar grid (🟢 done / 🔴 missed / ⬜ future) + recent workouts list

### 📈 Report
Circular completion ring + Claude AI weekly summary + 4-week bar chart

### ⚙️ Settings
Profile, notification toggle, training difficulty

---

## 📆 7-Day Program

| Day | Type | Training |
|-----|------|----------|
| 週一 | 💪 Strength | 上肢重訓（胸肩三頭）|
| 週二 | 🏃 Cardio | 有氧30分鐘 |
| 週三 | 🦵 Strength | 下肢重訓（腿臀）|
| 週四 | 🧘 Core | 核心+伸展 |
| 週五 | 💪 Strength | 上肢重訓（背二頭）|
| 週六 | ⚡ HIIT | 高強度間歇20分鐘 |
| 週日 | 😴 Rest | 休息恢復 |

---

## 🗺️ Roadmap

- [x] Issue #1 — Flutter migration (v0.2.0)
- [ ] Issue #2 — Enhanced AI analysis (progress tracking, plateau detection)
- [ ] Issue #3 — Docs & changelog automation
- [ ] Issue #4 — Docker Compose production stack

---

## 🏗️ Tech Stack

| Layer | Tech |
|-------|------|
| Frontend | Flutter 3.x (Dart) |
| Backend | FastAPI + SQLite |
| AI | Anthropic Claude Haiku |
| Platform | Telegram Mini App |
| State | Provider |
| Storage | SharedPreferences |

---

## Repo

https://github.com/keepinmind2054/fitcoach-bot

---

## 📄 License

MIT © 2026 keepinmind2054
