# Shared Chromium Base Image

This repository provides a Docker base image with Google Chrome (v126.0.6478.126) and Node.js 22 for Puppeteer-based Render services.

## Usage
- Use as a base image: `FROM africanfuture/shared-chromium:latest`
- Set environment variable: `PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome`

## Automated Builds
- GitHub Actions builds and pushes to Docker Hub on every push to `main`.