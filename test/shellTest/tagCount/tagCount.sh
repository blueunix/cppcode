#!/bin/sh

cat "$1" |
sed -e 's#systemitem *role="url"#URL#g' -e 's#/systemitem#/URL#' |
tr ' ()[]{}' '\n\n\n\n\n\n\n'|
egrep '>[^<>]+</'|
awk -F'[<>]' -v FILE="$1"  '{ printf("%-31s\t%-15s\t%s\n",$3,$2,FILE) }'|
  sort|
  uniq -c|
  sort -k2,2 -k3,3
