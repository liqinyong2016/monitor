#!/bin/bash

rsync -auv /mnt/INSTALL/monitor/  sh_spam5:/mnt/INSTALL/monitor/ 
ssh sh_spam5 ' bash -x /mnt/INSTALL/monitor/update.sh '
