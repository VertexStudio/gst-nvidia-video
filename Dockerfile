
ARG UBUNTU_VERSION=18.04

FROM nvidia/cudagl:10.0-devel-ubuntu${UBUNTU_VERSION} as base

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential sudo git \
    autoconf automake libtool autopoint

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=America/Detroit
RUN apt-get update && apt-get install -y tzdata

RUN apt-get install -y --no-install-recommends \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav libgstrtspserver-1.0-dev \
    gtk-doc-tools

RUN apt-get install -y --no-install-recommends \
    libgstreamer1.0-0 gstreamer1.0-libav \
    gstreamer1.0-doc gstreamer1.0-tools \
    gstreamer1.0-x gstreamer1.0-alsa \
    gstreamer1.0-gl gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 gstreamer1.0-pulseaudio

COPY video-codec/lib/linux/stubs/x86_64/* /usr/local/cuda/lib64/stubs/
COPY video-codec/include/* /usr/local/cuda/include/

COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} gst && \
    useradd -m -l -u ${USER_ID} -g gst gst && \
    echo "gst:gst" | chpasswd && adduser gst sudo && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER gst
WORKDIR /home/gst

COPY entrypoint.sh /home/gst

ENTRYPOINT ["./entrypoint.sh", "--"]
CMD ["bash"]