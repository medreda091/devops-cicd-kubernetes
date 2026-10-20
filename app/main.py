"""Minimal FastAPI microservice used to demo a cloud-native CI/CD pipeline."""

from fastapi import FastAPI

app = FastAPI(title="demo-api", version="0.1.0")


@app.get("/")
def root():
    return {"status": "ok", "service": "demo-api"}


@app.get("/health")
def health():
    return {"status": "ok"}
