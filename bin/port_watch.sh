#!/bin/bash


if [ $# -eq 1 ]; then
	port=$1
else
	echo "Usage: $0 portnum"
	exit
fi

log='/mnt/alarm/local/log/'
conf='/mnt/alarm/conf'

if [ ! -d "$conf" ]; then
	mkdir -p $conf
fi

if [ ! -d "$log" ]; then
	mkdir -p $log
fi


if [ -e "$conf/${port}.conf" ]; then
. $conf/${port}.conf
else
	#interval=600
	#before_time=`date +%s`

	# 0 is success, 1 is failed
	status=0
fi



ip=`/sbin/ifconfig eth0 | awk -F: '/inet addr:/{print $2 }' | awk '{print $1}'`
host=`hostname`

result=`nc -v -w 10 -z  localhost  $port 2>/dev/null | grep "succeeded"`

#echo $result

if [ "x$result" =  "x" ];then
	# have error
	echo -e "status=1\n" > $conf/${port}.conf


	# if  before is succes , send alarm
	if [ "x$status" = "x0" ]; then

#		now_time=`date +%s`
#		let alarm_time=$before_time + $interval
#
#		if [ $now_time -gt $alarm_time  ]; then
#   			cagent_tools alarm  "$host port:$port failed!!!"
#		fi
		
		cagent_tools alarm  "$host port:$port failed!!!"

		# weixin
		echo "$host port:$port failed!!!" > $log/port_${port}.log
	fi

else
	# none error
	echo -e "status=0\n" > $conf/${port}.conf
	
	# if before have failed, send alarm 
	if [ "x$status" = "x1" ]; then
		cagent_tools alarm  "$host port:$port reboot sucess"
		echo "$host port:$port failed!!!" > $log/port_${port}.log

		# weixin
		echo "$host port:$port reboot success" > $log/port_${port}.log
	fi
fi
