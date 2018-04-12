#!/bin/bash

ping -c 3 192.168.178.71 > /dev/null 2>&1
if [ $? -ne 0 ]
then
   # Use your favorite mailer here:
   echo "Batterie prüfen"
   curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/GartenBatterieLeer   
fi

 content=$(curl -L http://192.168.178.71/status)
 echo $content
 if [[ $content == ein ]]
  then
    echo "Gartenbewässerung wird verhindert"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/NichtBewaessern   
  	curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/GartenBatterieLeer
  else
    echo "Gartenbewässerung wird nicht verhindert"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/NichtBewaessern   
 	curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/GartenBatterieLeer
 fi

 if [[ $content == aus ]]
  then
    echo "Gartenbewässerung wird nicht verhindert"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/NichtBewaessern   
  	curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/GartenBatterieLeer
  else
    echo "Gartenbewässerung wird verhindert"
    curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "ON" http://openhabian:8080/rest/items/NichtBewaessern   
	curl --max-time 2 --connect-timeout 2 --header "Content-Type: text/plain" --request POST --data "OFF" http://openhabian:8080/rest/items/GartenBatterieLeer
 fi 
