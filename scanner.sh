#!/usr/bin/env bash

include="$1"
exclude="$2"
regex="$3"

if [[ -z "${include}" ]] || [[ -z "${exclude}" ]] || [[ -z "${regex}" ]]
then
  echo "Exiting... variables not specified"
  exit 0
fi
  echo "Include patterns variable is set: " "${include}"
  echo
  echo "Exclude patterns variable is set: " "${exclude}"
  echo
  echo "Regex file variable is set: " "${regex}"

echo "Installing trufflehog..."
pip3 install trufflehog --user
# Create an empty file to store trufflehog output
# echo "Creating secrets.json to store output"
# touch secrets.json
# chmod 644 secrets.json
$(which trufflehog) --include_paths "${include}" \
--exclude_paths "${exclude}" --rules "${regex}" \
--json file:"//$PWD"

RESULT="$?"

# check result of trufflehog
if [ "$RESULT" != "0" ]; then
    echo -e "trufflehog has found some secrets" $RESULT
else
    echo "No secrets found in this repository"
fi
