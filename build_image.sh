#!/usr/bin/env bash

if [ $# -ne 1 ]
  then
    echo 'Synopsis: build_image.sh <experiments_folder>'
    exit 1
fi

BUILD_NAME=hackzurich2021
VERSION=latest
VALUENET_PATH=../valuenet
DATA_FOLDER=data/hack_zurich
MODELS_FOLDER=models

mkdir -p data
cp -r "$VALUENET_PATH/$DATA_FOLDER" $DATA_FOLDER
cp -r $1 $MODELS_FOLDER
docker build \
    --no-cache \
    --tag "$BUILD_NAME:$VERSION" \
    --build-arg VALUENET_PATH="$VALUENET_PATH" \
    .
