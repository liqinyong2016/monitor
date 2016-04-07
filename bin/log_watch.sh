#!/bin/bash

if [ $# -eq 1 ]; then
	logf="$1";
else
	echo "Usage: $0 logpath";
fi

alarmlog='/mnt/alarm/local/log'
if [ ! -d "$alarmlog" ]; then
	mkdir -p $alarmlog
fi

logname=`basename $logf`

hostn=`hostname`
if [ -e "$logf" ]; then
	tail -F $logf | grep --line-buffered -E '\[ERROR\]|\[FATAL\]' | while read line
	do
		echo "$hostn $line" >> $alarmlog/${logname}.log

		cagent_tools alarm "$hostn $line"
	done
else
	echo "none exist file $logf"
fi
