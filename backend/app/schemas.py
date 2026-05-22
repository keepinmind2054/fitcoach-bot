from pydantic import BaseModel
from typing import Optional
from datetime import date


class UserInit(BaseModel):
    telegram_id: str
    name: str = ""


class UserResponse(BaseModel):
    telegram_id: str
    name: str
    is_new: bool


class Exercise(BaseModel):
    name: str
    sets: int
    reps: int
    unit: str


class TodayWorkout(BaseModel):
    day: int
    title: str
    type: str
    exercises: list[Exercise]
    already_logged: bool


class WorkoutLogRequest(BaseModel):
    telegram_id: str
    exercises_completed: list[str]
    duration_minutes: int = 0
    notes: str = ""


class WorkoutLogResponse(BaseModel):
    log_id: int
    ai_feedback: str


class HistoryEntry(BaseModel):
    date: str
    completed: bool
    workout_type: str


class WeeklyReportResponse(BaseModel):
    week_start: str
    completion_rate: float
    total_workouts: int
    ai_summary: str
