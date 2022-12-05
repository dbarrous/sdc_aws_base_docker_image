# Image: Ubuntu 20.04 Stable, Official Image from Canonical
FROM public.ecr.aws/lts/ubuntu:20.04_stable

# Performs updates and installs git, make, curl, python3.8, python3-pip, python3.8-dev and pylint packages
# Line 13 is required by the spacepy Python package
# Line >=14 installs cdflib
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends -y python3.8 python3-pip python3.8-dev pylint && \
    apt-get -y install git && \
    apt-get -y install make && \
    apt-get -y install curl && \
    apt-get -y install wget && \
    apt-get -y install gfortran && \
    wget https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/cdf38_0-dist-cdf.tar.gz && \
    tar zxvpf cdf38_0-dist-cdf.tar.gz && rm cdf38_0-dist-cdf.tar.gz && \
    apt-get -y install libncurses5-dev && \
    apt-get -y install gcc && \
    cd cdf38_0-dist && \
    make OS=linux ENV=gnu all && \
    make INSTALLDIR=/usr/local/cdf install && \
    cd ..

# add cdf binaries to the path
ENV PATH="${PATH}:/usr/local/cdf/bin"

# Copy Python requirements.txt file into image (list of common dependencies)
COPY requirements.txt  .

# Copy test scripts
COPY /container-tests  /container-tests

# To fix spacepy dependency issue
RUN  pip3 install --upgrade --force-reinstall setuptools==59.5.0

# Install Python dependencies defined in requirements
RUN  pip install -r requirements.txt

# User to run the container
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # Add sudo support for the non-root user
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
