#/bin/bash

log='/mnt/alarm/local/log/'
confp='/mnt/alarm/conf'
conf="$confp/st_engine.conf"

if [ ! -d "$confp" ]; then
	mkdir -p $confp
fi

if [ -e "$conf" ]; then
. $conf
else
	status=0
fi


hostn=`hostname`
mm=`ps aux |grep "/mnt/engine/st-anti-spam-dist/bin/st_anti_spam_main --flagfile=" | grep -v grep | wc -l`
if [  "$mm" -lt "1" ] ; then
	# have error
	echo -e "status=1\n" > $conf

	if [ "x$status" = "x0" ]; then
        	echo "st_anti_spam_main  is dead"
        	cagent_tools alarm  "$hostn st_anti_spam_main is not alive !!!"
		
		# weixin
		echo "$hostn st_anti_spam_main is not alive !!!" > $conf
	fi
else
	# none error
	echo -e "status=0\n" > $conf

	if [ "x$status" = "x1" ]; then
        	echo "st_anti_spam_main  is reboot success"
        	cagent_tools alarm  "$hostn st_anti_spam_main reboot alive !!!"
		
		# weixin
		echo "$hostn st_anti_spam_main reboot alive !!!" > $conf
	fi

fi

