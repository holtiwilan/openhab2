#!/bin/bash

# Seppys iPhone
sudo hping3 -2 -c 10 -p 5353 -i u1 192.168.178.44 -q >/dev/null 2>&1
sudo hping3 -2 -c 10 -p 5353 -i u1 192.168.178.30 -q >/dev/null 2>&1
DEVICES=`sudo arp -an | awk '{print $4}'`
if [[ $DEVICES == *d4:f4:6f:8d:b3:f5* ]]
  then
    echo "Tim anwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/PresenceTim
  else
    echo "Tim abwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/PresenceTim
fi
if [[ $DEVICES == *00:42:37:57:08:29* ]]
  then
    echo "Sandra anwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/PresenceSandra
  else
    echo "Sandra abwesend"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/PresenceSandra
fi
