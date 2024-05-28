#!/bin/bash

docker run --gpus all -ti --rm \
	-v $(pwd):/cwd \
	-v $(pwd)/weights/pretrained/huggingface:/root/.cache/huggingface \
	-p 12345:8888 internvideo jupyter notebook --allow-root --ip=0.0.0.0


