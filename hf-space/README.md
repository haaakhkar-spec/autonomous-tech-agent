---
title: الوكيل التقني المستقل
emoji: 🤖
colorFrom: gray
colorTo: blue
sdk: docker
app_port: 7860
pinned: false
license: mit
short_description: وكيل تقني ذاتي — شات ومختبر وتنفيذ مهام
---

# الوكيل التقني المستقل

وكيل ذاتي تقني: شات ذكي + مختبر مستقل + تنفيذ مهام + استضافة البرامج المولّدة.

## الإعداد المطلوب

اذهب إلى **Settings ← Variables and secrets** وأضف:

| النوع | الاسم | القيمة |
|---|---|---|
| Secret | `LLM_API_KEY` | مفتاح النموذج |
| Variable | `LLM_BASE_URL` | `https://api.groq.com/openai/v1` (موصى به) |
| Variable | `LLM_MODEL` | `llama-3.3-70b-versatile` |
| Secret | `CAPTCHA_API_KEY` | مفتاح 2Captcha (اختياري) |

> الطبقة المجانية من Gemini محدودة بـ ٢٠ طلباً يومياً. استخدم Groq أو OpenRouter
> أو نموذجاً محلياً للحصول على وكيل ذاتي يعمل فعلاً.

## الاستخدام

- اكتب «نفذ» لبدء التنفيذ الكامل في الخلفية
- «عدل الكود الاساسي» لتطوير الكود الخام
- زر **🧪 المختبر** أعلى يسار يفتح لوحة التحكم
- 📎 لإرفاق صور وفيديو
- ☰ أعلى يمين للمحادثات المحفوظة

## الحدود

كل الحدود معطّلة: `MAX_AGENT_STEPS=0`، `MAX_TOOL_OUTPUT=0`، `TOOL_RESULT_CHARS=0`.
الحماية الوحيدة: كشف التكرار العقيم (`MAX_REPEAT_CALLS=4`).
