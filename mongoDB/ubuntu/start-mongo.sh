#!/bin/bash

runuser -l mongodb -c 'mongod --bind_ip 0.0.0.0' &