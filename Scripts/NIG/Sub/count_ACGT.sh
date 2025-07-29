#!/bin/bash
set -e
set -u
set -o pipefail

input=$1

grep -v '>' $input | sed 's/\(.\)/\n\1/g' | sort | uniq -c | egrep 'A|C|G|T'
