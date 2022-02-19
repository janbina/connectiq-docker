#!/bin/bash
xhost +local:

CIQ_WORKSPACE=${CIQ_WORKSPACE:-`pwd`/workspace}

MAP_UID=${UID:-`id -u`}
MAP_GID=${GID:-`id -g`}

if [ -f ${CIQ_WORKSPACE}/developer_key.der ]; then
    echo "Certificate keys already created"
else
    echo "Generating Certificate keys"
    mkdir -p ${CIQ_WORKSPACE}
    openssl genrsa -out ${CIQ_WORKSPACE}/developer_key.pem 4096
    openssl pkcs8 -topk8 -inform PEM -outform DER -in ${CIQ_WORKSPACE}/developer_key.pem -out ${CIQ_WORKSPACE}/developer_key.der -nocrypt
fi

docker run -it --rm \
    -v $CIQ_WORKSPACE:/home/developer \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -u $MAP_UID:$MAP_GID \
    --privileged \
    johny/connectiq:latest /bin/bash
