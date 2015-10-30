# -*- Dockerfile -*-

FROM chadxz/pjsip:latest 
MAINTAINER David M. Lee, II <dlee@respoke.io>

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --system asterisk

RUN apt-get update -qq && \
    apt-get install -y \
            build-essential \
            curl \
            libcurl4-openssl-dev \
            libedit-dev \
            libgsm1-dev \
            libjansson-dev \
            libogg-dev \
            libsqlite3-dev \
            libsrtp0-dev \
            libssl-dev \
            libxml2-dev \
            libxslt1-dev \
            uuid \
            uuid-dev \
            binutils-dev \
            libpopt-dev \
            libspandsp-dev \
            libvorbis-dev \
            portaudio19-dev \
            && \
    apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*

ENV ASTERISK_VERSION=13.5.0
COPY build-asterisk.sh /build-asterisk
RUN /build-asterisk && rm -f /build-asterisk

CMD ["/usr/local/sbin/asterisk", "-f"]
