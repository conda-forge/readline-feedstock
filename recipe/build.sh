#!/usr/bin/env bash

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* support/

export CPPFLAGS="--sysroot=$CONDA_BUILD_SYSROOT -I$CONDA_BUILD_SYSROOT/include"
export LDFLAGS="--sysroot=$CONDA_BUILD_SYSROOT -L$CONDA_BUILD_SYSROOT/lib64"

./configure 
./configure --prefix=${PREFIX}  \
            --build=${BUILD}    \
            --host=${HOST}      \
            --disable-static    \
            --with-curses     CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS"  \
            || { cat config.log; exit 1; }
make SHLIB_LIBS="$(pkg-config --libs ncurses)" -j${CPU_COUNT} ${VERBOSE_AT}
make install
