import subprocess
try:
    from fastapi import FastAPI, Request
except ImportError:
    import sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "fastapi"])
    from fastapi import FastAPI, Request
import os

app = FastAPI()
PROMPT = open("prompt.txt", "r", encoding="utf-8").read()

@app.post("/start")
async def start(req: Request):
    data = await req.json()
    meet_link = data["meet_link"]

    env = os.environ.copy()
    # Load secrets from .env into the environment for the subprocess
    # (simple approach: rely on your shell having them, or you can export them)
    env["JOINLY_CUSTOM_INSTRUCTIONS"] = PROMPT

    # Start the external client that controls the prompt
    subprocess.Popen(["joinly-client", meet_link], env=env)

    return {"status": "started", "meet_link": meet_link}