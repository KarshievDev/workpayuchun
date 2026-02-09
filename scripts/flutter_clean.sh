#!/bin/bash

# Define the base path
BASE_PATH="packages"
if [ ! -d "$BASE_PATH" ]; then
    BASE_PATH="../packages"
fi



# Define the directories to traverse
DIRECTORIES=("core" "data" "domain" "hrm_framework" "presentation")

# Function to recursively find Flutter projects and run flutter clean
clean_flutter_projects() {
    local dir=$1

    # Check if the directory contains a Flutter project (pubspec.yaml)
    if [ -f "$dir/pubspec.yaml" ]; then
        echo "Running flutter clean in $dir"
        (cd "$dir" && fvm flutter clean)
    fi

    # Traverse subdirectories
    for subdir in "$dir"/*/; do
        if [ -d "$subdir" ]; then
            clean_flutter_projects "$subdir"
        fi
    done
}

# Traverse the specified directories
for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$BASE_PATH/$dir" ]; then
        clean_flutter_projects "$BASE_PATH/$dir"
    else
        echo "Directory $BASE_PATH/$dir does not exist."
    fi
done

echo "Cleaning complete."
