#!/bin/bash

set -e

NAME=test-01
TYPE=ml.p3.2xlarge
VOLUME_SIZE=60

# you might need to upgrade aws cli for platform-identifier --> https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-upgrade
aws sagemaker create-notebook-instance \
    --notebook-instance-name $NAME \
    --instance-type $TYPE \
    --role-arn arn:aws:iam::907390762462:role/service-role/AmazonSageMaker-ExecutionRole-20210914T214861 \
    --volume-size-in-gb $VOLUME_SIZE \
    --default-code-repository notebook \
    --lifecycle-config-name valuenet-kernel-01\
    --platform-identifier notebook-al2-v1


