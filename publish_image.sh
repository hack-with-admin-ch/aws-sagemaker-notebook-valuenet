#!/usr/bin/env bash

BUILD_NAME=hackzurich2021

if [ $# -ne 2 ]
  then
    echo 'Synopsis: publish_image.sh <source-tag> <destination-tag>'
    exit 1
fi

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 907390762462.dkr.ecr.eu-central-1.amazonaws.com

docker tag "$BUILD_NAME:$1" "907390762462.dkr.ecr.eu-central-1.amazonaws.com/$BUILD_NAME:$2"

docker push "907390762462.dkr.ecr.eu-central-1.amazonaws.com/$BUILD_NAME:$2"
