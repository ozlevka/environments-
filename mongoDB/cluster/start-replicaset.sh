#!/bin/bash

mongod --config /mongo/config/mongo.conf &

echo "Mongodb started"

sleep 25

echo "going create replicaset"

if [[ -z "$SSH_ENABLED" ]]; then
    mongo  mongo1:27017 < /mongo/config/rsdeploy.js
else
    mongo --tls --tlsAllowInvalidCertificates mongo1:27017 < /mongo/config/rsdeploy.js
fi

sleep 15

echo "Add arbiter"

if [[ -z "$SSH_ENABLED" ]]; then
    mongo mongo1:27017 --eval 'rs.addArb("mongo4:30000")'
else
    mongo --tls --tlsAllowInvalidCertificates mongo1:27017 --eval 'rs.addArb("mongo4:30000")'
fi

echo "Start main process"

while sleep 1000; do :; done
