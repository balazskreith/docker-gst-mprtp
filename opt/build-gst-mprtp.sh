#!/bin/bash 
set -e

#It is necessary to run the tester inside of the gst-mprtp
#pip3 install numpy==1.16
#pip3 install matplotlib==2.2.4

GST_BRANCH="master"

DIST_DIR=/opt/gstreamer-dist-$GST_BRANCH
BUILD_DIR=/opt/gstreamer-build-$GST_BRANCH
GST_MPRTP=gst-mprtp

cd $BUILD_DIR

[ ! -d gst-mprtp ] && git clone --recurse-submodules -b $GST_BRANCH git://github.com/balazskreith/gst-mprtp ${GST_MPRTP}

export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig

cd gst-mprtp
(./autogen.sh --prefix=$DIST_DIR --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install)
echo "Checking out files with git-lfs" 
cd tests 
git lfs checkout Kristen.yuv && \
git checkout Kristen.yuv && \
git lfs checkout Kristen_1024.yuv && \
git checkout Kristen_1024.yuv 

echo "Compile utils for tests"
cd ${BUILD_DIR}/${GST_MPRTP}/tests && ./make.sh

echo "Setup the testbed"
cd ${BUILD_DIR}/${GST_MPRTP}/tests && \
  chmod 777 scripts/setup_testbed.sh && \
  ./scripts/setup_testbed.sh 

# approximate time to setup the statsrelayer in the background
sleep 20
echo "We are done"
#unset intel media sdk variables
unset LIBVA_DRIVERS_PATH
unset LIBVA_DRIVER_NAME



#echo "environment settings:"
#echo "export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig"
#echo "export GST_PLUGIN_PATH=$DIST_DIR/lib"
#echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig"
