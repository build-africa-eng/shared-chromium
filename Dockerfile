# Use Ubuntu 24.04 LTS for long-term support and updated packages
FROM ubuntu:24.04

# Metadata for the image
LABEL maintainer="africanfuture@gmail.com" \
      description="Base image with Google Chrome and Node.js 22 for Puppeteer-based Render services" \
      version="1.2"

# Set non-interactive frontend to avoid prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Update package lists and install base dependencies for adding new repositories
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # ca-certificates is required for HTTPS connections (fixes the curl 77 error)
    ca-certificates \
    curl \
    wget \
    gpg && \
    rm -rf /var/lib/apt/lists/*

# Install Google Chrome and its dependencies using the official repository
RUN apt-get update && \
    # Add Google's official signing key
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg && \
    # Add the Google Chrome repository
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    # Update package lists again to include the new repo, then install
    apt-get update && \
    apt-get install -y --no-install-recommends \
        google-chrome-stable \
        fonts-liberation \
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
        libxss1 \
        libgbm1 \
        libxkbcommon0 \
        libayatana-appindicator3-1 \
        xdg-utils && \
    # Clean up APT cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Puppeteer
ENV CHROMIUM_PATH=/usr/bin/google-chrome
ENV PUPPETEER_EXECUTABLE_PATH=$CHROMIUM_PATH

# Keep container running for Render compatibility
CMD ["tail", "-f", "/dev/null"]