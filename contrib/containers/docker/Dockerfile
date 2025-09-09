# Licensed under the Apache License, Version 2.0

# ---- Build stage ----
FROM rust:1.82-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential pkg-config libssl-dev ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
ARG SHAI_REF=main
RUN git clone https://github.com/ovh/shai.git . && \
    git fetch --tags && \
    git checkout "${SHAI_REF}"
RUN cargo build --release --locked

# ---- Runtime stage ----
FROM debian:stable-slim
ENV HOME=/home/shai XDG_CONFIG_HOME=/home/shai/.config
RUN useradd -m -u 10001 shai && \
    apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl libssl3 libgcc-s1 libstdc++6 && \
    rm -rf /var/lib/apt/lists/*
USER shai
WORKDIR /home/shai
RUN mkdir -p /home/shai/.config/shai
COPY --from=build /src/target/release/shai /usr/local/bin/shai
ENTRYPOINT ["shai"]
