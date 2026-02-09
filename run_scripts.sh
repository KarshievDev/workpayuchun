#!/bin/bash

# Run flutter_clean_feature.sh
echo "Running flutter_clean.sh"
./scripts/flutter_clean.sh
echo "Running flutter_clean_feature.sh"
./scripts/flutter_clean_feature.sh

# Check if flutter_clean_feature.sh ran successfully
if [ $? -ne 0 ]; then
    echo "flutter_clean.sh encountered an error."
    exit 1
fi

# Run flutter_pub_get.sh
echo "Running flutter_pub_get.sh"
./scripts/flutter_pub_get.sh
echo "Running flutter_pub_get_feature.sh"
./scripts/flutter_pub_get_feature.sh

# Check if flutter_pub_get.sh ran successfully
if [ $? -ne 0 ]; then
    echo "flutter_pub_get.sh encountered an error."
    exit 1
fi

echo "Scripts ran successfully."

