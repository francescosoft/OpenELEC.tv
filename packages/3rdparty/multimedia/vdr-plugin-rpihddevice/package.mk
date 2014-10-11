    

    ################################################################################
    #      This file is part of OpenELEC - http://www.openelec.tv
    #      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
    #
    #  OpenELEC is free software: you can redistribute it and/or modify
    #  it under the terms of the GNU General Public License as published by
    #  the Free Software Foundation, either version 2 of the License, or
    #  (at your option) any later version.
    #
    #  OpenELEC is distributed in the hope that it will be useful,
    #  but WITHOUT ANY WARRANTY; without even the implied warranty of
    #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    #  GNU General Public License for more details.
    #
    #  You should have received a copy of the GNU General Public License
    #  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
    ################################################################################
     
    PKG_NAME="vdr-plugin-rpihddevice"
    PKG_VERSION="aaacdf7"
    PKG_REV="1"
    PKG_ARCH="any"
    PKG_LICENSE="GPL"
    PKG_SITE=""
    PKG_URL="https://dl.dropboxusercontent.com/u/87694205/$PKG_NAME-$PKG_VERSION.tar.xz"
    PKG_DEPENDS_TARGET="toolchain bcm2835-driver vdr ffmpeg"
    PKG_PRIORITY="optional"
    PKG_SECTION="multimedia"
    PKG_SHORTDESC=""
    PKG_LONGDESC=""
    PKG_IS_ADDON="no"
    PKG_AUTORECONF="no"
     
    export MAKEFLAGS=-j1
     
    pre_configure_target() {
      export CFLAGS="$CFLAGS -fPIC"
      export CXXFLAGS="$CXXFLAGS -fPIC"
      export LDFLAGS="$LDFLAGS -fPIC"
       
      #export VCINCDIR="-I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      #export VCLIBDIR="-L$ROOT/$BUILD/.install_pkg/usr/lib"
      VDR_DIR=$(get_build_dir vdr)
      export INCLUDES="-I$VDR_DIR/include -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
     
      BCM2835_DRIVER_DIR=$(get_build_dir bcm2835-driver)
      export LDLIBS="-L$BCM2835_DRIVER_DIR/.install_pkg/usr/lib"
     
      sed -i 's|^PKGCFG = |#PKGCFG = |' Makefile
    }
     
    make_target() {
      VDR_DIR=$(get_build_dir vdr)
      make VDRDIR=$VDR_DIR \
        VDRSRC=$VDR_DIR \
        LIBDIR="." \
        LOCALEDIR="./locale" \
        LDFLAGS="$LDFLAGS -fPIC"
     
    }
     
    makeinstall_target() {
      : # installation not needed, done by create-addon script
    }

