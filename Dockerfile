# syntax=docker/dockerfile:1
FROM ubuntu:24.10@sha256:6db2266aa8d3b2836c42040cc02833ca87a14d7b926f4fe1d5bb2a00e15ce2fe

# This is insanely slow.
RUN apt-get update --yes \
    && apt-get install --yes \
        ffmpeg 

RUN apt-get install --yes \
        lbzip2 \
        cifs-utils \
        iproute2

# ADD --checksum=sha256:991fb499e7411d0a4172c91d3ef0c0bcd44c19946a52fa8f2c7486491453877f \
#     --chmod=777 \
#     https://download.roonlabs.com/builds/roonserver-installer-linuxx64.sh \
#     /tmp/roon-install.sh
#     
# RUN /tmp/roon-install.sh

ADD --checksum=sha256:479e79bb7dd2e639aa20a743b5184c6df08c7b9b06df1f789da3d7faa82bc076 \
    https://download.roonlabs.com/builds/RoonServer_linuxx64.tar.bz2 \
    /tmp/RoonServer_linuxx64.tar.bz2

WORKDIR /tmp
    
RUN tar xf RoonServer_linuxx64.tar.bz2 -C /opt/ \
    && rm RoonServer_linuxx64.tar.bz2

RUN /opt/RoonServer/check.sh

ENV ROON_DATAROOT=/var/roon
ENV ROON_ID_DIR=/var/roon

ENTRYPOINT ["/opt/RoonServer/start.sh"]
