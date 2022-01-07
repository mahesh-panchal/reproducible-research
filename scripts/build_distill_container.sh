#! /usr/bin/env bash

# First parameter is the image name
IMG_NAME=${1:-'rocker/distill:4.1.2'}

# Build an ephemeral container based on Rocker-verse with the distill package installed.
docker run --name rocker_distill \
    rocker/verse:4.1.2 Rscript -e 'install.packages("distill")'
docker commit -m "Add Distill package" rocker_distill "$IMG_NAME"
docker rm rocker_distill
