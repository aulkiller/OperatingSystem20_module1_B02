#!/bin/bash

NamaCrypted=${1%.*}

jam=$(date -r $1 +"%H")

hurufG=({A..Z})
hurufk=({a..z})

hurufGawal=${hurufG[ $(($jam % 26)) ]}
hurufGakhir=${hurufG[ $(( $(( $jam + 25 )) % 26 ))]}
hurufkawal=${hurufk[($jam%26)]}
hurufkakhir=${hurufk[(25+$jam)%26]}


NamaDecrypted=$(echo "$NamaCrypted" | tr ["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"] [A-Za-z])
# echo "$NamaCrypted" | tr '[A-Za-z]' '["$hurufGawal"-ZA-"$hurufGakhir""$hurufkawal"-za-"$hurufkakhir"]'

mv $NamaCrypted.txt $NamaDecrypted.txt
echo "file terdekripsi menjadi : $NamaDecrypted.txt"
