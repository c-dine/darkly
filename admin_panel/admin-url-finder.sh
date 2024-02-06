#!/bin/bash
url_value='http://192.168.59.3'
file_path="./admin_panel/admin-urls-list.txt"

if [ -e "$file_path" ]; then
    
    exec 3< "$file_path"

    found_password=false
    while read -r line <&3 && [ "$found_password" = false ]; do
        # echo "Processing line: $line"
        # result_string="${$line/\{\}/$url_value}"
        url=`echo $line | sed "s#{}#$url_value#g"`;
        response=$(curl "$url")
        if ! echo "$response" | grep "/images/404.jpg"; then
            found_password=true
        fi
    done

    exec 3<&-
else
    echo "File not found: $file_path"
fi