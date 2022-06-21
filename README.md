# Docker Lambda Base Image Repository
<!-- ![aws build status]() -->

### **Description**:
This repository is to define the image to be used for the development environments (vscode `.devcontainers`) as well as the base container for the lambda functions. It includes all needed packages for development.

This container is built and pushed to the public repo ECR automatically by AWS Codebuild.


### **Base Image**: Ubuntu 20.04 ([public.ecr.aws/lts/ubuntu:20.04_stable](https://gallery.ecr.aws/lts/ubuntu))

### **ECR Repo:** Docker Lambda Base Image [public.ecr.aws/w5r9l1c8/swsoc-docker-lambda-base:latest](https://gallery.ecr.aws/w5r9l1c8/swsoc-docker-lambda-base)

### **Included OS Packages:**
- git
- make
- curl
- python3.8
- python3-pip
- python3.8-dev
- pylint

### **Included Python Packages:**
- numpy (v1.16.0)
- astropy (v4.1.0)
- awslambdaric (For use with interfacing with aws lambda)
- sunpy
- flake8 (For code style)
- black (For code style)
- tox
- pytest (For testing)
- pytest-astropy (For testing)
- pytest-cov (For testing)
- pre-commit
- sphinx (For documentation)
- sphinx-automodapi (For documentation)
- sphinx-changelog (for changelog in documentation)
- towncrier (For building changelog for documentation)
- ipython (For easier debugging)
- hermes_core (Custom Hermes Core Package)

### **Tests:**
Checks whether the container contains the specified OS and Python requirements using the Container Structure Test ([CST testing suite](https://github.com/GoogleContainerTools/container-structure-test)). 

### **Development Environment Troubleshooting:**
If you experience any issues in your development environment (`.devcontainer` environment on VSCode) when pulling this image from ECR, ensure you have the latest build by rebuilding your container to pull from latest.



