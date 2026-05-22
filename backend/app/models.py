from sqlalchemy import Column, String, Integer, Float, Boolean, Date, DateTime, Text
from datetime import datetime

from .database import Base


class User(Base):
    __tablename__ = "users"
    telegram_id = Column(String, primary_key=True)
    name = Column(String, default="")
    level = Column(String, default="beginner")
    created_at = Column(DateTime, default=datetime.utcnow)


class WorkoutLog(Base):
    __tablename__ = "workout_logs"
    id = Column(Integer, primary_key=True, autoincrement=True)
    telegram_id = Column(String)
    date = Column(Date)
    day_of_week = Column(Integer)  # 1-7
    workout_type = Column(String)
    exercises_completed = Column(Text)  # JSON string
    duration_minutes = Column(Integer, default=0)
    notes = Column(Text, default="")
    completed = Column(Boolean, default=True)
    ai_feedback = Column(Text, default="")
    created_at = Column(DateTime, default=datetime.utcnow)


class WeeklyReport(Base):
    __tablename__ = "weekly_reports"
    id = Column(Integer, primary_key=True, autoincrement=True)
    telegram_id = Column(String)
    week_start = Column(Date)
    completion_rate = Column(Float, default=0.0)
    total_workouts = Column(Integer, default=0)
    ai_summary = Column(Text, default="")
    created_at = Column(DateTime, default=datetime.utcnow)
