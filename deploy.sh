#!/bin/bash

# Define the paths to the deploy scripts
deploy_scripts=(
  "./composer-service/deploy.sh"
  "./crud-services/deploy.sh"
  "./service-discovery/deploy.sh"
)

echo -e "###\nNOTE: Remember to reference all your ConfigMaps and Secrets in deployment YAMLs\n###\n"


for script in "${deploy_scripts[@]}"; do
  if [ -f "$script" ]; then
    echo -e "---\nRunning $script...\n---\n"
    bash "$script"
    echo "$script completed successfully."
  else
    echo -e "---\nFATAL: $script not found!\n---"
    exit 1
  fi
done

echo -e "---\nDone: all scripts executed\n---"
