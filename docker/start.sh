#!/bin/sh
docker run --net host --gpus all --rm -v $(pwd)/..:/src \
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -e DISPLAY=$DISPLAY \
                -h $(hostname) \
                -v $HOME/.Xauthority:/home/developer/.Xauthority \
                -v /media/$USER:/media/developer \
                -it infotainment
