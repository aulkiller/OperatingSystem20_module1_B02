#!/bin/bash
randompswd=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 ; echo '')
echo "kode unik tercipta : $randompswd"

NamaFileAwal=${1%.*}

if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

echo $randompswd>$NamaFileAwal.txt
echo "file tercipta : $NamaFileAwal.txt"
