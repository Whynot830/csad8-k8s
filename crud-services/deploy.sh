#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
NAMESPACE="default"

for SERVICE_DIR in "$SCRIPT_DIR"/*; do
  if [ -d "$SERVICE_DIR" ]; then
    SERVICE_NAME=$(basename "$SERVICE_DIR")

    echo -e "Started processing $SERVICE_NAME\n"

    SVC_CONFIGMAP_NAME="${SERVICE_NAME}-config"
    SVC_SECRET_FILE="${SERVICE_DIR}/.svc-secret.env"
    SVC_SECRET_NAME="${SERVICE_NAME}-secret"
    SVC_ENV_FILE="${SERVICE_DIR}/.env"
    SVC_DEPLOYMENT_FILE="${SERVICE_DIR}/deployment.yml"
    
    DB_SECRET_FILE="${SERVICE_DIR}/.db-secret.env"
    DB_SECRET_NAME="${SERVICE_NAME}-db-secret"
    DB_DEPLOYMENT_FILE="${SERVICE_DIR}/db.yml"

    if [ ! -f "$SVC_ENV_FILE" ]; then
      echo -e "---\nFATAL: service env file '$SVC_ENV_FILE' not found!\n---"
      exit 1
    fi

    if [ ! -f "$SVC_SECRET_FILE" ]; then
      echo -e "---\nFATAL: service secrets file '$SVC_SECRET_FILE' not found!\n---"
      exit 1
    fi

    if [ ! -f "$DB_SECRET_FILE" ]; then
      echo -e "---\nFATAL: DB secrets file '$DB_SECRET_FILE' not found!\n---"
      exit 1
    fi

    if [ ! -f "$SVC_DEPLOYMENT_FILE" ]; then
      echo -e "---\nFATAL: deployment file '$SVC_DEPLOYMENT_FILE' not found!\n---"
      exit 1
    fi

    if [ ! -f "$DB_DEPLOYMENT_FILE" ]; then
      echo -e "---\nFATAL: DB deployment file '$DB_DEPLOYMENT_FILE' not found!\n---"
      exit 1
    fi

    echo "Creating ConfigMap $SVC_CONFIGMAP_NAME from $(basename "$SVC_ENV_FILE")..."
    kubectl create configmap "$SVC_CONFIGMAP_NAME" --from-env-file="$SVC_ENV_FILE" --namespace="$NAMESPACE" -o yaml --dry-run=client | kubectl apply -f -

    echo -e "\nCreating Secret $SVC_SECRET_NAME from $(basename "$SVC_SECRET_FILE")..."
    kubectl create secret generic "$SVC_SECRET_NAME" --from-env-file="$SVC_SECRET_FILE" --namespace="$NAMESPACE" -o yaml --dry-run=client | kubectl apply -f -

    echo -e "\nCreating Secret $DB_SECRET_NAME from $(basename "$DB_SECRET_FILE")..."
    kubectl create secret generic "$DB_SECRET_NAME" --from-env-file="$DB_SECRET_FILE" --namespace="$NAMESPACE" -o yaml --dry-run=client | kubectl apply -f -

    echo -e "\nApplying DB Deployment: $(basename "$DB_DEPLOYMENT_FILE")..."
    kubectl apply -f "$DB_DEPLOYMENT_FILE"

    echo -e "\nApplying Service Deployment: $(basename "$SVC_DEPLOYMENT_FILE")..."
    kubectl apply -f "$SVC_DEPLOYMENT_FILE"

    echo -e "\nFinished processing $SERVICE_NAME\n"
  fi
done

echo "Done!"