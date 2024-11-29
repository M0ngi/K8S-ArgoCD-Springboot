FROM ubuntu

RUN apt update && apt install openssh-server ansible less nano -y && mkdir /run/sshd

COPY id_ed25519 /root/.ssh/id_ed25519
COPY id_ed25519.pub /root/.ssh/id_ed25519.pub

COPY sshd_config /etc/ssh/sshd_config

RUN chmod 600 /root/.ssh/id_ed25519

COPY entrypoint.sh /entrypoint.sh
CMD [ "/entrypoint.sh" ]
