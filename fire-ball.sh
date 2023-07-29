#!/bin/sh

output_folder="/var/www/codingmelody.com/public_html"
input_folder="."
check_interval=300 # check every 5 minutes

previous_hash=$(git rev-parse HEAD)

# Initial run
goblin -posts="./posts" -template="$input_folder/tmpl" -output="$output_folder"

while true
do
    git pull
    current_hash=$(git rev-parse HEAD)

    if [ "$previous_hash" != "$current_hash" ]; then
        echo "New changes detected, rebuilding..."
        goblin -posts="./posts" -template="$input_folder/tmpl" -output="$output_folder"
        previous_hash="$current_hash"
    fi

    sleep $check_interval
done