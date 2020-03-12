#!/bin/bash
lpp=`cat $1`
for ip in $lpp
do
cd /opt
/usr/bin/expect <<-EOF
set timeout 10s
spawn ssh wasadmin@$ip
expect {
"*yes/no" { send "yes\r";exp_continue }
"*password:" { send "password\r" }
}
expect "*$"
#send "rm   -f /home/logger/javaprostatus1.sh \n"
#send "rm  -f /home/logger/javaprostatus10s.sh \n"
send "scp -o StrictHostKeyChecking=no root@10.1.228.232:/opt/tomcatidc/consoleshelldata/*  /opt/IBM/\n"
expect {
"*yes/no" { send "yes\r" }
"*password:" { send "password\r" }
}
expect "*$"
send "nohup sh /opt/IBM/was-datasource.sh &\n"

expect "*$"
send "exit\r"
expect "*$"
expect eof
EOF
done
