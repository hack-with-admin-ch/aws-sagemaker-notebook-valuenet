#!/bin/bash

set -e

# install mysql postgres dependencies
yum -y install mysql-devel postgresql-devel

# OVERVIEW
# This script installs a custom, persistent installation of conda on the Notebook Instance's EBS volume, and ensures
# that these custom environments are available as kernels in Jupyter.
# 
# The on-start script uses the custom conda environment created in the on-create script and uses the ipykernel package
# to add that as a kernel in Jupyter.
#
# For another example, see:
# https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-add-external.html#nbi-isolated-environment

sudo -u ec2-user -i <<'EOF'
unset SUDO_UID

WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda/
source "$WORKING_DIR/miniconda/bin/activate"

for env in $WORKING_DIR/miniconda/envs/*; do
    BASENAME=$(basename "$env")
    source activate "$BASENAME"
    echo "Install kernel $BASENAME"
    python -m ipykernel install --user --name "$BASENAME" --display-name "Custom ($BASENAME)"
done

echo "Kernel installation done"

# Optionally, uncomment these lines to disable SageMaker-provided Conda functionality.
# echo "c.EnvironmentKernelSpecManager.use_conda_directly = False" >> /home/ec2-user/.jupyter/jupyter_notebook_config.py
# rm /home/ec2-user/.condarc
EOF

echo "write sagemaker-valuenet-environment to jupyter-env"
aws secretsmanager get-secret-value --secret-id sagemaker-valuenet-environment | jq -r '.SecretString' >> /etc/profile.d/jupyter-env.sh

echo "Restarting the Jupyter server.."
# this does not work on Amazon Linux 2
# restart jupyter-server
service jupyter-server restart

echo "Jupyter server restarted"
