#!/bin/bash


# Download tensorflow docker
# sudo docker run --runtime=nvidia -it tensorflow/tensorflow:1.11.0-gpu-py3 /bin/bash 

# Copy files from docker container to host
# docker container cp 7b1d9d:/usr/lib/x86_64-linux-gnu/libcudnn.so.7.2.1 .

# Launch jupyter notebook in docker container
# sudo docker run --runtime=nvidia -it -p 8888:8888 tensorflow/tensorflow:1.11.0-gpu-py3
