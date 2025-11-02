FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    curl \
    sudo \
    bash \
    systemd \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /entropy_bootstrap_linux

# Copy repository files into the image for a lightweight syntax check
COPY . /entropy_bootstrap_linux

# Lightweight check: ensure scripts parse correctly
RUN bash -n setup.sh

CMD ["/bin/bash"]
