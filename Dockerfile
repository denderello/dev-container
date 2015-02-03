FROM dock0/arch

RUN pacman -Sy && \
  pacman -S tmux --noconfirm && \
  pacman -S vim --noconfirm && \
  pacman -S git --noconfirm && \
  pacman -S mercurial --noconfirm && \
  pacman -S strace --noconfirm && \
  pacman -S tcpdump --noconfirm && \
  pacman -S htop --noconfirm && \
  pacman -S ctags --noconfirm && \
  pacman -S wget --noconfirm && \
  pacman -S go --noconfirm && \
  pacman -S gcc-go --noconfirm && \
  pacman -S ack --noconfirm

# Setup home environment
ENV SHELL /bin/bash
RUN useradd --create-home dev
RUN mkdir -p /home/dev/go /home/dev/bin

ENV GOPATH /home/dev/go

# Create a shared data volume
RUN mkdir /var/shared/
RUN chown -R dev:dev /var/shared
VOLUME /var/shared

WORKDIR /home/dev
ENV HOME /home/dev

# Link in shared parts of the home directory
RUN ln -s /var/shared/.ssh

RUN chown -R dev:dev /home/dev/

USER dev

# Start tmux with forced 256 color and unicode mode
ENTRYPOINT /bin/bash -l -c "tmux -2 -u"
