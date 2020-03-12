#!/bin/sh
ip=`hostname -i`
zhuji=`hostname`
time=`date +%Y%m%d%H%M%s`
iprocess=`ps -ef|grep java|grep -v grep|grep -v ipjava|grep -v javaprostatus|awk '{print $NF}'`
#传ip，进程名给228.232
#IP=`cat /opt/IBM/shaopingtaifabuyingyongming/zongipbuchong`
#for i in $IP
#do
cd /home/wasadmin
/usr/bin/expect <<-EOF
set timeout -1
cd /home/wasadmin/
spawn   scp /home/wasadmin/datasourcetomcat.log wasadmin@10.1.208.77:/opt/release/feiwasjarwar/$ip
#lassign \$p s(1) s(2)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "password1\r" ;exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "*]*"
#send {chmod a+x  /home/wasadmin/chafeiwassourcedandian* &}
send "\r"
expect "]*"
send "exit\r"
}
EOF

/usr/bin/expect <<-EOF
set timeout -1
cd /home/wasadmin/
spawn   scp -r /home/wasadmin/ wasadmin@10.1.208.77:/opt/release/feiwasjarwar/$zhuji
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "password1\r";exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "*]*"
#send {chmod a+x  /home/wasadmin/chafeiwassourcedandian* &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
