#!/bin/bash
set -e
hash curl || exit 1
hash jq || exit 2

env_file="$(readlink -f "$(dirname "$0")")/.env"
[ -f "$env_file" ] && source "$env_file"

usage_msg="
Environment (config) file:
    $env_file
Environment variables:
    PORKBUN_DOMAINS -- Comma-separated list of domains
    PORKBUN_API_KEY -- Your API key
    PORKBUN_SECRET_API_KEY -- Your secret API key
    PORKBUN_SSL_DIR -- Path to the certs directory (default: /etc/ssl/porkbun/)
Documentation:
    https://porkbun.com/api/json/v3/documentation#SSL%20Retrieve%20Bundle%20by%20Domain
"
domains="${PORKBUN_DOMAINS?"$usage_msg"}"
apikey="${PORKBUN_API_KEY?"$usage_msg"}"
secret="${PORKBUN_SECRET_API_KEY?"$usage_msg"}"
ssl_dir="${PORKBUN_SSL_DIR:-"/etc/ssl/porkbun/"}"

retrieve_domain() {
    local domain=${1?"Usage: ${FUNCNAME[0]} domain"}
    target_dir="${ssl_dir%%/}/$domain"
    mkdir -p $target_dir
    r="$(\
    curl -Ss \
        -X POST \
        -H "Content-Type: application/json" \
        -d "{\"secretapikey\":\"$secret\",\"apikey\":\"$apikey\"}" \
        https://porkbun.com/api/json/v3/ssl/retrieve/$domain \
    )"
    if [ "$(echo "$r" | jq -r '.status')" == ERROR ]
    then
        echo "$r" | jq
        exit 3
    else
        chain_path="$target_dir/certificatechain.pem"
        echo "$r" | jq -r '.certificatechain' > "$chain_path"
        echo "$chain_path"

        privatekey_path="$target_dir/privatekey.pem"
        echo "$r" | jq -r '.privatekey' > "$privatekey_path"
        echo "$privatekey_path"

        chmod -v 600 "$privatekey_path"
    fi
}

for domain in ${domains//,/ }
do
    echo "--- retrieve_domain $domain"
    retrieve_domain $domain
done

service nginx reload
