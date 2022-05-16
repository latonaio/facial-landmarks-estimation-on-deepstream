FROM nvcr.io/nvidia/deepstream-l4t:6.0.1-samples
RUN mkdir -p /app/src /app/mnt
WORKDIR /app/src
RUN git clone https://github.com/NVIDIA-AI-IOT/deepstream_tao_apps.git
WORKDIR /app/src/deepstream_tao_apps/
RUN bash download_models.sh
CMD bash
