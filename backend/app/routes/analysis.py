import json
from datetime import date, timedelta

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import get_db
from ..models import User, WeeklyReport, WorkoutLog
from ..schemas import WeeklyReportResponse
from ..services.ai_service import generate_weekly_report

router = APIRouter(tags=["analysis"])


@router.get(
    "/analysis/weekly-report/{telegram_id}",
    response_model=WeeklyReportResponse,
)
def weekly_report(telegram_id: str, db: Session = Depends(get_db)):
    today = date.today()
    # Week starts on Monday
    week_start = today - timedelta(days=today.weekday())

    # Check cache
    cached = (
        db.query(WeeklyReport)
        .filter(
            WeeklyReport.telegram_id == telegram_id,
            WeeklyReport.week_start == week_start,
        )
        .first()
    )
    if cached:
        return WeeklyReportResponse(
            week_start=cached.week_start.isoformat(),
            completion_rate=cached.completion_rate,
            total_workouts=cached.total_workouts,
            ai_summary=cached.ai_summary,
        )

    # Calculate from logs
    logs = (
        db.query(WorkoutLog)
        .filter(
            WorkoutLog.telegram_id == telegram_id,
            WorkoutLog.date >= week_start,
            WorkoutLog.date <= today,
        )
        .all()
    )

    days_elapsed = today.weekday() + 1  # Monday=1 through Sunday=7
    # Exclude rest day (Sunday=7) from expected count
    expected = min(days_elapsed, 6)
    total_workouts = len(logs)
    completion_rate = total_workouts / expected if expected > 0 else 0.0

    user = db.query(User).filter(User.telegram_id == telegram_id).first()
    user_name = user.name if user else ""

    log_summaries = [
        {
            "date": log.date.isoformat(),
            "type": log.workout_type,
            "exercises": json.loads(log.exercises_completed)
            if log.exercises_completed
            else [],
            "duration": log.duration_minutes,
        }
        for log in logs
    ]

    ai_summary = generate_weekly_report(log_summaries, user_name, completion_rate)

    report = WeeklyReport(
        telegram_id=telegram_id,
        week_start=week_start,
        completion_rate=completion_rate,
        total_workouts=total_workouts,
        ai_summary=ai_summary,
    )
    db.add(report)
    db.commit()

    return WeeklyReportResponse(
        week_start=week_start.isoformat(),
        completion_rate=completion_rate,
        total_workouts=total_workouts,
        ai_summary=ai_summary,
    )
