#!/bin/sh

command -v lame >/dev/null 2>&1 || { echo >&2 "Re-encoding requires LAME on the PATH."; exit 1; }

for file in *.mp3
do
  lame ${file} ${file%%mp3}fixed.mp3
  mv ${file} ${file%%mp3}bak
  mv ${file%%mp3}fixed.mp3 ${file}
done
