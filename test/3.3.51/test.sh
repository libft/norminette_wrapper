#!/bin/sh

set -e

if [ "$NORMINETTE" = "" ]
then
  NORMINETTE=norminette
fi

(cd data/in && find . -type f -name "*.c") | cut -c 3- | sed s/\\.c\$// | while read -r file; do
  $NORMINETTE "data/in/$file.c" | cmp "data/out/$file.before.txt"
  RULES_TO_SUPPRESS=$(cat "data/in/$file.rules.txt") sh ../../src/3.3.51.sh "data/in/$file.c" | cmp "data/out/$file.after.txt"
done
