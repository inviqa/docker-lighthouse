#!/bin/bash

set -o nounset
set -o pipefail
set -o errexit

TARGET_URL="${1:-}"

if [ -z "$TARGET_URL" ] || ! [[ "$TARGET_URL" =~ https?:// ]]; then
  echo "Please provide a target URL to run lighthouse against" >&2
  exit 1
fi

echo "Running Lighthouse against URL: ${TARGET_URL}" >&2

lighthouse --no-enable-error-reporting \
           --chrome-flags="--headless --no-sandbox=true --ignore-certificate-errors --disable-dev-shm-usage" \
           --output json \
           --output-path=/home/headless/lighthouse-results.json \
           "${TARGET_URL}" >&2

cat /home/headless/lighthouse-results.json
echo

echo "Success" >&2
