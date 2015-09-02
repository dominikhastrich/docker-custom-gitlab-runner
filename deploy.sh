echo -e "\n\n######\nDEPLOYMENT\n######" >> /my.log 
echo "killing" >> /my.log 
echo ps -ef | grep "start.sh" >> /my.log
ps -ef | grep "start.sh" | awk '{print $2}' | xargs kill 2>> /my.log
echo "starting" >> /my.log
/bin/bash /data/services/start.sh >> /my.log
