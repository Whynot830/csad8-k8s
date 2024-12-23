#!/bin/bash

# Define the paths to the deploy scripts
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")


deploy_scripts=(
  "${SCRIPT_DIR}/composer-service/deploy.sh"
  "${SCRIPT_DIR}/crud-services/deploy.sh"
  "${SCRIPT_DIR}/service-discovery/deploy.sh"
)

echo -e "###\nNOTE: Remember to reference all your ConfigMaps and Secrets in deployment YAMLs\n###\n"


for script in "${deploy_scripts[@]}"; do
  if [ -f "$script" ]; then
    echo -e "---\nRunning $script...\n---"
    bash "$script"
    echo -e "$script completed successfully."
  else
    echo -e "---\nFATAL: $script not found!\n---"
    exit 1
  fi
done

echo -e "---\nDone: all scripts have been executed\n---"
