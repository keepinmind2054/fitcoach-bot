from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .database import Base, engine
from .routes import analysis, users, workout

Base.metadata.create_all(bind=engine)

app = FastAPI(title="FitCoach API")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(users.router, prefix="/api")
app.include_router(workout.router, prefix="/api")
app.include_router(analysis.router, prefix="/api")


@app.get("/health")
def health():
    return {"status": "ok"}
