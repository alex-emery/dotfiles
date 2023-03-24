#!/bin/bash
RELEASE=$(curl -sLl \
  -H "accept: application/vnd.github+json" \
  -H "x-github-api-version: 2022-11-28" \
  https://api.github.com/repos/alacritty/alacritty/releases)

AVAILABLE=$(echo ${RELEASE} | jq '.[0].tag_name')

CURRENT=$(/Applications/Alacritty.app/Contents/MacOS/alacritty --version | cut -d ' ' -f 2)

if [[ ${AVAILABLE} == \"v${CURRENT}\" ]]; then
  echo "latest version ${AVAILABLE} already found"
  echo "exiting"
  exit
fi

echo "Downloading latest ${AVAILABLE}"

DOWNLOAD_URL=$(echo ${RELEASE} | jq '.[0].assets[] | select(.name | endswith(".dmg")) | .browser_download_url' | tr -d '"')

echo ${DOWNLOAD_URL}
OUTFILE=${HOME}/Downloads/$(basename ${DOWNLOAD_URL})

curl -L ${DOWNLOAD_URL} -o ${OUTFILE}

open ${OUTFILE}
