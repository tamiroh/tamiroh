#!/usr/bin/env bash

set -euo pipefail

current_date="$(TZ=Asia/Tokyo date "+%Y/%m/%d")"
art="$(printf '%s\n' "$current_date" | figlet -w 200)"

{
  echo '```text'
  printf '%s\n' "$art"
  echo '```'
} > README.md
