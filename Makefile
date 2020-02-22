NAME = gst-mprtp-docker
VERSION = 0.0.1
GST_MPRTP = gst-mprtp-clone
TARGET_DIR=/opt/gstreamer-build-master/gst-mprtp
SOURCE_DIR=~/github/docker-gst-mprtp

.PHONY: all build 

all: build

build:
	docker build -t $(NAME) .

clone:
	git clone https://github.com/balazskreith/gst-mprtp ${GST_MPRTP} && \
	echo "gst-mprtp is checked out to ${GST_MPRTP}";
	
	echo "Checking out files with git-lfs" && \
	cd ${GST_MPRTP}/tests && \
	git lfs checkout Kristen.yuv && \
    git checkout Kristen.yuv && \
    git lfs checkout Kristen_1024.yuv && \
    git checkout Kristen_1024.yuv && \
    cd .. && \
    cd ..

#install:
#	docker exec -it ${NAME} \ 
#    		cd ${TARGET_DIR} && \
#    		cd tests && \
#    		./scripts/setup_testbed.sh

enter:
	docker run --privileged -v ~/github/docker-gst-mprtp/opt:/opt/scripts -p 8080:80 -it $(NAME) /bin/bash
	# docker run --privileged -v gst-mprtp-clone:/opt/gstreamer-build-master/gst-mprtp -p 8080:80 -it $(NAME) /bin/bash
	#docker run --privileged -v ~/github/gst-mprtp/:/opt/gstreamer-build-master/gst-mprtp -p 8080:80 -it $(NAME) /bin/bash

		
run:
	rm -rf results; mkdir results
	echo "cd ${TARGET_DIR}/tests && mkdir temp && (./scripts/setup_testbed.sh) && python3 tester/main.py ${ARGS}; cp ${TARGET_DIR}/tests/temp/* ${TARGET_DIR}/tests/results/" > results/cmds.sh
	docker run --privileged -v ${SOURCE_DIR}/results:${TARGET_DIR}/tests/results -it $(NAME) /bin/bash ${TARGET_DIR}/tests/results/cmds.sh
		