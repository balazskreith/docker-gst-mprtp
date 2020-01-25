FROM debian:jessie

# install required packages
RUN echo 'deb http://httpredir.debian.org/debian jessie non-free' >> /etc/apt/sources.list
RUN apt-get -y update 

RUN apt-get install -y autoconf automake bison flex autopoint libtool \
        libglib2.0-dev yasm nasm xutils-dev libpthread-stubs0-dev libpciaccess-dev libudev-dev \
        libfaac-dev libxrandr-dev libegl1-mesa-dev openssh-server git-core wget \
        build-essential gettext libgles2-mesa-dev vim-nox libav-tools libshout3-dev libsoup2.4-dev \
        nginx libssl-dev intel-gpu-tools libpcap-dev sudo

RUN apt-get install -y libopencv-dev opencv-data software-properties-common python-software-properties

# We need to add a python
#RUN apt-get install -qy python3 python3-pip

COPY opt /opt/
COPY html /var/www/html

RUN /opt/build-gstreamer-with-gst-mprtp.sh
