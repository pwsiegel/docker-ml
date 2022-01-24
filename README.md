# Machine learning with docker

The purpose of this repostory is experiment with training, testing, and deploying deep learning models using docker containers.

## Pytorch + CUDA

GPU accellation via the NVIDIA's CUDA library can greatly increase the performance for both training and inference for deep learning models.
This repository demonstrates how to run GPU-enabled Pytorch inside a Docker container.

### Machine setup

In order for any of this to be possible, you need access to a machine with a NVIDIA graphics card.
This could be your local machine, or it could be cloud hardware.
This machine needs the following installed correctly:

1. The correct NVIDIA drivers: most operating systems will come with tools to help you update your drivers, but you can always download them directly from [NVIDIA's website](https://www.nvidia.com/download/index.aspx?lang=en-us)

2. The Docker engine, together with the NVIDIA container toolkit: see [Docker's documentation](https://docs.docker.com/get-docker/) and the [NVIDIA container toolkit guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

3. The CUDA library: refer to [NVIDIA's guide](https://docs.nvidia.com/cuda/cuda-quick-start-guide/index.html) for detailed instructions

Strictly speaking, you don't actually need to install CUDA on the host in order to run it in a container.
However, it is important for the version of CUDA running in the container to be compatible with the drivers installed on the host, and the easiest way to ensure this is to just install CUDA on the host and make sure everything is working.

This has the added advantage that it will allow you to run GPU-enabled Pytorch in your local enviornment as well as inside a container, though if you want to do this then you should also install the [cuDNN library](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html).

### Create a docker image

The next step is to create a docker image with CUDA, cuDNN, Python, and Pytorch installed.
I recommend starting with an NVIDIA base image which includes the desired versions of CUDA, cuDNN, and the OS - as above, the key thing is that all of this is compatible with the NVIDIA drivers installed on the host machine.

From there the image just needs to install Python3 and any desired Python packages, including Pytorch.
The Dockerfile in this repository also runs a Jupyter server inside the container.

### Build and run the container

Build the container using the usual command:

`docker build --tag my-container .`

To run the container, make sure to use the flag `--gpus all` in order to ensure that GPU support is actually accessible in the container.
If you would like to interact with the container using Jupyter, make sure to run the container interactively using the `-it` flag and to expose the correct port using the `-p` flag:

`docker run --gpus all -it -p 8888:8888 my-container:latest`

If everything is configured correctly, then the line `torch.cuda.is_available()` in the notebook `docker-cuda-test.ipynb` will return `True`.
