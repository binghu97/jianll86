#!/bin/bash
#All are not started once more
#single tomcat dir start start.sh successfully  in 10.128.38.191
#single tomcat dir start startup.sh successfully  in 10.128.38.191
#Two tomcat dir start startup.sh successfully  in 10.1.232.230
#one application one tomcat one jardir start  jarwith parameter successfully in 10.128.49.21
zstartupsh1=`find /opt -name "startup.sh"|awk NR==1`
zstartupsh2=`find /opt -name "startup.sh"|awk NR==2`
zstartsh1=`find /opt -name "start.sh"|grep tomcat|awk NR==1`
zstartsh2=`find /opt -name "start.sh"|grep tomcat|awk NR==2`
zstartshjar1=`find /opt -name "start.sh"|grep -v tomcat|awk NR==1 `
zstartshjar2=`find /opt -name "start.sh"|grep -v tomcat|awk NR==2 `
ip=`hostname -i`
A1zupstartup=`echo $zstartupsh1|awk -F "startup.sh" '{print $(NF-1)}'`
A2zupstartup=`echo $zstartupsh2|awk -F "startup.sh" '{print $(NF-1)}'`
B1zupstartsh=`echo $zstartsh1|awk -F "start.sh" '{print $(NF-1)}'`
B2zupstartsh=`echo $zstartsh2|awk -F "start.sh" '{print $(NF-1)}'`
czupstartsh=`echo $zstartshjar1|awk -F "start.sh" '{print $(NF-1)}'`
Dzupstartsh=`echo $zstartshjar2|awk -F "start.sh" '{print $(NF-1)}'`
wenjiantomcat1=`find $A1zupstartup../ -mtime -2 -type f|grep opt`
wenjiantomcat2=`find $A2zupstartup../ -mtime -2 -type f|grep opt`
#wenjian3=`find $czupstartsh -mtime -2 -type f|grep opt`
wenjian3=`find /opt -mtime -2 -type f|grep opt`
#wenjian4=`find $Dzupstartsh -mtime -2 -type f|grep opt`
wenjian4=`find /opt -mtime -2 -type f|grep opt`
jarpanduan2=`nohup cat $zstartshjar1|grep -v "#"|grep arrayjar &`
sleep 2
echo $jarpanduan2
jarpanduan1=`nohup cat $zstartshjar1|grep -v "#"|grep *.jar &`
sleep 2
jarpanduan3=`nohup cat $zstartshjar2|grep -v "#"|grep arrayjar &`
sleep 2
jarpanduan4=`nohup cat $zstartshjar2|grep -v "#"|grep *.jar &`
sleep 2
pidz=`ps -ef|grep java|grep -v grep |awk '{print $2}'`
jarname1=`find $czupstartsh/  -maxdepth 1 -mindepth 1 -name "*.jar"|grep -v bak|grep -v 20|awk -F "/" '{print $NF}'`
jarname2=`find $Dzupstartsh/  -maxdepth 1 -mindepth 1 -name "*.jar"|grep -v bak|grep -v 20|awk -F "/" '{print $NF}'`

if [[ -n $zstartupsh1  ]] && [[ -n $zstartsh1 ]]&&[[ -n $wenjiantomcat1 ]]&&[[ ! -n $pidz ]] 
then
#start tomcat with start.sh
	cd  $A1zupstartup && ./start.sh
elif [[ -n $zstartupsh2  ]] && [[ -n $zstartsh2 ]]&&[[ -n $wenjiantomcat2 ]]&&[[ ! -n $pidz ]]
then
#start tomcat with start.sh
        cd  $A2zupstartup && ./start.sh
elif [[ -n "$zstartupsh1"  ]] && [[ ! -n "$zstartsh1" ]]&&[[ -n "$wenjiantomcat1" ]]&&[[ ! -n "$pidz" ]]
then
#start tomcat without start.sh
	cd  $A1zupstartup && ./startup.sh
elif [[ -n "$zstartupsh2"  ]] && [[ ! -n "$zstartsh2" ]]&&[[ -n "$wenjiantomcat2" ]]&&[[ ! -n "$pidz" ]]
then
#start tomcat without start.sh
        cd  $A2zupstartup && ./startup.sh
elif [[  -n "$zstartshjar1"  ]] && [ -n "$wenjian3" ] && [ -n "$jarpanduan1" -o  -n "$jarpanduan2" ] && [ ! -n "$pidz" ]
then
#start jar without parameter
         cd  $czupstartsh && ./start.sh
elif [  -n "$zstartshjar2"  ] && [ -n "$wenjian4" ] && [ -n "$jarpanduan3" -o  -n "$jarpanduan4" ] && [ ! -n "$pidz" ]
then
#start jar without parameter
         cd  $Dzupstartsh && chmod a+x start.sh && ./start.sh
elif [[ -n $zstartshjar1 ]]&&[[ -n $wenjian3 ]]&&[[ ! -n $pidz ]]&&[[ ! -n $jarpanduan1 ]]&&[[ ! -n $jarpanduan2 ]]
then
#start jar with parameter
	cd  $czupstartsh && chmod a+x start.sh && ./start.sh $jarname1	
elif [[ -n $zstartshjar2 ]]&&[[ -n $wenjian4 ]]&&[[ ! -n $pidz ]]&&[[ ! -n $jarpanduan3 ]]&&[[ ! -n $jarpanduan4 ]]
then
#start jar with parameter
cd  $Dzupstartsh && ./start.sh $jarname2


else
	echo $ip "--IP:$ip is not started this time,maybe had been started!" >> /tmp/notstartthistime.log
fi
