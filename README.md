# Shared Chromium Base Image

This repository provides a Docker base image with Chromium installed, designed for use in Puppeteer-based Render services.

## Usage
- Use as a base image: `FROM yourusername/chromium-base:latest`
- Set environment variable: `PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser`

## Build and Push
```bash
docker build -t yourusername/chromium-base:latest .
docker push yourusername/chromium-base:latest
