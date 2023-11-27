# Force the platform to linux/amd64 as it does not run natively on Silicon
FROM --platform=linux/amd64 ubuntu:latest

# Install all required dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    git \
    make \
    cmake \
    curl \
    nano \
    ca-certificates

# Update faulty locale initialization
RUN printf '%s\n%s\n' "export LANG=en_US.UTF-8" "$(cat /etc/profile)" > /etc/profile && \
    printf '%s\n%s\n' "export LANGUAGE=en_US.UTF-8" "$(cat /etc/profile)" > /etc/profile

# Prepare the launch script
RUN cd home && \
    touch launch.sh && \
    printf 'export DISPLAY=docker.for.mac.host.internal:0\ncd "erforceSimulator/build/bin" && ./ra' > ./launch.sh && \
    chmod +x ./launch.sh

# Download the installation script
RUN cd home && \
    curl -vL https://raw.githubusercontent.com/Los-UruBots-del-Norte/framework/installer/installer.sh --output installer.sh && \
    chmod a+x ./installer.sh