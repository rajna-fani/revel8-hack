# Hermetica Hack

<img src="frontend/favicon.png" alt="Hermetica Hack favicon" width="64" />

AI social engineering simulation for Google Meet, Email & SMS Phishing links. Deploy CEO agents to test security bot defenses.

## Demo

- **Videos**:
  - **Main deliverable**: 


https://github.com/user-attachments/assets/8b53f684-d647-4f8f-9a07-2c77fb45d19f



  - **Agent 1**: 


https://github.com/user-attachments/assets/a3fbb5e2-270a-4f63-b18d-3084610138b7



  - **Agent 2**: 



https://github.com/user-attachments/assets/3de235c4-a71a-4723-b887-5f27bb940741



## Prerequisites

- Python 3.10+
- Docker Desktop (running)
- uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- OpenAI API key
- ElevenLabs API key

## Setup

1. Clone and enter directory:
```bash
git clone https://github.com/rajna-fani/revel8-hack.git
cd revel8-hack
```

2. Create `.env` file:
```env
JOINLY_LLM_PROVIDER=openai
JOINLY_LLM_MODEL=gpt-4o-mini
OPENAI_API_KEY=your-key
ELEVENLABS_API_KEY=your-key
```

3. Install dependencies:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

4. Start Docker Desktop

5. Run the server:
```bash
./start.sh
```

6. Open http://localhost:8080

## Usage

1. Enter Google Meet link
2. Select agent (1 or 2)
3. Click "INITIATE OPERATION"

## What Runs Under the Hood

When you click "INITIATE OPERATION", the server runs:

**1. Start Joinly Docker server:**
```bash
docker rm -f joinly-server 2>/dev/null || true
docker run -d --name joinly-server -p 8000:8000 --env-file .env ghcr.io/joinly-ai/joinly:latest
```

**2. Start Joinly client (CEO agent):**
```bash
uvx joinly-client \
  --env-file .env \
  --name "Hermetica Hack Agent" \
  --llm-provider openai \
  --llm-model gpt-4o-mini \
  --prompt-file prompt_2.txt \
  --stt whisper \
  --tts elevenlabs \
  "https://meet.google.com/xxx-xxxx-xxx" \
  -vv
```

## Manual Run (without dashboard)

```bash
# Terminal 1: Start Joinly server
docker rm -f joinly-server 2>/dev/null || true
docker run -d --name joinly-server -p 8000:8000 --env-file .env ghcr.io/joinly-ai/joinly:latest

# Terminal 2: Run the agent
uvx joinly-client \
  --env-file .env \
  --name "Revel8 Assistant" \
  --llm-provider openai \
  --llm-model gpt-4o-mini \
  --prompt-file prompt_2.txt \
  --stt whisper \
  --tts elevenlabs \
  "YOUR_GOOGLE_MEET_LINK" \
  -vv
```

## Agents

| Agent | Prompt File | Description |
|-------|-------------|-------------|
| Agent 1 | prompt_1.txt | Emergency audit, job threats |
| Agent 2 | prompt_2.txt | Medical emergency, IT admin role, password guessing |
| Agent 3 | prompt_3.txt | IT security expert, protocol compliance, role switching |

## Troubleshooting

Docker not running:
```bash
open -a Docker
```

Port 8080 in use:
```bash
kill -9 $(lsof -ti:8080)
```

Port 8000 conflict:
```bash
docker rm -f joinly-server
```
