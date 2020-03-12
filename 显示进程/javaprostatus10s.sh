#!/bin/sh
ip=`hostname -i`
time=`date +%Y%m%d%H%M%s`
iprocess=`ps -ef|grep java|grep -v grep|grep -v ipjava|grep -v javaprostatus|awk '{print $NF}'`
sysissue=`cat /etc/redhat-release`
uuser=`ps -ef|grep java|grep -v grep|awk '{print $1}'|awk NR==1`
rm -f /home/logger/processstatus
echo > /home/logger/processstatus
chmod a+x /home/logger/processstatus
nohup echo ${ip} ${uuser} ${iprocess} ${sysissue}  > /home/logger/processstatus &
#传ip，进程名给java程序所在ip
#IP=`cat /opt/IBM/shaopingtaifabuyingyongming/zongipbuchong`
#for i in $IP
#do
cd /home/logger
/usr/bin/expect <<-EOF
set timeout 15s
spawn ssh root@程序所在ip
expect {
"*yes/no" { send "yes\r";exp_continue }
"*password:" { send "密码\r" }
}
expect "*#"
send "cd /opt/\n"
send "scp -o StrictHostKeyChecking=no logger@$ip:/home/logger/processstatus  /opt/log/$ip$timejavaproc.log\n" 
expect {
"*yes/no" { send "yes\r" }
"*password:" { send "密码\r" }
}
expect "*#"
send "cat /opt/log/$ip$timejavaproc.log > /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/qiegeipjianyantest/log/$ip$timejavaproc.log\n"
expect "*$"
send "exit\r"
expect "*$"
expect eof
EOF

