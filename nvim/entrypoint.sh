#!/bin/bash

echo "Hello you"
sudo ssh-keygen -A
sudo /usr/sbin/sshd -D -e