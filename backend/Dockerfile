FROM python:3.11-slim

# libs OpenCV needs at runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 libgl1 curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

# Model is mounted at runtime from ./model (see docker-compose.yml)
ENV LOCAL_MODEL_PATH=/model/mithu-vit.onnx
EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
