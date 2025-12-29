"""
Hugging Face Spaces entry point for IDS Attack Detection System.
This file wraps the backend server for HF Spaces deployment.
"""
import os

# Set environment variables for HF Spaces
os.environ.setdefault("SOC_LISTEN_HOST", "0.0.0.0")
os.environ.setdefault("SOC_LISTEN_PORT", "7860")  # HF Spaces default port

from backend.server import main

if __name__ == "__main__":
    main()
