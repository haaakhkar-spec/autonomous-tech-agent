FROM python:3.11-slim

# ffmpeg للأدوات الصوتية/المرئية
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg curl git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY agent.py .

ENV DATA_DIR=/var/data
ENV PORT=8000
VOLUME ["/var/data"]
EXPOSE 8000

CMD ["sh", "-c", "python -m uvicorn agent:app --host 0.0.0.0 --port ${PORT:-8000}"]
