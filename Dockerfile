# Image: Ubuntu 20.04 Stable, Official Image from Canonical 
FROM public.ecr.aws/lts/ubuntu:20.04_stable

# Performs updates and installs git, make, curl, python3.8, python3-pip, python3.8-dev and pylint packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install git && \
    apt-get -y install make && \
    apt-get -y install curl && \
    apt-get -y install --no-install-recommends -y python3.8 python3-pip python3.8-dev pylint

# Copy Python requirements.txt file into image (list of common dependencies)
COPY requirements.txt  .

# For container lambda functions
RUN curl -Lo /usr/local/bin/aws-lambda-rie \
    https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie && \
    chmod +x /usr/local/bin/aws-lambda-rie

# Copy test scripts
COPY /container-tests  /container-tests

# Install Python dependencies defined in requirements
RUN  pip3 install -r requirements.txt
