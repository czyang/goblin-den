#!/bin/sh

output_folder="/var/www/codingmelody.com/public_html"
input_folder="/root/code/goblin-den" # change it to the goblin-den path
check_interval=300 # check every 5 minutes

previous_hash=$(git rev-parse HEAD)

build_website() {
    goblin -posts="./posts" -template="$input_folder/tmpl" -output="$output_folder" -config="$input_folder/config.json"
    cp "$input_folder/index.html" "$input_folder/main.css" "$input_folder/about.html" "$output_folder"
    cp -R "$input_folder/image" "$output_folder"
}

# Initial run
build_website

while true
do
    git pull
    current_hash=$(git rev-parse HEAD)

    if [ "$previous_hash" != "$current_hash" ]; then
        echo "New changes detected, rebuilding..."
        build_website
        previous_hash="$current_hash"
    fi

    sleep $check_interval
done