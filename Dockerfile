# Use an official Ubuntu base image
FROM ubuntu:24.04

# Prevent tzdata from asking interactive questions
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv\
    && rm -rf /var/lib/apt/lists/*

# Copy application files into the container
WORKDIR /app
COPY . /app

# Create and activate virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies (always from requirements.txt)
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080
EXPOSE 8080

# Command to run your app (replace app.py with your main script)
CMD ["python3", "app.py"]
