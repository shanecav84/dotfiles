#!/usr/bin/env zsh

after="$1"
before="$2"

git log \
  --all \
  --after="${after} 00:00:00" \
  --before="${before} 00:00:00" \
  --author="Cavanaugh"