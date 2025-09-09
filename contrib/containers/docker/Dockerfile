# Licensed under the Apache License, Version 2.0

# ---- Build stage ----
FROM rust:1.82-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential pkg-config libssl-dev ca-certificates git && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /src
RUN git clone --depth=1 https://github.com/ovh/shai.git .
RUN cargo build --release

# ---- Runtime stage ----
FROM debian:stable-slim
ENV HOME=/home/shai XDG_CONFIG_HOME=/home/shai/.config
RUN useradd -m -u 10001 shai && \
    apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl libssl3 libgcc-s1 && \
    rm -rf /var/lib/apt/lists/*
USER shai
WORKDIR /home/shai
RUN mkdir -p /home/shai/.config/shai
COPY --from=build /src/target/release/shai /usr/local/bin/shai
ENTRYPOINT ["shai"]
