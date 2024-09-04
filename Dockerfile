FROM python:3.12.5-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY ReQuest /app/ReQuest

ENV PYTHONUNBUFFERED=1

ENV PYTHONPATH=/app

WORKDIR /app/ReQuest

CMD ["python", "bot.py"]
