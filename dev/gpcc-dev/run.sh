#!/bin/bash -eu

PWD=$(pwd)

BASE_DIR=$PWD/../../../

docker run -dit --volume=$BASE_DIR:/go/src --name=dev dev
