# Use Ubuntu 24.04 LTS for long-term support and updated packages
FROM ubuntu:24.04

# Metadata for the image
LABEL maintainer="afrcanfuture@gmail.com" \
      description="Base image with Google Chrome and Node.js 22 for Puppeteer-based Render services" \
      version="1.0"

# Set non-interactive frontend to avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Update package lists and install core dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        fonts-liberation \
        libayatana-appindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdbus-1-3 \
        libgdk-pixbuf-2.0-0 \
        libnspr4 \
        libnss3 \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        xdg-utils \
        libgbm1 \
        libxss1 \
        wget \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Install Google Chrome (pinned version for reproducibility)
RUN wget -q https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_126.0.6478.126-1_amd64.deb && \
    apt-get update && \
    apt-get install -y -f ./google-chrome-stable_126.0.6478.126-1_amd64.deb && \
    rm google-chrome-stable_126.0.6478.126-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Chrome path
ENV CHROMIUM_PATH=/usr/bin/google-chrome
ENV PUPPETEER_EXECUTABLE_PATH=$CHROMIUM_PATH

# Keep container running for Render compatibility
CMD ["tail", "-f", "/dev/null"]