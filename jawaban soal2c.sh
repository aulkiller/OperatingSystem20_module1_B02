#!/bin/bash

NamaFileAwal=${1%.*}

if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

jam=$(date -r $NamaFileAwal.txt +"%H")

hurufG=({A..Z})
hurufk=({a..z})

hurufGawal=${hurufG[ $(($jam % 26)) ]}
hurufGakhir=${hurufG[ $(( $(( $jam + 25 )) % 26 ))]}
hurufkawal=${hurufk[($jam%26)]}
hurufkakhir=${hurufk[(25+$jam)%26]}

NamaFileAkhir=$(echo "$NamaFileAwal" | tr [A-Za-z] ["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"])
# echo "$NamaFileAwal" | tr '[A-Za-z]' '["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"]'

mv $NamaFileAwal.txt $NamaFileAkhir.txt
echo "file terenkripsi menjadi : $NamaFileAkhir.txt"
