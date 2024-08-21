#!/bin/bash



docker run -it --rm \
       -v .:/home/ubuntu/project \
       -v $HOME/.gitconfig:/home/ubuntu/.gitconfig \
       -v $HOME/.ssh:/home/ubuntu/.ssh \
       -v $HOME/mydocs:/home/ubuntu/mydocs \
       -v .:/home/ubuntu/project \
       ghcr.io/ozlevka/astro-nvim:v0.0.1 fish

