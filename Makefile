NAME = gst-mprtp-docker
VERSION = 0.0.1

.PHONY: all build 

all: build

build:
	docker build -t $(NAME) .

run:
	docker run --privileged -v ~/github/gst-mprtp/:/opt/gstreamer-build-master/gst-mprtp -p 8080:80 -it $(NAME) /bin/bash
