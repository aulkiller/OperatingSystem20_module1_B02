#!/bin/bash
meow=$(awk -F $'\t' 'NR>1{arr[$13]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -1 | awk -F ',' '{print $2}' )

echo $meow

mybro=($(awk -F $'\t' -v x=$meow 'NR>1{if ($13 == x) arr[$11]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -2 | awk -F ',' '{print $2}'))

echo ${mybro[0]}
echo ${mybro[1]}

awk -F $'\t' -v x=$meow -v y=${mybro[0]} -v z=${mybro[1]} 'NR>1{if ( $13 == x && ( $11 == y || $11 == z)) arr[$17]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -10 | awk -F ',' '{print $2}'
