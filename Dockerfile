FROM python:alpine

RUN apk add --no-cache --virtual .build-deps  \
      build-base \
      python3-dev \
      musl-dev \
      libffi-dev \
      openssl-dev \
      git \
    && apk add --no-cache bash ca-certificates

RUN addgroup -S request -g 1001 && \
    adduser -S request -u 10001 -G request

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONPATH=/app

WORKDIR /app

COPY requirements.txt .

RUN pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps

COPY --chown=request:request ReQuest /app/ReQuest

USER request
WORKDIR /app

CMD ["python", "-m", "ReQuest.bot"]
