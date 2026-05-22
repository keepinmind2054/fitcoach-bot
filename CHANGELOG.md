# Changelog

All notable changes to FitCoach Bot will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-05-22

### Added
- 🦋 **Flutter frontend** — cross-platform app (iOS / Android / Web) replacing the React/Vite prototype
- 🌑 Dark OLED theme with `#0F0F0F` background and `#30D158` green accent
- 🏠 **Home screen** — today's workout card with gradient, weekly progress strip, type-colour coding (strength / cardio / HIIT / core / rest)
- 💪 **Workout screen** — exercise checklist with actual-reps input, countdown timer, linear progress bar, AI feedback dialog on completion
- 📅 **History screen** — 21-day calendar grid (green = done, red = missed, grey = future), recent 7-workout list
- 📈 **Report screen** — circular completion-rate ring, Claude AI summary card, 4-week bar chart
- ⚙️ **Settings screen** — profile card, notification toggle, training difficulty selector
- 🧩 `Exercise` and `DayProgram` model classes with `getTodayProgram()` helper
- 📦 `WorkoutLog` model with `fromJson` factory
- 🌐 `ApiService` with graceful degradation (app works offline / without backend)
- 🧭 `MainNavigation` with `IndexedStack` + `BottomNavigationBar` (4 tabs)

### Removed
- React / Vite frontend (`frontend/` directory)

## [0.1.0] - 2026-05-21

### Added
- 🏗️ Initial project scaffold
- ⚙️ FastAPI backend with SQLite + SQLAlchemy ORM
- 👤 User model keyed by Telegram ID
- 📋 `WorkoutLog` model (exercises JSON, AI feedback, duration)
- 📅 7-day `WEEKLY_PROGRAM` (strength × 3, cardio, HIIT, core, rest)
- 🤖 Claude Haiku AI service — instant post-workout feedback + weekly report (Traditional Chinese)
- 🗂️ REST API: `POST /users`, `GET /workout/today`, `POST /workout/log`, `GET /history`, `GET /report/weekly`
- ⚛️ React / Vite Telegram Mini App frontend (5 screens)
- 🐳 Docker Compose stack (backend + frontend)
- 📝 Project spec `SPEC.md`

[Unreleased]: https://github.com/keepinmind2054/fitcoach-bot/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/keepinmind2054/fitcoach-bot/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/keepinmind2054/fitcoach-bot/releases/tag/v0.1.0
