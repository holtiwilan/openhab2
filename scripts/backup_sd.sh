sudo dd bs=4M if=/dev/mmcblk0 |gzip > /media/usbdrive/image`date +%d%m%y`.gz&

#tu restore
#sudo gzip -dc /home/your_username/image.gz | dd bs=4M of=/dev/sdb
