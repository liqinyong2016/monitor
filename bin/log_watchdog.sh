#!/bin/sh

# watch php st_anti_spam log if log file exists
#

#if [ $# -eq 1 ]; then
#	logp="$1"
#else
#	echo "Usage: $0 logpath[/mnt/engine/st-anti-spam-dist/log/st_anti_spam_main.INFO]"
#	exit
#fi
#

mypp=`basename $0`
mylog="/tmp/${mypp}.log"

#nginxlog='/mnt/nginx/local/logs/error'

CMD='/mnt/alarm/bin/log_watch.sh'

#/mnt/alarm/bin/log_watch.sh /mnt/engine/st-anti-spam-dist/log/st_anti_spam_main.INFO
#/mnt/php/logs/16_04_01.log 
#

phplog="/mnt/php/logs/`date +%y_%m_%d`.log" 
before_phplog="/mnt/php/logs/`date -d -1days +%y_%m_%d`.log" 

old_phpid=`ps aux | grep "$before_phplog" | grep "tail -F" | grep -v grep | awk '{print $2}'` 
if [ "x$old_phpid" != "x" ]; then
	kill $old_phpid	
fi

st_spam='/mnt/engine/st-anti-spam-dist/log/st_anti_spam_main.INFO'

for STR in /mnt/engine/st-anti-spam-dist/log/st_anti_spam_main.INFO $phplog 
do
if [ -e "$STR" ]; then
	if `ps aux | grep "$STR" | grep 'tail -F' | grep -qv grep`; then

		echo "tail log $STR normal" >> $mylog
		
	else 
		echo "run $CMD $STR" >> $mylog
		
		nohup $CMD $STR &
	fi
fi
done

CMD='/mnt/alarm/bin/log_watch_nginx.sh'
STR='/mnt/nginx/local/logs/access.log'

if [ -e  "$STR" ]; then
    if `ps aux | grep "$CMD" | grep -qv grep`; then
       echo "tail log $str normal" >> $mylog
    else
       echo "run $CMD $STR" >> $mylog
       nohup $CMD $STR &
	exit
    fi
fi

