#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

jenkins_base_url="${jenkins_base_url:-}"
jenkins_auth="${jenkins_auth:-}"

if [[ "$jenkins_base_url" == "" ]] || [[ "$jenkins_auth" == "" ]]; then
  echo "ERROR jenkins_base_url or jenkins_auth is not set" >&2
  exit 1
fi

function extractDescription() {
  perl -0777 -ne 'print if s/^(# .+?)\n##.*/\1/s' "$1" \
    | perl -0777 -pe 's/^# .+\n+//' \
    | perl -0777 -pe 's/([^\n])\n([A-Za-z])/\1 \2/g'
}

function processBadges() {
  perl -pe 's/^\[!\[([^]]+)\]\(([^)]+)\)/[![\1](\2?style=flat-square)/g' \
    | perl -pe 's/^\[!\[([^]]+)\]\(([^?)]+)\?([^?]*)\?([^)]*)\)/[![\1](\2?\3&\4)/g' \
    | perl -0777 -pe 's/^(\[!.+)\n/\1 /mg' \
    | perl -0777 -pe 's/(\w) *\n(\w)/\1 \2/mg' \
    | perl -pe 's/^(\[!.+) $/\1\n/mg'
}

function encodeJobConfigXmlValue() {
  perl -pe 's/</&lt;/g' \
    | perl -pe 's/>/&gt;/g' \
    | perl -pe 's/&/&amp;/g' \
    | perl -pe "s/'/&apos;/g" \
    | perl -0777 -pe "s/\n/\\\n/g"
}

function updateJobConfigDescription() {
  local description
  description=$(echo "$2" | encodeJobConfigXmlValue | sed -E 's#/#\\/#g')
  perl -0777 -i -pe "s/<description>.*?<\/description>/<description>${description//\\\\\\/}<\/description>/s" "$1"
}

function encodeURI() {
  perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1"
}

for f in $(find . -mindepth 2 -maxdepth 2 -type f -name README.md); do
  project=$(basename "$(dirname "$f")")
  description=$(extractDescription "$f" | processBadges)
  if [[ "$description" == "" ]]; then
    echo "skip $project"
    continue
  fi
  config_url="$jenkins_base_url/job/$project/config.xml"
  config_file="/tmp/$project-config.xml"
  set +e
  curl -sSL --fail --show-error -u "$jenkins_auth" "$config_url" >"$config_file"
  set -e
  if [[ -s "$config_file" ]]; then
    echo -n "update $project .. "
    updateJobConfigDescription "$config_file" "$description"
#    curl -sSL -u "$jenkins_auth" "$config_url" \
#      -H 'Content-Type: application/xml' \
#      --data-binary "@$config_file"
    curl -sSL --fail --show-error -u "$jenkins_auth" "$jenkins_base_url/job/$project/submitDescription" \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      --data-raw "description=$(encodeURI "$description")&Submit=Save" >/dev/null
    echo "ok"
  else
    echo "skip $project"
  fi
  rm "$config_file"
done
