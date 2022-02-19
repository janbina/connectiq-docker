FROM ubuntu:20.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG ADDITIONAL_PACKAGES

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# libwebkitgtk-1.0-0
RUN echo "deb http://cz.archive.ubuntu.com/ubuntu bionic main universe" >> /etc/apt/sources.list

# Compiler tools
RUN apt-get update -y && \
    apt-get install --no-install-recommends -qqy openjdk-11-jdk && \
    apt-get install --no-install-recommends -qqy make unzip wget curl git ssh tar gzip tzdata ca-certificates gnupg2 libusb-1.0 libpng16-16 libgtk2.0-0 libwebkitgtk-1.0-0 libwebkitgtk-3.0-0 libgtk-3-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix missing libpng12 (monkeydo)
RUN ln -s /usr/lib/x86_64-linux-gnu/libpng16.so.16 /usr/lib/x86_64-linux-gnu/libpng12.so.0

# Set user=1000 and group=0 as the owner of all files under /home/developer
RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    chown -R 1000:0 /home/developer && chmod -R ug+rw /home/developer && \
    chown -R 1000:0 /opt && chmod -R ug+rw /opt

USER developer
ENV HOME /home/developer
WORKDIR /home/developer

CMD [ "/bin/bash" ]