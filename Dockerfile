FROM nvidia/video-codec-sdk:8.2-ubuntu18.04

RUN apt-get update && apt-get install -y \
    libgstreamer1.0-0 gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly gstreamer1.0-libav \
    gstreamer1.0-doc gstreamer1.0-tools \
    gstreamer1.0-x gstreamer1.0-alsa \
    gstreamer1.0-gl gstreamer1.0-gtk3 \
    gstreamer1.0-qt5 gstreamer1.0-pulseaudio

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils build-essential sudo git \
    gtk-doc-tools

# RUN apt-get install -y libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev \
#     libfontconfig1-dev libfreetype6-dev libpng-dev \
#     libcairo2-dev libjpeg-dev libgif-dev \
#     libgstreamer-plugins-base1.0-dev

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

CMD ["bash"]
