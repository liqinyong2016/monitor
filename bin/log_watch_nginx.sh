#!/bin/bash

if [ $# -eq 1 ]; then
        logf="$1";
else
        echo "Usage: $0 logpath";
fi

weixinlog='/mnt/alarm/local/log'
if [ ! -d "$weixinlog" ]; then
	mkdir -p $weixinlog
fi


hostn=`hostname`
if [ -e "$logf" ]; then
        tail -F $logf | while read line
        do
            str=`echo $line | awk -F\" '{if($4 ~/fengkongcloud.com\/$/) {print $3}}' | awk '{print $1}'| grep -v 200`
            if [ x"$str" = x ];then
                echo "ok"
            else
		echo "$hostn $line" >> $weixinlog/logwatch_nginx.log
               cagent_tools alarm "$hostn $line"
            fi
        done
else
        echo "none exist file $logf"
fi

