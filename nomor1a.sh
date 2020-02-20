#!/bin/bash

awk -F $'\t' 'NR>1{arr[$13]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -1 | awk -F ',' '{print $2}'
