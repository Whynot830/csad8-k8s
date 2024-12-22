#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
DEPLOYMENT_FILE="${SCRIPT_DIR}/deployment.yml"

if [ ! -f "$DEPLOYMENT_FILE" ]; then
  echo -e "---\nFATAL: deployment file '$DEPLOYMENT_FILE' not found!\n---"
  exit 1
fi

echo -e "Applying $(basename "$DEPLOYMENT_FILE")..."
kubectl apply -f $DEPLOYMENT_FILE

echo "Done!"