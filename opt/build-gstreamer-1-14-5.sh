#!/bin/bash 
set -e

#It is necessary to run the tester inside of the gst-mprtp
pip3 install numpy==1.16
pip3 install matplotlib==2.2.4

GST_BRANCH="master"

GSTREAMER_COMMIT=latest
DIST_DIR=/opt/gstreamer-dist-$GST_BRANCH
BUILD_DIR=/opt/gstreamer-build-$GST_BRANCH

[ ! -d $BUILD_DIR ] && mkdir $BUILD_DIR
[ ! -d $DIST_DIR ] && mkdir $DIST_DIR

cd $BUILD_DIR

[ ! -d gstreamer ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gstreamer
[ ! -d gst-plugins-base ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-base
[ ! -d gst-plugins-good ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-good
[ ! -d gst-plugins-bad ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-bad
[ ! -d gst-plugins-ugly ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-ugly
[ ! -d gst-libav ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-libav
#[ ! -d gstreamer-mprtp ] && git clone -b https://github.com/balazskreith/gst-mprtp
[ ! -d drm ] && git clone http://anongit.freedesktop.org/git/mesa/drm.git
[ ! -d libva ] && git clone http://anongit.freedesktop.org/git/libva.git
[ ! -d intel-driver ] && git clone http://anongit.freedesktop.org/git/vaapi/intel-driver.git

export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig
#export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

#unset intel media sdk variables
unset LIBVA_DRIVERS_PATH
unset LIBVA_DRIVER_NAME


declare -A commits
commits[gstreamer]="f5beb2da840b2432b46c36b9ea54bbe426ffaed8"
commits[gst-plugins-base]="c1b4b0f80505cc8bf5579f56dd0028f40e611159"
commits[gst-plugins-good]="b5579eb7a835fde1287a2e7dc3e20143da938c0c"
commits[gst-plugins-bad]="dc1b94a15290172ffcc57c57f2b7ff6ee9322a5d"
commits[gst-plugins-ugly]="623870567900f6a44889cb103a50af4d24121d28"
commits[gst-libav]="4d7ab9a3839afd60219a3535f16012d4366e58f2"
commits[drm]="19e2cb05fa31aa40f2407b594f7cc7ff0e2148ba"
commits[libva]="ca13d6be03dd306f109af08f4c5e79fb7f895f89"
commits[intel-driver]="f30d546976b562362c0b0baabdf8e3a3c7379b6f"


for prj in gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav drm libva intel-driver
do
  echo "Setup $prj"
  cd $prj;
  if [ ${commits[$prj]+_} ]; then git checkout ${commits[$prj]}; else echo "We use the latest commit"; fi
   (./autogen.sh --prefix=$DIST_DIR --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install)
#  (./autogen.sh --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install)
  cd ..
done

echo "environment settings:"
echo "export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig"
echo "export GST_PLUGIN_PATH=$DIST_DIR/lib"
#echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig"
