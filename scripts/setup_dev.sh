#!/bin/bash

# Activate conda environment if it exists
if conda info --envs | grep -q "^qAIpodcast_venv"; then
    echo "Activating conda environment: qAIpodcast_venv"
    conda activate qAIpodcast_venv
fi

# Install package in development mode
echo "Installing podcast_service in development mode..."
pip install -e .

# Create necessary directories
mkdir -p data/users
mkdir -p data/downloads
mkdir -p data/transcripts
mkdir -p data/summaries

echo "Setup complete!"