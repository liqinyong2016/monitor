#!/bin/bash 


INSTALL_DIR='/mnt/INSTALL/monitor/bin'

if [ -d /mnt/alarm/bin/ ]; then
	/bin/rm -rf /mnt/alarm/bin/
fi

mkdir -p /mnt/alarm/local/
mkdir -p /mnt/alarm/bin/

/bin/cp -af $INSTALL_DIR/* /mnt/alarm/bin/

chmod -R 755 /mnt/alarm/bin/*

