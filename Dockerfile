FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd

RUN useradd -m -s /bin/bash ansible

RUN echo "ansible:ansible" | chpasswd

RUN usermod -aG sudo ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible

RUN echo "PasswordAuthentication yes" > /etc/ssh/sshd_config.d/99-lab.conf

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
