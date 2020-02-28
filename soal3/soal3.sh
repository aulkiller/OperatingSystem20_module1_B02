#!/bin/bash

cd /home/fxkevink/Documents/SoalShiftSISOP20_modul1_B02-master/soal3
# fxkevink harus diganti dengan nama user yang sedang menjalankan script
# directory documents bisa digantikan dengan folder lain dimana keseluruhan folder soal disimpan

iter=0
num0=0
while [[ $iter -ne 28 ]]
do
#echo "ping"
wget -O pdkt_Kusuma_$(($iter+1)) https://loremflickr.com/320/240/cat -o temp.log
if [[ $iter -eq $num0 ]]
  then
    grep -r "Location" temp.log > Location.log
    cat temp.log > wget.log
elif [[ $iter -gt $num0 ]]
  then
    grep -r "Location" temp.log >> Location.log
    cat temp.log >> wget.log
fi
let iter++
done

readarray ab < Location.log

max=29
for a in {0..28}
do
  for((i=$((a+1)); i<$max; i=i+1))
    do
      nomerA=$(ls -1 kenangan | wc -l)
      nomerB=$(ls -1 duplicate | wc -l)
    if [[ "${ab[$a]}" = "${ab[$i]}" ]]
      then
      # echo pdkt_Kusuma_"$((a+1))"
      # echo duplicate_"$nomerB"
      mv pdkt_Kusuma_"$(($a+1))" duplicate/duplicate_"$(($nomerB+1))".jpeg
      nomerB=$((nomerB + 1))
      break

    elif [[ $(($max-1)) -eq $i ]]
      then
      # echo pdkt_Kusuma_"$((a+1))"
      # echo kenangan_"$nomerA"
      mv pdkt_Kusuma_"$(($a+1))" kenangan/kenangan_"$(($nomerA+1))".jpeg
      nomerA=$((nomerA + 1))
    fi
    done
done

cat wget.log > Backup.log.bak
cat Location.log >> Backup.log.bak
rm temp.log
