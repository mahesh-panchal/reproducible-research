#! /usr/bin/env bash

# Build an ephemeral container based on Rocker-verse with the distill package installed.
docker run --name rocker_distill \
    rocker/verse:4.1.2 Rscript -e 'install.packages("distill")'
docker commit -m "Add Distill package" rocker_distill rocker/distill:4.1.2
docker rm rocker_distill
# The docker image is named rocker/distill:4.1.2