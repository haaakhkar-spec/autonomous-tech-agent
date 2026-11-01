#!/usr/bin/env bash
# تشغيل الوكيل التقني المستقل داخل GitHub Codespaces أو أي جهاز.
set -e
pip install -q -r requirements.txt
export PORT="${PORT:-8000}"
echo "→ سيعمل التطبيق على المنفذ $PORT"
exec python -m uvicorn agent:app --host 0.0.0.0 --port "$PORT"
