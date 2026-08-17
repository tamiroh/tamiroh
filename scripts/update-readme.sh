#!/usr/bin/env bash

set -euo pipefail

{
  echo '```text'
  awk -v seed="$((RANDOM * 32768 + RANDOM))" '
    BEGIN {
      srand(seed)
      ramp = " .:-=+*#%@"
      kind = int(rand() * 3)
      fx = 0.1 + rand() * 0.5
      fy = 0.1 + rand() * 0.5
      phase = rand() * 6.283
      cx = rand() * 72
      cy = rand() * 20
      for (y = 0; y < 20; y++) {
        line = ""
        for (x = 0; x < 72; x++) {
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
        print line
      }
    }
  '
  echo '```'
} > README.md
