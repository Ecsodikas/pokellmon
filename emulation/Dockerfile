FROM ubuntu:latest

COPY skyemu emerald.gba /app/

RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxi-dev \
    libxcursor-dev \
    libopengl-dev \
    libdbus-1-3 \
    libasound2t64

ENTRYPOINT ["/app/skyemu", "http_server", "9999", "/app/emerald.gba"]
