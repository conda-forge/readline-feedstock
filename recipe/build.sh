#!/usr/bin/env bash

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

./configure --prefix=${PREFIX}  \
            --build=${BUILD}    \
            --host=${HOST}      \
            --disable-static    \
            || { cat config.log; exit 1; }
make SHLIB_LIBS="$(pkg-config --libs ncurses)" -j${CPU_COUNT} ${VERBOSE_AT}
make install
