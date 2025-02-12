# Use a base image with Python
FROM python:3.9-slim

# Install dependencies and Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Ensure FastAPI and Uvicorn are installed
RUN pip install --no-cache-dir fastapi uvicorn

# Copy FastAPI app
COPY . .

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose Render's expected port
EXPOSE 10000

# Start Nginx in the background and then FastAPI
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
