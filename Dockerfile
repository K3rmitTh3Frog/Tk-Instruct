FROM python:3.11
FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel
FROM ubuntu:20.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV CUDA_HOME=/usr/local/cuda/

RUN apt-get -y update
RUN apt-get -y install git vim 


RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y gnupg
RUN apt-get update && apt-get install -y git vim
RUN apt-get update && apt-get install -y python3

RUN apt-get update && apt-get install --reinstall -y python3-pip python3-setuptools python3-wheel

RUN apt-get update && apt-get install -y \
    git \
    vim

RUN wget -O cuda_repo_key.pub https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-key add cuda_repo_key.pub


RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get -y install git-lfs

WORKDIR /stage/


COPY requirements.txt .

RUN install -r requirements.txt
RUN python -c "import nltk; nltk.download('punkt', quiet=True)"

COPY ds_configs ds_configs

COPY src src
COPY scripts scripts
RUN chmod +x scripts/*

# for interactive session
RUN chmod -R 777 /stage/