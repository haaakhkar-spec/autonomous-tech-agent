# الوكيل التقني المستقل — ملف واحد

ملف واحد (`agent.py`) يحتوي كل شيء: واجهة الشات، المختبر (لوحة التحكم)،
الوكيل التنفيذي الذاتي، مكتبة الصور والفيديو، المحادثات المحفوظة،
والاستضافة الدائمة للبرامج المولّدة.

لا يحتاج قاعدة بيانات. لا يحتاج خدمات خارجية غير مزوّد النموذج.

---

## ١) النشر على GitHub — خطوة بخطوة

### أ) أنشئ المستودع

1. افتح https://github.com/new
2. الاسم: `autonomous-tech-agent` (أو أي اسم تريد)
3. اختر **Private** إن أردت إخفاء الكود، أو **Public**
4. **لا** تضف README أو .gitignore (سنرفع ملفاتنا)
5. اضغط **Create repository**

### ب) ارفع الملفات

افتح الطرفية في مجلد الملف واكتب:

```bash
cd single

git init
git add agent.py requirements.txt Dockerfile render.yaml README.md .env.example
git commit -m "الوكيل التقني المستقل — ملف واحد"

git branch -M main
git remote add origin https://github.com/<حسابك>/<المستودع>.git
git push -u origin main
```

بدّل `<حسابك>` باسم مستخدمك و`<المستودع>` باسم المستودع.

عند طلب كلمة المرور، استخدم **Personal Access Token** لا كلمة المرور:
أنشئه من https://github.com/settings/tokens (صلاحية `repo`) وضعه مكان كلمة المرور.

---

## ٢) النشر الدائم على Render

الملف `render.yaml` جاهز، وRender يقرأه تلقائياً.

1. افتح https://dashboard.render.com
2. اضغط **New** ← **Blueprint**
3. اربط حساب GitHub واختر المستودع
4. Render سيتعرّف على `render.yaml` ويعرض الخدمة
5. عند طلب المتغيرات املأ:
   - `LLM_API_KEY` = مفتاح النموذج
   - `CAPTCHA_API_KEY` = مفتاح 2Captcha (اختياري، اتركه فارغاً)
6. اضغط **Apply**

انتظر ٢–٣ دقائق. ستحصل على رابط ثابت مثل:

```
https://autonomous-tech-agent.onrender.com
```

هذا الرابط **ملكك ومستقل**، ويعمل بعد إغلاق متصفحك لأن السيرفر يعمل على Render
لا في جهازك. اضغط على الرابط تظهر واجهة الشات مباشرة.

> القرص الدائم ٥ جيجابايت مربوط على `/var/data` في `render.yaml`،
> فتبقى البرامج المنشورة والمحادثات محفوظة بعد كل إعادة تشغيل.

---

## ٣) اختيار النموذج

الطبقة المجانية من Gemini محدودة بـ **٢٠ طلباً يومياً** فقط، وهذا لا يكفي
لوكيل ذاتي متعدد الخطوات. للاستضافة الدائمة استخدم مزوّداً بسقف أعلى.

### Groq (الأسرع، طبقة مجانية سخية)

في Render ← Environment أضف:

```
LLM_BASE_URL = https://api.groq.com/openai/v1
LLM_MODEL    = llama-3.3-70b-versatile
LLM_API_KEY  = <مفتاح Groq من console.groq.com>
```

### OpenRouter (نماذج كثيرة بمفتاح واحد)

```
LLM_BASE_URL = https://openrouter.ai/api/v1
LLM_MODEL    = meta-llama/llama-3.3-70b-instruct
LLM_API_KEY  = <مفتاح OpenRouter>
```

### نموذج محلي مفتوح (بلا مزوّد ولا سقف طلبات)

شغّل Ollama أو vLLM على جهازك واجعله متاحاً:

```
LLM_BASE_URL = http://<عنوان-جهازك>:11434/v1
LLM_MODEL    = qwen2.5:14b
LLM_API_KEY  = ollama
```

يمكن التبديل بينها لاحقاً من الواجهة: **المختبر ← النموذج النشط ← حفظ وتفعيل**.

---

## ٤) التشغيل المحلي (اختياري)

```bash
pip install -r requirements.txt

# لينكس/ماك
export LLM_API_KEY="مفتاحك"
python agent.py

# ويندوز PowerShell
$env:LLM_API_KEY="مفتاحك"
python agent.py
```

ثم افتح http://localhost:8000

---

## ٥) الاستخدام

| العنصر | الوظيفة |
|---|---|
| كلمة السر `نفذ` | تبدأ التنفيذ الكامل في الخلفية |
| `عدل الكود الاساسي` | يطوّر الكود الخام ويضيف الميزات |
| زر **المختبر** (أعلى يسار) | ينتقل للوحة التحكم |
| 📎 | إرفاق صور وفيديو للتحليل والتعديل |
| ☰ (أعلى يمين) | المحادثات المحفوظة مع الحذف |

في المختبر:

- **الكود المؤقت** — يتولّد ذاتياً أثناء التنفيذ، لا يُرسل في الشات
- **الكود الأساسي الخام** — قابل للتعديل
- **المفاتيح الخمسة** — تتولّد تلقائياً وتتبدّل كل ٢٤ ساعة
- **البرامج المنشورة** — رابط مباشر + مفتاح API مستقل لكل برنامج
- **مكتبة الصور والفيديو** — عرض وحذف

---

## ٦) بلا حدود

كل الحدود معطّلة افتراضياً:

| المتغير | القيمة | المعنى |
|---|---|---|
| `MAX_AGENT_STEPS` | `0` | بلا حد على عدد خطوات التنفيذ |
| `MAX_TOOL_OUTPUT` | `0` | بلا اقتطاع لمخرجات الأدوات |
| `TOOL_RESULT_CHARS` | `0` | بلا اقتطاع لنتيجة الأداة للنموذج |
| `TOOL_TIMEOUT` | `600` | مهلة تنفيذ الأوامر بالثواني |
| `MAX_SEARCH_RESULTS` | `50` | أقصى نتائج بحث لكل استدعاء |
| `HISTORY_TURNS` | `40` | عدد أدوار السياق المحمّلة |

الحماية الوحيدة من الحلقات اللانهائية هي **كشف التكرار العقيم**
(`MAX_REPEAT_CALLS=4`): إذا كرّر الوكيل نفس الاستدعاء بلا نتيجة عدة مرات
يُنبَّه ليغيّر الأسلوب. هذه ليست سقفاً على الخطوات — المهام الطويلة تُكمل.

---

## ٧) بدائل Render

- **Fly.io**: `fly launch` ثم `fly deploy` (يقرأ `Dockerfile`)
- **Railway**: New Project ← Deploy from GitHub (يقرأ `Dockerfile`)
- **أي VPS**: انسخ الملفات ثم
  ```bash
  pip install -r requirements.txt
  LLM_API_KEY=... PORT=80 nohup python agent.py &
  ```

---

## ٨) ملاحظات

- **مفتاح Gemini مقيد بـ HTTP referrers لن يعمل من السيرفر.** اجعله
  `IP addresses` أو `None` من Google Cloud Console ← Credentials.
- البرامج المنشورة تُخزَّن في `DATA_DIR/apps/<slug>/` وتُخدَم من `/apps/<slug>/`.
- لكل برنامج منشور مفتاح API مستقل: `POST /api/apps/<slug>/run`.
- الفحوصات: `GET /health` و `GET /api/lab/state`.
