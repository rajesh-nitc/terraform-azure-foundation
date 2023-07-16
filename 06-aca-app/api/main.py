from typing import Optional

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods="GET",
    allow_headers=["*"]
)


@app.get("/")
def read_root(request: Request):
    print("Request headers: ", request.headers)
    user_name = request.headers.get("x-ms-client-principal-name") or "world"
    return {"message": "hello", "user_name": user_name}
