# syntax=docker/dockerfile:1

FROM nvidia/cuda:11.5.1-cudnn8-runtime-ubuntu20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.8 \
    python3-pip \
    && \
    apt-get clean

COPY requirements.txt requirements.txt
COPY notebooks notebooks

RUN pip3 install -r requirements.txt

CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "--notebook-dir", "notebooks"]
