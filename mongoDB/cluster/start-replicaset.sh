#!/bin/bash

mongod --config /mongo/config/mongo.conf &

echo "Mongodb started"

sleep 25

echo "going create replicaset"

mongo --tls --tlsAllowInvalidCertificates mongo1:27017 < /mongo/config/rsdeploy.js

sleep 15

echo "Add arbiter"

mongo --tls --tlsAllowInvalidCertificates mongo1:27017 --eval 'rs.addArb("mongo4:30000")'

echo "Start main process"

while sleep 1000; do :; done
