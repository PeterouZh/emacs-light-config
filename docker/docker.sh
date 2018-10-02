#!/bin/bash


# sudo docker run --runtime=nvidia -it --name=tf_1_11 tensorflow/tensorflow:1.11.0-gpu-py3 /bin/bash 

# copy files from docker container to host
# docker container cp 7b1d9d:/usr/lib/x86_64-linux-gnu/libcudnn.so.7.2.1 .

# launch jupyter notebook in docker container
# sudo docker run --runtime=nvidia -it -p 8888:8888 tensorflow/tensorflow:1.11.0-gpu-py3
