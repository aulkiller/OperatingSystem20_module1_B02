#!/bin/bash
randompswd1=$(head /dev/urandom | tr -dc A-Z | head -c 1 ; echo '')
randompswd2=$(head /dev/urandom | tr -dc a-z | head -c 1 ; echo '')
randompswd3=$(head /dev/urandom | tr -dc 0-9 | head -c 1 ; echo '')
randompswd4=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 25 ; echo '')


case "$((RANDOM % 6))" in
  "0")
  randompswd="$randompswd1$randompswd2$randompswd3$randompswd4"
  ;;
  "1")
  randompswd="$randompswd1$randompswd3$randompswd2$randompswd4"
  ;;
  "2")
  randompswd="$randompswd3$randompswd2$randompswd1$randompswd4"
  ;;
  "3")
  randompswd="$randompswd3$randompswd1$randompswd2$randompswd4"
  ;;
  "4")
  randompswd="$randompswd2$randompswd3$randompswd1$randompswd4"
  ;;
  "5")
  randompswd="$randompswd2$randompswd1$randompswd3$randompswd4"
  ;;
esac


echo "kode unik tercipta : $randompswd"

NamaFileAwal=${1%%.*}

if [[ $NamaFileAwal =~ [0-9] ]]
  then
    NamaFileAwal=${NamaFileAwal//[[:digit:]]/}
  fi

echo $randompswd>$NamaFileAwal.txt
echo "file tercipta : $NamaFileAwal.txt"
