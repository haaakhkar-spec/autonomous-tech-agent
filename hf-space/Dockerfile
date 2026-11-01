FROM python:3.11-slim

# ffmpeg لمعالجة الصور والفيديو
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg curl git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY agent.py .

# Hugging Face Spaces يستخدم 7860 افتراضياً، وندعم أي منفذ عبر PORT
ENV PORT=7860
ENV DATA_DIR=/data
RUN mkdir -p /data
VOLUME ["/data"]
EXPOSE 7860

CMD ["sh", "-c", "python -m uvicorn agent:app --host 0.0.0.0 --port ${PORT:-7860}"]
