from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import get_db
from ..models import User
from ..schemas import UserInit, UserResponse

router = APIRouter(tags=["users"])


@router.post("/users/init", response_model=UserResponse)
def init_user(req: UserInit, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.telegram_id == req.telegram_id).first()
    if user:
        return UserResponse(
            telegram_id=user.telegram_id, name=user.name, is_new=False
        )

    user = User(telegram_id=req.telegram_id, name=req.name)
    db.add(user)
    db.commit()
    db.refresh(user)
    return UserResponse(
        telegram_id=user.telegram_id, name=user.name, is_new=True
    )
