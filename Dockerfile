FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Minimal packages required to run the scripts and Docker run tests
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    sudo \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /entropy_bootstrap_linux

# Copy repository files into the image
COPY . /entropy_bootstrap_linux

# Default to dry-run inside the container to avoid heavy installs during CI
ENV DRY_RUN=true

CMD ["/bin/bash"]
