BUILD_NAME=hackzurich2021
VERSION=latest
VALUENET_PATH=../valuenet
DATA_FOLDER=data/hack_zurich
MODELS_FOLDER=models

.PHONY:build-image
build-image:
	cp -r $(VALUENET_PATH)/$(DATA_FOLDER) $(DATA_FOLDER) \
	&& cp -r $(VALUENET_PATH)/$(MODELS_FOLDER) $(MODELS_FOLDER) \
	&& docker build \
		--no-cache \
		--tag $(BUILD_NAME):$(VERSION) \
		--build-arg VALUENET_PATH=$(VALUENET_PATH) \
		.
