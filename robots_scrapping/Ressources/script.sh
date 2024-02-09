#!/bin/bash

check_flag_recursive() {
    local url="$1"

    local html_content=$(curl -s "$url")

    if echo "$html_content" | grep -q "README"; then 
        local readme_file=$(curl -s "${url}README")
        if echo "$readme_file" | grep -q "flag"; then
            echo "Le mot 'flag' a été trouvé dans le fichier README de : $url"
            exit 0
        fi
    fi

    local subdirectories=$(echo "$html_content" | grep -oE 'href="([^"]*)/"' | cut -d'"' -f2 | grep -v '^../$')

    for subdirectory in $subdirectories; do
        local subdirectory_url="${url}${subdirectory}"
        check_flag_recursive "$subdirectory_url"
    done
}

check_flag_recursive "http://192.168.59.3/.hidden/"
