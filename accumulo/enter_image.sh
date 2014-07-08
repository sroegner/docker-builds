#!/bin/bash

ACCUMULO_PID=$(docker inspect --format {{.State.Pid}} accmaster)
sudo nsenter --target $ACCUMULO_PID --mount --uts --ipc --net --pid

