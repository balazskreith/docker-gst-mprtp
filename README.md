# Docker script for gst-mprtp plugin

## Introduction

This repository contains files to run and test [gst-mprtp](https://github.com/balazskreith/gst-mprtp) plugin.


## Install & Run

### Clone and Build

Run the following commands:

```shell script
git clone github.com/balazskreith/docker-gst-mprtp
cd docker-gst-mprtp
make build
``` 

This will clone the repository, build the docker image, in which 
inside the image all necessary gstreamer plugin is installed from source.
gst-mprtp is also installed and compiled.

### Run Tests

Edit the Makefile, and setup the SOURCE_DIR to point to the directory you cloned the docker-gst-mprtp.

To run a test type:

```shell script
make run ARGS="[Test arguments]"
``` 

, where the value of the args determines the type of the test you run using gst-mprtp plugin.
More about the test what you can run you can read [here]().

After the test is run, you can find the results in the results directory.

### Develop gst-mprtp

After the build has done, you need to clone the gst-mptrtp plugin 

```shell script
make clone
``` 
NOTE: If you want to run tests, please make sure you installed [git lfs](https://help.github.com/en/github/managing-large-files/installing-git-large-file-storage). 
Otherwise the tester cannot use the prepared video sequences for testing.  

#### Step 3: Setup & Run




#NOTES:



```shell script
git clone github.com/balazskreith/gst-mprtp
``` 
To test the plugin you also need to download Kristen.yuv, and Kristen_1024.yuv, 
which are pushed with `git lfs`. Please make sure you installed `git lfs` extension 
before you run the following scripts.

```shell script
cd gst-mprtp/tests
git checkout Kristen.yuv
git checkout Kristen_1024.yuv
``` 


building for development:

make run

THEN:

DIST_DIR=/opt/gstreamer-dist-master
export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig
./autogen.sh --prefix=$DIST_DIR --disable-gtk-doc --disable-oss4 

cd tester
./make.sh
./scripts/setup_testbed.sh

Unfortunately the prefix has no effect on autogen, so I setup the plugindir manually:
plugindir="/opt/gstreamer-dist-master/lib/gstreamer-1.0"

Only if we compile the source with  

(./configure --prefix=/opt/gstreamer-dist-master/lib --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install) 
 
 
it works. with ./autogen it does not

FOR debug: 
G_DEBUG=fatal-warnings ./snd_pipeline --codec=VP8 --sender=MPRTP:2:1:10.0.0.6:5000:2:10.0.1.6:5002 --scheduler=MPRTPFRACTAL:MPRTP:2:1:5001:2:5003 --stat=/tmp/snd_packets_1.csv:3 --source=FILE:Kristen.yuv:1:1280:720:2:25/1 
 

# gst-mprtp builder and development environment

## Build and run tests

1. build the image
`make build`

2. Enter to the container

3. Setup the environment for testing

4. Run tests
`python3 tester/main.py --help`


2. Clone the gst-mprtp into your host, and change the Makefile run command to something like this:
docker run --privileged -v [YOUR GST-MPRTP]:/opt/gstreamer-build-master/gst-mprtp -p 8080:80 -it $(NAME) /bin/bash

3. Enter to the container


