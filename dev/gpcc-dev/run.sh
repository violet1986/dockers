#!/bin/bash -eu

PWD=$(pwd)

BASE_DIR=$PWD/../../../

docker run -dit --volume=$BASE_DIR:/go/src/gpcc --name=gpcc-dev gpcc-dev
