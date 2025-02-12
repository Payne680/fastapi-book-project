# Step 1: Use a lightweight Python image
FROM python:3.9-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the entire application directory to the container
COPY . /app

# Step 4: Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Install Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Step 6: Copy the Nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# Step 7: Expose necessary ports
EXPOSE 80 8000

# Step 8: Start Nginx and Uvicorn when the container runs
CMD service nginx start && \
    uvicorn main:app --host 0.0.0.0 --port 8000 --reload
