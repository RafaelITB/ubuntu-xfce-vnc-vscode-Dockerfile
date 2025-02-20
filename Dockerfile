FROM ubuntu:24.04

# Actualizar e instalar dependencias
RUN apt update && apt install -y \
    tightvncserver \
    xfce4 \
    xfce4-goodies \
    openssh-server \
    python3 \
    python3-pip \
    wget \
    curl \
    sudo \
    dbus-x11

# Crear usuario y configurar contraseña
RUN useradd -m -s /bin/bash rgs && echo "rgs:sjo" | chpasswd && usermod -aG sudo rgs

# Configuración de VNC
USER rgs
RUN mkdir -p /home/rgs/.vnc
RUN echo "sjo" | vncpasswd -f > /home/rgs/.vnc/passwd && chmod 600 /home/rgs/.vnc/passwd

# Configuración de XFCE para VNC
RUN echo "xrdb $HOME/.Xresources\nstartxfce4 &" > /home/rgs/.vnc/xstartup && chmod +x /home/rgs/.vnc/xstartup

## vscode stuff
USER root
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
  && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
  && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

## Install vscode in the specifc version
RUN apt-get update && apt-get install -y code=1.88.1-1712771838 \
  && apt-get install -f

RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/share/code/ \
  && cp /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0 /usr/share/code/ \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1 \
  && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1.1.0
RUN apt-get install xdg-utils --fix-missing -y

## /vscode stuff

# Exponer puertos necesarios
EXPOSE 22 5901

WORKDIR /workspace

# Comando para iniciar SSH y VNC
CMD su - rgs -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null"
