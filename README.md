# Docker script for gst-mprtp

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

This will clone the repository, and build the docker image, in which gst-mprtp is built.

### Run Tests

To run a test type:

```shell script
make run SOURCE_DIR="SOURCE_DIRECTORY" TEST="TEST_PARAMS"
``` 

, where `SOURCE_DIRECTORY` is the absolute path of the directory your cloned 
`docker-gst-mprtp` lies and `TEST_PARAMS` value is the test you  want to run.
 More about the possible test you can read [here](https://github.com/balazskreith/gst-mprtp/tree/master/tests).

After the test is run, you can find the results of the test in the `results` directory.

### Develop gst-mprtp

First, you need to follow the instruction written for `Clone and Build`.
To clone the `gst-mprtp` branch for develop, please type:

```shell script
make clone 
``` 
Please make sure you have `git lfs` to check out large files from git.
If you have successfully cloned the base repository, please enter to the image.

```shell script
make enter 
``` 

In the container, you need to navigate yourself to the development directory 
mounted to the docker container as you entered. If you have not changed the 
`DEVELOP_DIR` inside of the Makefile, then:

```shell script
cd /opt/gstreamer-build-master/dev-gst-mprtp
```

At the first time when you enterring to the development folder in the container type
```shell script
export PKG_CONFIG_PATH=/opt/gstreamer-dist-master/lib/pkgconfig
./autogen.sh --prefix=/opt/gstreamer-dist-master --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install
```

You need to install the plugin, before you run.

```shell script
make install
```

If you want to test your solution follow the run the following:

```shell script
cd /opt/gstreamer-build-master/dev-gst-mprtp/tests  
./make.sh && ./scripts/setup_testbed.sh
python3 tester/main.py TEST_ARGS
```

where you can setup TEST_ARGS by following [this](https://github.com/balazskreith/gst-mprtp/tree/master/tests). guide.

## Issues

If you have issues with installing please write an issue [here](https://github.com/balazskreith/docker-gst-mprtp/issues), 
if you have issues with gst-mprtp please write an issue [here](https://github.com/balazskreith/gst-mprtp/issues/).

## Contribution

Both project is under LGPL licence, and you are very welcome to contribute.


