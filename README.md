# aws-sagemaker-notebook-valuenet

This repository containes configuration files and notebooks to run [Valuenet](https://github.com/brunnurs/valuenet) codebase in AWS Sagemaker.

## Configuration

In the folder configuration/scripts, you can find the script to prepare the instance.

- aws-cli-create-instance.sh: creates the instance
- on-create.sh: lifecycle configuration file to initialise notebooks
- on-start.sh: lifecycle configuration file to start notebooks

More information is available [here](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).

## Notebooks

There are then 3 notebooks:

- setup.ipynb:

  This notebook prepares the environemnt to run the codebase, installs all required pip libraries and validate the the gpu is available

- preprocess_custom_data-01.ipynb:

  This notebook prepares the custom data. If you generate some custom data (with the help of [question query generation](https://github.com/statistikZH/statbot/blob/main/hackathon_hackzurich/generate_sql_statments_and_questions.ipynb) for instance), this notebooks takes you through the preprocessing steps to be ready to train.

- train-01.ipynb:

  This notebooks is responsible for the training part. Make sure to run [preprocess_custom_data-01.ipynb](https://github.com/hack-with-admin-ch/aws-sagemaker-notebook-valuenet/blob/main/preprocess_custom_data-01.ipynb) first if you use custom data. It then guides through the options and steps to train a model from scratch or pre-trained and to train on spider dataset or with your custom data.

## Publish the docker image

1. Run `make build-image` to build the image with your data
2. Run `./publish_image.sh latest <your-target-tag>` (eg. `1.0.0` or  `20210923_212235`)
