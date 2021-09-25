FROM ursinbrunner/valuenet-inference-hack-zurich:1.0

ARG VALUENET_PATH

COPY data/hack_zurich /workspace/data/hack_zurich
COPY models /workspace/models
