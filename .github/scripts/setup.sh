#!/usr/bin/env bash
set -e
# Setup script for GitHub Actions

echo "Setting up Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y jq build-essential libffi-dev

echo "Setup complete!"
