#!/bin/sh

set -e

if [ "$NORMINETTE" = "" ]
then
  NORMINETTE=norminette
fi

(cd data/in && find . -type f -name "*.c") | cut -c 3- | sed s/\\.c\$// | while read -r file; do
  echo "Testing for $file.c"
  ERROR=0
  OUTPUT="$($NORMINETTE "data/in/$file.c")" || ERROR=1
  echo "$OUTPUT" | diff "data/out/$file.before.txt" -
  NEW_ERROR=0
  OUTPUT="$(RULES_TO_SUPPRESS="$(cat "data/in/$file.rules.txt")" sh ../../src/3.3.51.sh "data/in/$file.c")" || NEW_ERROR=1
  echo "$OUTPUT" | diff "data/out/$file.after.txt" -
  if [ "$OUTPUT" = "" ]; then
    ERROR=0
  fi
  if [ $ERROR -ne $NEW_ERROR ]; then
    echo "Exit code mismatch"
    exit 1
  fi
done
