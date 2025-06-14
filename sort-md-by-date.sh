#!/bin/bash

find _posts -type f -name '*.md' \
  -exec awk '/^date:/ {
    gsub(/^_posts\//, "", FILENAME); 
    printf "%s %s  | %s\n", $2, $3, FILENAME; 
    exit
  }' {} \; \
  | sort


