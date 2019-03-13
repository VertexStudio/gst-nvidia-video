

```
gst-launch-1.0 videotestsrc ! autovideosink
gst-launch-1.0 videotestsrc ! nvh264enc ! fakesink
```

```
./autogen.sh --noconfigure

./configure \
    --libdir=/usr/lib/x86_64-linux-gnu/gstreamer-1.0 \
    CUDA_CFLAGS="-I/usr/local/cuda/include" \
    CUDA_LIBS="-L/usr/local/cuda/lib64" \
    NVENCODE_CFLAGS="-I/usr/local/cuda/include" \
    NVENCODE_LIBS="-L/usr/local/cuda/lib64/stubs"
```


