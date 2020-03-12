#!/bin/bash
lpp=`cat $1`
for ip in $lpp
do
cd /opt
/usr/bin/expect <<-EOF
set timeout 10s
spawn ssh logger@$ip
expect {
"*yes/no" { send "yes\r";exp_continue }
"*password:" { send "密码\r" }
}
expect "*$"
send "rm   -f /home/logger/javaprostatus1.sh \n"
send "rm  -f /home/logger/javaprostatus10s.sh \n"
send "scp -o StrictHostKeyChecking=no root@java程序所在ip:/opt/tomcatidc/javaprostatus10s.sh  /home/logger/\n"
expect {
"*yes/no" { send "yes\r" }
"*password:" { send "密码\r" }
}
expect "*$"
send "nohup sh /home/logger/javaprostatus10s.sh &\n"

expect "*$"
send "exit\r"
expect "*$"
expect eof
EOF
done
