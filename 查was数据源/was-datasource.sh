#!/bin/bash
cd /opt/IBM/WebSphere/AppServer/profiles/*mgr*/bin
./wsadmin.sh -lang jython -user wasadmin -password passwordconsole -f /opt/IBM/datasource.py
echo "#################servers####################"

cd /opt/IBM
cat url.txt |sed 's/^[ \t]*//g'|sed '/^$/d' > urli.txt
paste dso.txt jnd.txt yum.txt min.txt max.txt > data-source.txt
awk '{printf "%-25s%-30s%-20s%-5s%-5s\n",$1,$2,$3,$4,$5}' data-source.txt > was-data-source.txt

#rm data-source.txt url.txt dso.txt jnd.txt yum.txt min.txt max.txt
echo "#################data-ssource################"
ip=`hostname -i`
cp urli.txt $ip-urli.txt
cp was-data-source.txt $ip-urlidatazong.txt


time=`date +%Y%m%d%H%M%s`
#iprocess=`ps -ef|grep java|grep -v grep|grep -v ipjava|grep -v javaprostatus|awk '{print $NF}'`
sysissue=`cat /etc/redhat-release`
#uuser=`ps -ef|grep java|grep -v grep|awk '{print $1}'|awk NR==1`
#rm -f /home/logger/processstatus
#echo > /home/logger/processstatus
#chmod a+x /home/logger/processstatus
#nohup echo ${ip} ${uuser} ${iprocess} ${sysissue}  > /home/logger/processstatus &
#传ip，进程名给228.232
#IP=`cat /opt/IBM/shaopingtaifabuyingyongming/zongipbuchong`
#for i in $IP
#do
cd /opt/
/usr/bin/expect <<-EOF
set timeout 10s
spawn ssh root@10.1.228.232
expect {
"*yes/no" { send "yes\r";exp_continue }
"*password:" { send "password\r" }
}
expect "*#"
send "cd /opt/\n"
send "scp -o StrictHostKeyChecking=no wasadmin@$ip:/opt/IBM/$ip-urli*  /opt/tomcatidc/datasouredata/\n" 
expect {
"*yes/no" { send "yes\r" }
"*password:" { send "password\r" }
}
expect "*#"
#send "cat /opt/log/$ip$timejavaproc.log > /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/qiegeipjianyantest/log/$ip$timejavaproc.log\n"
expect "*$"
send "exit\r"
expect "*$"
expect eof
EOF
