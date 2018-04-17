#!/bin/bash

# Seppys iPhone
sudo hping3 -2 -c 10 -p 5353 -i u1 192.168.178.60 -q >/dev/null 2>&1
sudo hping3 -2 -c 10 -p 5353 -i u1 192.168.178.83 -q >/dev/null 2>&1
DEVICES=`sudo arp -an | awk '{print $4}'`
if [[ $DEVICES == *00:EC:0A:70:F7:2E* ]]
  then
    echo "Tim anwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/PresenceTim
  else
    echo "Tim abwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/PresenceTim
fi
if [[ $DEVICES == *E4:46:DA:6C:1C:44* ]]
  then
    echo "Sandra anwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/PresenceSandra
  else
    echo "Sandra abwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/PresenceSandra
fi
