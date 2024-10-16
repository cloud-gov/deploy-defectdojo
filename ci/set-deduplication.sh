#!/bin/bash

# Send GET request for user profile

curl -sS -X GET ${DEFECTDOJO_SYSTEM_SETTINGS_URL} \
  -H "accept: application/json" \
  -H "Authorization: Token $DEFECTDOJO_AUTH_TOKEN" > response.json

deduplication_status=$(cat response.json | jq '.results[].enable_deduplication')

if [[ $deduplication_status != "true" ]]; then
  echo "deduplication is off"
  echo "turning deduplication on"
  curl -sS -X PATCH ${DEFECTDOJO_SYSTEM_SETTINGS_URL}1/ \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -H "Authorization: Token $DEFECTDOJO_AUTH_TOKEN" \
  -d '{"enable_deduplication": true}' > result.json

  deduplication_status=$(cat result.json | jq '.enable_deduplication')
  if [[ $deduplication_status != "true" ]]; then
    echo "error turning deduplication on"
    exit 1;
  fi
fi

echo "deduplication is on"
