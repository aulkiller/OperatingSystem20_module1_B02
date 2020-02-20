#!/bin/bash


meow=$(awk -F $'\t' 'NR>1{arr[$13]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -1 | awk -F ',' '{print $2}' )
echo -e "a.Bagian (Region) yang memiliki profit paling sedikit : $meow\n"

mybro=($(awk -F $'\t' -v x=$meow 'NR>1{if ($13 == x) arr[$11]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -2 | awk -F ',' '{print $2}'))

echo -e "b.2 Negara Bagian (State) yang memiliki \nprofit paling sedikit di Region $meow : \n${mybro[0]} dan ${mybro[1]}\n"

echo -e "c.List 10 produk yang memiliki profit paling sedikit pada state\n${mybro[0]} dan ${mybro[1]} di Region $meow :"
awk -F $'\t' -v x=$meow -v y=${mybro[0]} -v z=${mybro[1]} 'NR>1{if ( $13 == x && ( $11 == y || $11 == z)) arr[$17]+=$21}
END {for (i in arr) print arr[i] "," i}' Sample-Superstore.tsv| LC_ALL=C sort -n | head -10 | awk -F ',' '{print $2}'
