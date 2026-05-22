WEEKLY_PROGRAM = {
    1: {
        "title": "上肢重訓",
        "type": "strength",
        "exercises": [
            {"name": "伏地挺身", "sets": 3, "reps": 10, "unit": "reps"},
            {"name": "啞鈴肩推", "sets": 3, "reps": 10, "unit": "reps"},
            {"name": "三頭撐體", "sets": 3, "reps": 10, "unit": "reps"},
        ],
    },
    2: {
        "title": "有氧訓練",
        "type": "cardio",
        "exercises": [
            {"name": "快走/慢跑", "sets": 1, "reps": 30, "unit": "min"},
        ],
    },
    3: {
        "title": "下肢重訓",
        "type": "strength",
        "exercises": [
            {"name": "深蹲", "sets": 3, "reps": 12, "unit": "reps"},
            {"name": "弓步蹲", "sets": 3, "reps": 10, "unit": "reps"},
            {"name": "臀橋", "sets": 3, "reps": 15, "unit": "reps"},
        ],
    },
    4: {
        "title": "核心+伸展",
        "type": "core",
        "exercises": [
            {"name": "平板支撐", "sets": 3, "reps": 30, "unit": "sec"},
            {"name": "捲腹", "sets": 3, "reps": 15, "unit": "reps"},
            {"name": "全身伸展", "sets": 1, "reps": 20, "unit": "min"},
        ],
    },
    5: {
        "title": "上肢重訓(背)",
        "type": "strength",
        "exercises": [
            {"name": "啞鈴划船", "sets": 3, "reps": 10, "unit": "reps"},
            {"name": "彈力帶下拉", "sets": 3, "reps": 10, "unit": "reps"},
            {"name": "二頭彎舉", "sets": 3, "reps": 12, "unit": "reps"},
        ],
    },
    6: {
        "title": "HIIT有氧",
        "type": "hiit",
        "exercises": [
            {"name": "波比跳", "sets": 4, "reps": 10, "unit": "reps"},
            {"name": "開合跳", "sets": 4, "reps": 30, "unit": "reps"},
            {"name": "高抬腿", "sets": 4, "reps": 20, "unit": "reps"},
        ],
    },
    7: {
        "title": "休息恢復",
        "type": "rest",
        "exercises": [],
    },
}


def get_today_program(day_of_week: int) -> dict:
    """Get workout program for the given day (Monday=1, Sunday=7)."""
    return WEEKLY_PROGRAM.get(day_of_week, WEEKLY_PROGRAM[7])
