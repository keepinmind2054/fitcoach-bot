import os

import anthropic


def analyze_workout(
    exercises_completed: list, workout_type: str, duration: int, user_name: str
) -> str:
    api_key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not api_key:
        return f"太棒了 {user_name}！今天的訓練完成得很好！繼續保持，明天會更好！💪"

    client = anthropic.Anthropic(api_key=api_key)
    prompt = (
        f"你是一個友善的健身教練。用戶 {user_name} 剛完成了 {workout_type} 訓練，"
        f"持續 {duration} 分鐘。\n完成的動作：{exercises_completed}\n"
        "請用繁體中文給出簡短（80字以內）的鼓勵和一個具體的小建議。語氣親切、積極。"
    )

    msg = client.messages.create(
        model="claude-3-haiku-20240307",
        max_tokens=200,
        messages=[{"role": "user", "content": prompt}],
    )
    return msg.content[0].text


def generate_weekly_report(
    logs: list, user_name: str, completion_rate: float
) -> str:
    api_key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not api_key:
        return (
            f"{user_name} 本週完成率 {completion_rate:.0%}！"
            "繼續加油！下週目標保持穩定訓練節奏。"
        )

    client = anthropic.Anthropic(api_key=api_key)
    prompt = (
        f"你是一個健身教練，為用戶 {user_name} 生成本週訓練週報。\n"
        f"本週完成率：{completion_rate:.0%}\n訓練記錄：{logs}\n"
        "請用繁體中文寫150字以內的週報，包含：本週表現總結、值得鼓勵的地方、"
        "下週一個具體建議。語氣鼓勵積極。"
    )

    msg = client.messages.create(
        model="claude-3-haiku-20240307",
        max_tokens=400,
        messages=[{"role": "user", "content": prompt}],
    )
    return msg.content[0].text
