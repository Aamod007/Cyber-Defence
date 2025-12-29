# Multi-stage build for IDS Attack Detection System
# Optimized for Hugging Face Spaces
FROM python:3.11-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    git-lfs \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.11-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application code
COPY backend/ /app/backend/
COPY attack-detection-viz.html /app/
COPY model/ /app/model/
COPY Dataset/ /app/Dataset/
COPY zeek-live/ /app/zeek-live/
COPY app.py /app/

# Create necessary directories
RUN mkdir -p /app/backend_logs /app/detection_results /app/PCAP /app/zeek-live

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV SOC_LISTEN_HOST=0.0.0.0
ENV SOC_LISTEN_PORT=7860
ENV PORT=7860

# Expose port (HF Spaces default)
EXPOSE 7860

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:7860/api/health')" || exit 1

# Run the application
CMD ["python", "app.py"]
