FROM debian:jessie

# install required packages
RUN echo 'deb http://httpredir.debian.org/debian jessie non-free' >> /etc/apt/sources.list
RUN apt-get -y update 

RUN apt-get install -y autoconf automake bison flex autopoint libtool \
        libglib2.0-dev yasm nasm xutils-dev libpthread-stubs0-dev libpciaccess-dev libudev-dev \
        libfaac-dev libxrandr-dev libegl1-mesa-dev openssh-server git-core wget \
        build-essential gettext libgles2-mesa-dev vim-nox libav-tools libshout3-dev libsoup2.4-dev \
        nginx libssl-dev intel-gpu-tools libpcap-dev sudo 

# We need to add a couple of extra pacgkages
RUN apt-get update && apt-get install -y libopencv-dev opencv-data software-properties-common python-software-properties \
        gnuplot5 gdb libvpx-dev curl

# We need to add a python
RUN apt-get install -qy python3 python3-pip

# This step only necessery if you wanna download git lfs files inside the container.
# Although many of the packages I added only necessary if you wanna develop from inside of the container, so
# feel free to optimize packages gdb, and curl, etc. out. I won't touch them now, thats for sure!
RUN build_deps="curl" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${build_deps} ca-certificates && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*


# RUN pip3 install --upgrade pip && pip3 install --upgrade setuptools

COPY opt /opt/
COPY html /var/www/html

RUN /opt/build-gstreamer-1-14-5.sh

RUN /opt/build-gst-mprtp.sh
