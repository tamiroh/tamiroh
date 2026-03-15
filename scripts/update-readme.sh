#!/usr/bin/env bash

set -euo pipefail

timestamp="$(TZ=Asia/Tokyo date "+%Y/%m/%d %H:%M")"
art="$(printf '%s\n' "$timestamp" | figlet -w 200)"

{
  echo '```text'
  printf '%s\n' "$art"
  echo '```'
} > README.md
