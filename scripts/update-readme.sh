#!/usr/bin/env bash

set -euo pipefail

{
  echo '<pre>'
  awk -v seed="$((RANDOM * 32768 + RANDOM))" -v url="https://tamiroh.github.io/" '
    function linkify(s,   st, len, seg, tries) {
      for (tries = 0; tries < 32; tries++) {
        len = 4 + int(rand() * 9)
        st = 1 + int(rand() * (length(s) - len + 1))
        seg = substr(s, st, len)
        if (seg ~ /[^ ]/)
          break
      }
      return substr(s, 1, st - 1) "<a href=\"" url "\">" seg "</a>" substr(s, st + len)
    }
    BEGIN {
      srand(seed)
      ramp = " .:-=+*#%@"
      kind = int(rand() * 3)
      fx = 0.1 + rand() * 0.5
      fy = 0.1 + rand() * 0.5
      phase = rand() * 6.283
      w = 112
      h = 8
      cx = rand() * w
      cy = rand() * h
      links = 1 + int(rand() * 3)
      for (i = 0; i < links; i++) {
        do
          ly = int(rand() * h)
        while (ly in linked)
        linked[ly] = 1
      }
      for (y = 0; y < h; y++) {
        line = ""
        for (x = 0; x < w; x++) {
          if (kind == 0) {
            line = line (rand() < 0.5 ? "/" : "\\")
            continue
          }
          if (kind == 1)
            v = sin(x * fx + phase) + sin(y * 2 * fy)
          else {
            dx = x - cx
            dy = (y - cy) * 2
            v = 2 * sin(sqrt(dx * dx + dy * dy) * fx)
          }
          line = line substr(ramp, int((v + 2) / 4 * 9) + 1, 1)
        }
        print (y in linked) ? linkify(line) : line
      }
    }
  '
  echo '</pre>'
} > README.md
