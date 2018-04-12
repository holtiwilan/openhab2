	#!/bin/bash
ping -c1 8.8.8.8 > /dev/null
 
if [ $? -ne 0 ]; then
        PING=0
        DOWN=0
        UP=0
        IP="Offline"
else
        python3 /etc/openhab2/scripts/speedtest.py --simple > /tmp/speedresult.txt
        PING=$(cat /tmp/speedresult.txt |grep Ping |cut -d " " -f 2)
        DOWN=$(cat /tmp/speedresult.txt |grep Download |cut -d " " -f 2)
        UP=$(cat /tmp/speedresult.txt |grep Upload |cut -d " " -f 2)
        IP=$(/usr/bin/curl -s https://klenzel.net/remoteip.php)
fi
 
 
/usr/bin/curl -s --header "Content-Type: text/plain" --request POST --data $PING http://openhabian:8080/rest/items/INET_PING
/usr/bin/curl -s --header "Content-Type: text/plain" --request POST --data $DOWN http://openhabian:8080/rest/items/INET_DOWN
/usr/bin/curl -s --header "Content-Type: text/plain" --request POST --data $UP http://openhabian:8080/rest/items/INET_UP
/usr/bin/curl -s --header "Content-Type: text/plain" --request POST --data $IP http://openhabian:8080/rest/items/INET_IP
 
rm -f /tmp/speedresult.txt
