#!/bin/bash

# Specify the path to your file
file_path="./brut_force/password-list.txt"

# Check if the file exists
if [ -e "$file_path" ]; then
    # Open the file for reading
    exec 3< "$file_path"

    # Loop over each line in the file
    while read -r line <&3; do
        # Process each line (replace this with your actual processing)
        echo "Processing line: $line"
    done

    # Close the file descriptor
    exec 3<&-
else
    echo "File not found: $file_path"
fi
