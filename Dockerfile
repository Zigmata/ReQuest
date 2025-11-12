FROM python:alpine

RUN apk add --no-cache --virtual .build-deps  \
      build-base \
      python3-dev \
      musl-dev \
      libffi-dev \
      openssl-dev \
      git \
    && apk add --no-cache bash ca-certificates

# Make request user
RUN addgroup -S request -g 1001 && \
    adduser -S request -u 10001 -G request

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONPATH=/app

# Set workdir for file copy
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .

RUN pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps

# Copy app files
COPY --chown=request:request ReQuest /app/ReQuest

# Change user contexts and run the app
USER request
WORKDIR /app/ReQuest

CMD ["python", "bot.py"]
