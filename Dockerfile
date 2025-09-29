# Use an official Python base image
FROM python:3.11

# Set the working directory inside the container
WORKDIR /app


# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    g++ \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /tmp/*

# Copy the application code into the container
COPY . /app

# Expose the port FastAPI will run on
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Command to run the FastAPI app
CMD ["uvicorn", "src.api.app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
