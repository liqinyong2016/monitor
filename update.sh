#!/bin/bash


# update all monitor
# include port/process/log
#


# rsync script
/mnt/INSTALL/autocmd/scp.sh all /mnt/INSTALL/ /mnt/INSTALL/

# install at all srv
/mnt/INSTALL/autocmd/cmd.sh all /mnt/INSTALL/monitor/install.sh

#
# INSTALL crontab

#* * * * *  /mnt/alarm/bin/log_watchdog.sh >/dev/null 2>&1
#*/5 * * * *  /mnt/alarm/bin/port_watch.sh 9090 >/dev/null 2>&1
#*/5 * * * *  /mnt/alarm/bin/port_watch.sh 443 >/dev/null 2>&1
#*/5 * * * *  /mnt/alarm/bin/port_watch.sh 9000 >/dev/null 2>&1
#*/5 * * * *  /mnt/alarm/bin/st_process.sh >/dev/null 2>&1
#*/5 * * * *  /mnt/alarm/bin/web_process_watch.sh >/dev/null 2>&1
#

#--- update srv 
## log_watchlog.sh
/mnt/INSTALL/autocmd/cmd.sh srv 'crontab -l -uroot | grep -v /mnt/alarm/bin/log_watchdog.sh >/tmp/.TEMP.cron.1 ; echo "* * * * *  /mnt/alarm/bin/log_watchdog.sh >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

## process 
/mnt/INSTALL/autocmd/cmd.sh srv 'crontab -l -uroot | grep -v "/mnt/alarm/bin/st_process.sh" >/tmp/.TEMP.cron.1 ; echo "*/5 * * * *  /mnt/alarm/bin/st_process.sh >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

## port st engine
/mnt/INSTALL/autocmd/cmd.sh srv 'crontab -l -uroot | grep -v "/mnt/alarm/bin/port_watch.sh 9090" >/tmp/.TEMP.cron.1 ; echo "*/5 * * * *  /mnt/alarm/bin/port_watch.sh 9090 >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'


#---- update web
## log_watchlog
/mnt/INSTALL/autocmd/cmd.sh web 'crontab -l -uroot | grep -v /mnt/alarm/bin/log_watchdog.sh >/tmp/.TEMP.cron.1 ; echo "* * * * *  /mnt/alarm/bin/log_watchdog.sh >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

## process
/mnt/INSTALL/autocmd/cmd.sh web 'crontab -l -uroot | grep -v "/mnt/alarm/bin/web_process_watch.sh" >/tmp/.TEMP.cron.1 ; echo "*/5 * * * *  /mnt/alarm/bin/web_process_watch.sh >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

## port nginx and php
/mnt/INSTALL/autocmd/cmd.sh web 'crontab -l -uroot | grep -v "/mnt/alarm/bin/port_watch.sh 443" >/tmp/.TEMP.cron.1 ; echo "*/5 * * * *  /mnt/alarm/bin/port_watch.sh 443 >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

/mnt/INSTALL/autocmd/cmd.sh web 'crontab -l -uroot | grep -v "/mnt/alarm/bin/port_watch.sh 9000" >/tmp/.TEMP.cron.1 ; echo "*/5 * * * *  /mnt/alarm/bin/port_watch.sh 9000 >/dev/null 2>&1" >> /tmp/.TEMP.cron.1 ; crontab /tmp/.TEMP.cron.1'

#---- update log_watch kill tail
/mnt/INSTALL/autocmd/cmd.sh all ' killall tail;  /mnt/alarm/bin/log_watchdog.sh >/dev/null '
