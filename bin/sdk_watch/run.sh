#/bin/bash
str=`sh run_one.sh | grep "PASS"`
if [ x"$str" = x ] ;then
    cagent_tools alarm "sdk failed!"  
else
   echo "pass"
fi
