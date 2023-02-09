#!/bin/sh

for f in "$@"
do
  is_first_line=1
  has_error=0
  find "$f" -type f \( -name "*.c" -o -name "*.h" \) | while read -r file; do
    OUTPUT="$(
      ${NORMINETTE-norminette} "$file" | while read -r line; do
        if [ $is_first_line -eq 1 ]; then
          is_first_line=0
          continue
        fi
        for rule in $RULES_TO_SUPPRESS
        do
          line=$(echo "$line" | sed "s/^Error: ${rule}[[:space:]]\\{1,\\}(.*$//")
        done
        if [ "$line" != "" ]; then
          if [ $has_error -eq 0 ]; then
            echo "$file: Error!"
          fi
          has_error=1
          echo "$line"
        fi
      done
    )"
    if [ "$OUTPUT" != "" ]; then
      echo "$OUTPUT"
      exit 1
    fi
  done
done
