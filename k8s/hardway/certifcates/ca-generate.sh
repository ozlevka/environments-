#!/bin/bash

echo "Generate Certificate Authority"
cfssl gencert -initca /workspaces/environments-/k8s/hardway/certifcates/ca-csr.json | cfssljson -bare ca 