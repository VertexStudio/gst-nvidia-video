#!/usr/bin/env bash

set -o errexit

cd gst-plugins-bad

./autogen.sh --noconfigure

./configure \
    --libdir=/usr/lib/x86_64-linux-gnu \
    CUDA_CFLAGS="-I/usr/local/cuda/include" \
    CUDA_LIBS="-L/usr/local/cuda/lib64" \
    NVENCODE_CFLAGS="-I/usr/local/cuda/include" \
    NVENCODE_LIBS="-L/usr/local/cuda/lib64/stubs"

exec "$@"