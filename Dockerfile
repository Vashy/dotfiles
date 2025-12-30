FROM ubuntu:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_SOURCE=noninteractive

# Install dependencies needed for chezmoi and your scripts
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    bash \
    gcc \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a test user (don't run chezmoi as root!)
RUN useradd -m -s /bin/bash vashy && \
    echo "vashy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vashy
WORKDIR /home/vashy

# Install chezmoi for the test user
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /home/vashy/.local/bin

# Add chezmoi to the path
ENV PATH="/home/vashy/.local/bin:${PATH}"

# Copy your local dotfiles into the container
# (We copy them to a temp folder so we can 'chezmoi init')
COPY --chown=vashy:vashy . /home/vashy/temp_dotfiles
COPY --chown=vashy:vashy ./chezmoi.toml /home/vashy/.config/chezmoi/chezmoi.toml

# Set the default command to a shell
CMD ["/bin/bash"]
