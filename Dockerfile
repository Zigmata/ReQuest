FROM python:3.12.5-slim

# Make request user
RUN groupadd -g 1001 request && \
    useradd -r -u 1001 -g request request

# Set workdir for file copy
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .

RUN pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY ReQuest /app/ReQuest

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

# Give non-root user app directory ownership
RUN chown -R request:request /app

# Change user contexts and run the app
USER request
WORKDIR /app/ReQuest

CMD ["python", "bot.py"]
