# Use Ubuntu 24.04 LTS for long-term support and updated packages
FROM ubuntu:24.04

# Metadata for the image
LABEL maintainer="africanfuture@gmail.com" \
      description="Base image with Google Chrome and Node.js 22 for Puppeteer-based Render services" \
      version="1.0"

# Set non-interactive frontend to avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Update package lists
RUN apt-get update && apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# Install core dependencies for Chrome and Puppeteer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-liberation \
        libayatana-appindicator3-1 \
        libasound2t64 \
        libatk-bridge2.0-0t64 \
        libatk1.0-0t64 \
        libcups2t64 \
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
    apt-get install -y -f && \
    rm -rf /var/lib/apt/lists/*

# Install Google Chrome (latest stable version)
RUN curl -fsSL -o chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt-get install -y -f ./chrome.deb && \
    rm chrome.deb && \
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