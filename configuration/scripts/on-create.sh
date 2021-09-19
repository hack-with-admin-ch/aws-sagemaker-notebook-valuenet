#!/bin/bash

set -e

# see https://github.com/aws-samples/amazon-sagemaker-notebook-instance-lifecycle-config-samples/tree/master/scripts/persistent-conda-ebs

# OVERVIEW
# This script installs a custom, persistent installation of conda on the Notebook Instance's EBS volume, and ensures
# that these custom environments are available as kernels in Jupyter.
# 
# The on-create script downloads and installs a custom conda installation to the EBS volume via Miniconda. Any relevant
# packages can be installed here.
#   1. ipykernel is installed to ensure that the custom environment can be used as a Jupyter kernel   
#   2. Ensure the Notebook Instance has internet connectivity to download the Miniconda installer


sudo -u ec2-user -i <<'EOF'
unset SUDO_UID

echo "Install a separate conda installation via Miniconda"
WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda
mkdir -p "$WORKING_DIR"
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda" 
rm -rf "$WORKING_DIR/miniconda.sh"


echo "Create a custom conda environment"
source "$WORKING_DIR/miniconda/bin/activate"
KERNEL_NAME="valuenet"
PYTHON="3.8"

conda create --yes --name "$KERNEL_NAME" python="$PYTHON"
conda activate "$KERNEL_NAME"

pip install --no-input ipykernel

# this takes too long. thus we have to install these later
# echo "Customize these lines as necessary to install the required packages"
# echo "conda install"
# conda install --yes -c anaconda numpy pytorch torchvision spacy # torchaudio 
# echo "pip install"
# pip install --no-input torchaudio pytictoc nltk tqdm pattern transformers wandb pyyaml word2number tensorboard
# echo "done"

EOF