# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy only the requirements file first (for better caching)
COPY requirements.txt /app/

# Upgrade pip and install dependencies
# RUN pip install --no-cache-dir --upgrade pip && \
#     pip install --no-cache-dir -r requirements.txt

RUN  pip install --no-cache-dir --timeout=100 --index-url https://pypi.org/simple -r requirements.txt


# Copy the rest of the application
COPY . /app

# Expose necessary ports
EXPOSE 8000

# Start the FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
