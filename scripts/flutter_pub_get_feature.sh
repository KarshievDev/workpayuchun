#!/bin/bash

# Define the base path
BASE_PATH="packages/feature"
if [ ! -d "$BASE_PATH" ]; then
    BASE_PATH="../packages/feature"
fi

DIRECTORIES=("face" "location_track" "qr_attendance" "selfie_attendance" "video_chat")

echo "-----------------------------------------------------"
echo "Getting dependencies for packages in $BASE_PATH"
echo "-----------------------------------------------------"

# Traverse the specified directories and run flutter pub get
for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$BASE_PATH/$dir" ]; then
        echo "Getting dependencies for: $dir"
        echo "-----------------------------------------------------"
        (cd "$BASE_PATH/$dir" && fvm flutter pub get)
        echo "-----------------------------------------------------"
    else
        echo "Directory $BASE_PATH/$dir does not exist."
        echo "-----------------------------------------------------"
    fi
done

echo "All dependencies have been fetched."
