# Build deps
FROM dhi.io/python:3.14-alpine3.23-dev AS builder

RUN apk add --no-cache \
      build-base \
      python3-dev \
      musl-dev \
      libffi-dev \
      openssl-dev \
      git

COPY requirements.txt .

RUN pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt

# Prod image
FROM dhi.io/python:3.14-alpine3.23

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH=/app

WORKDIR /app

COPY --from=builder /usr/lib/python3.14/site-packages /usr/lib/python3.14/site-packages
COPY --chown=65532:65532 ReQuest /app/ReQuest

USER 65532

CMD ["python", "-m", "ReQuest.bot"]
