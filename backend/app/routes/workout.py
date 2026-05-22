import json
from datetime import date, timedelta

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import get_db
from ..models import User, WorkoutLog
from ..schemas import (
    HistoryEntry,
    TodayWorkout,
    WorkoutLogRequest,
    WorkoutLogResponse,
)
from ..services.ai_service import analyze_workout
from ..services.workout_service import get_today_program

router = APIRouter(tags=["workout"])


@router.get("/workout/today/{telegram_id}", response_model=TodayWorkout)
def get_today_workout(telegram_id: str, db: Session = Depends(get_db)):
    today = date.today()
    day_of_week = today.isoweekday()  # Monday=1, Sunday=7
    program = get_today_program(day_of_week)

    already_logged = (
        db.query(WorkoutLog)
        .filter(
            WorkoutLog.telegram_id == telegram_id,
            WorkoutLog.date == today,
        )
        .first()
        is not None
    )

    return TodayWorkout(
        day=day_of_week,
        title=program["title"],
        type=program["type"],
        exercises=program["exercises"],
        already_logged=already_logged,
    )


@router.post("/workout/log", response_model=WorkoutLogResponse)
def log_workout(req: WorkoutLogRequest, db: Session = Depends(get_db)):
    today = date.today()
    day_of_week = today.isoweekday()
    program = get_today_program(day_of_week)

    user = db.query(User).filter(User.telegram_id == req.telegram_id).first()
    user_name = user.name if user else ""

    ai_feedback = analyze_workout(
        req.exercises_completed, program["type"], req.duration_minutes, user_name
    )

    log = WorkoutLog(
        telegram_id=req.telegram_id,
        date=today,
        day_of_week=day_of_week,
        workout_type=program["type"],
        exercises_completed=json.dumps(req.exercises_completed, ensure_ascii=False),
        duration_minutes=req.duration_minutes,
        notes=req.notes,
        completed=True,
        ai_feedback=ai_feedback,
    )
    db.add(log)
    db.commit()
    db.refresh(log)

    return WorkoutLogResponse(log_id=log.id, ai_feedback=ai_feedback)


@router.get("/workout/history/{telegram_id}", response_model=list[HistoryEntry])
def get_history(telegram_id: str, db: Session = Depends(get_db)):
    since = date.today() - timedelta(days=30)
    logs = (
        db.query(WorkoutLog)
        .filter(
            WorkoutLog.telegram_id == telegram_id,
            WorkoutLog.date >= since,
        )
        .order_by(WorkoutLog.date.desc())
        .all()
    )
    return [
        HistoryEntry(
            date=log.date.isoformat(),
            completed=log.completed,
            workout_type=log.workout_type,
        )
        for log in logs
    ]
