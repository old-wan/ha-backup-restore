#!/bin/bash
sudo systemctl stop hass
if [ -b /dev/sda1 ]; then
	sudo mount /dev/sda1 /media
else
	sudo mount /dev/sdb1 /media
fi
BACKUP_FOLDER=/media/hassbackup/
BACKUP_LOCATION=$HOME/.homeassistant
if [ -d "${BACKUP_FOLDER}" ]; then
	if [ ! -d "${BACKUP_LOCATION}" ]; then
                log e "Homeassistant folder not found, is it correct?" 1
	else
		sudo rm -rf ${BACKUP_LOCATION}
		unzip ${BACKUP_FOLDER}/hass-config.zip -d ${BACKUP_LOCATION}
		sudo systemctl restart hass
		sudo umount /media
        fi
else
        log e "Backup folder not found, is your USB drive mounted?" 1
fi