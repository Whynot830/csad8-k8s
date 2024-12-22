#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

ENV_FILE="$SCRIPT_DIR/.env"
SECRET_FILE="$SCRIPT_DIR/.secret.env"
DEPLOYMENT_FILE="$SCRIPT_DIR/deployment.yml"
CONFIGMAP_NAME="composer-service-config"
SECRET_NAME="composer-service-secrets"
NAMESPACE="default"

if [ ! -f "$SCRIPT_DIR/.env" ]; then
  echo -e "---\nFATAL: service env file '$ENV_FILE' not found!\n---"
  exit 1
fi

if [ ! -f "$SCRIPT_DIR/.secret.env" ]; then
  echo -e "---\nFATAL: secrets env file '$SECRET_FILE' not found!\n---"
  exit 1
fi

if [ ! -f "$SCRIPT_DIR/deployment.yml" ]; then
  echo -e "---\nFATAL: deployment file '$DEPLOYMENT_FILE' not found!\n---"
  exit 1
fi

echo "Creating ConfigMap from $(basename "$ENV_FILE")..."
kubectl create configmap $CONFIGMAP_NAME --from-env-file=$ENV_FILE --namespace=$NAMESPACE -o yaml --dry-run=client | kubectl apply -f -

echo -e "\nCreating Secret from $(basename "$SECRET_FILE")..."
kubectl create secret generic $SECRET_NAME --from-env-file=$SECRET_FILE --namespace=$NAMESPACE -o yaml --dry-run=client | kubectl apply -f -

echo -e "\nApplying $(basename "$DEPLOYMENT_FILE")..."
kubectl apply -f $DEPLOYMENT_FILE

echo -e "Done!\n"


