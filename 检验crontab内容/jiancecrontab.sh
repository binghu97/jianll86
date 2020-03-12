#!/bin/bash
ip=`hostname -i`
echo > /tmp/$ip$crontabjieguo
echo > /home/wasadmin/$ip$crontabjieguo
crontab -l > /home/wasadmin/$ip$crontabjieguo


#xiugai

#nohup echo ${ip}  >> /home/wasadmin/$ip$crontabjieguo &
sed   -i "s/^/${ip} &/g" /home/wasadmin/$ip$crontabjieguo
cp /home/wasadmin/$ip$crontabjieguo /tmp/
cd /opt
/usr/bin/expect <<-EOF
set timeout 15s
spawn ssh root@10.1.228.232
expect {
"*yes/no" { send "yes\r";exp_continue }
"*password:" { send "password\r" }
}
expect "*#"
send "cd /opt/\n"
send "scp -o StrictHostKeyChecking=no logger@$ip:/tmp/$ip$crontabjieguo  /opt/tomcatidc/mulucrontabjieguo/\n" 
expect {
"*yes/no" { send "yes\r" }
"*password:" { send "password\r" }
}
expect "*#"
send "exit\r"
expect "*$"
expect eof
EOF
