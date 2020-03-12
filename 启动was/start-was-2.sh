#!/bin/bash
#启动node,应用，zabbix agent,
cd /opt
daten=$(date +"%Y%m%d")
#f=`ps -ef|grep java|grep -v grep|grep -v mgr|grep -v start|grep -v nohup|awk '{print $2}'`
# kill -9 $f
#sleep 1s
#/opt/IBM/zabbix/sbin/zabbix_agentd -c /opt/IBM/zabbix/conf/zabbix_agentd.conf
#cd /opt/IBM/WebSphere/AppServer/profiles
#cdp
#ekzt=$(find /opt/IBM/WebSphere/AppServer/profiles -name startManager.sh)
#wait
#bash $ekzt
#wait
bnode=`find /opt/IBM/WebSphere/AppServer/profiles -name startNode.sh`
sleep 4s
#bash ${bnode}
wait
dapp=`find /opt/IBM/WebSphere/AppServer/profiles -name startServer.sh|grep -v dmgr`
sleep 4s
application=`find /opt/IBM/WebSphere/AppServer/profiles  -name *.pid|grep -v mgr|grep -v Mgr|grep -v node|awk -F "." '{print $1}'|awk -F "/" '{print $NF}'`
application1=`find /opt/IBM/WebSphere/AppServer/profiles  -name *.pid|grep -v mgr|grep -v Mgr|grep -v node|awk -F "." '{print $1}'|awk -F "/" '{print $NF}'|awk NR==1`
#application2=`find /opt/IBM/WebSphere/AppServer/profiles  -name *.pid|grep -v mgr|grep -v Mgr|grep -v node|awk -F "." '{print $1}'|awk -F "/" '{print $NF}'|awk NR==2`
#application3=`find /opt/IBM/WebSphere/AppServer/profiles  -name *.pid|grep -v mgr|grep -v Mgr|grep -v node|awk -F "." '{print $1}'|awk -F "/" '{print $NF}'|awk NR==3`
#wait
echo $a >/opt/IBM/WebSphere/AppServer/profiles/a
echo $a
#c=`cat a|awk -F "/" '{print $4}'`
#nohup bash ${dapp}  ${application1} &
#nohup bash ${dapp}  ${application2} &
#nohup bash ${dapp}  ${application3} &
wenjian=`find /opt/IBM/WebSphere/AppServer/profiles/*rf*/logs/ -mtime -2 -a -name "SystemOut.log" -type f|grep opt|grep -v nodeagent`
#logg=`tail -400 $wenjian|grep -v "在"|grep -v "核心"|grep -v "输通道服务"|grep -v "检测"|grep -v "ApplicationMg"|grep -v "CompositionUn"|grep -v "SchedulerServ"|grep -v "ServerCollabo"|grep -v "UserMana"|grep -v "WsServer"|grep -v "统已发现"|grep -v "名为"|grep -v "webcontaine"`
numerjin=`ps -ef|grep java|grep -v grep|grep -v dmgr|grep -v Mgr|wc -l`
if [ $numerjin -lt 2 ]&&[ -n $wenjian ];then
bash ${bnode}
wait
nohup bash ${dapp}  ${application1} &
else
	echo 3 > /home/wasadmin/3
fi
zabbixnum=`ps -ef|grep zabbix|grep -v grep|wc -l`
if [ $zabbixnum -lt 3 ];then

nohup /opt/IBM/zabbix/sbin/zabbix_agentd -c /opt/IBM/zabbix/conf/zabbix_agentd.conf &
nohup /opt/zabbix/sbin/zabbix_agentd -c /opt/zabbix/conf/zabbix_agentd.conf &
nohup /opt/IBM/zabbix_agentd3/sbin/zabbix_agentd -c /opt/IBM/zabbix_agentd3/conf/zabbix_agentd.conf &
wait
else
	exit
fi
