#/bin/bash

log='/mnt/alarm/local/log/'
if [ ! -d "$log" ]; then
	mkdir -p $log
fi

mm=`ps aux  |grep "nginx: master process" | grep -v grep | wc  -l`
if [  "$mm" -lt "1" ] ; then
        echo "nginx is dead"
        cagent_tools alarm  "`hostname` nginx is not alive !!!" 
	echo "`hostname` nginx is not alive !!!" > $log/process_nginx.log
fi

mm=`ps aux  |grep "php-fpm: master process" | grep -v grep | wc  -l`
if [  "$mm" -lt "1" ] ; then
        echo "php-fpm is dead"
        cagent_tools alarm  "`hostname` php-fpm is not alive !!!"
	echo "`hostname` php-fpm is not alive !!!" > $log/process_nginx.log
fi

