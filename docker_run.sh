 docker run --runtime=nvidia -ti -v $(pwd):/home/gst --network=host -v /dev/snd:/dev/snd \
    --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    --cap-add=SYS_PTRACE --name gst gst-nvidia-video