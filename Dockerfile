FROM ubuntu:22.04

LABEL maintainer="afrcanfuture@gmail.com" \
      description="Chromium + Node.js 22 + Puppeteer dependencies for Render compatibility"

# Install dependencies and Google Chrome in a single layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libgbm1 \
    wget \
    curl \
    && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Chromium path
ENV CHROMIUM_PATH=/usr/bin/google-chrome
ENV PUPPETEER_EXECUTABLE_PATH=$CHROMIUM_PATH

# Keep container running (Render compatibility)
CMD ["tail", "-f", "/dev/null"]