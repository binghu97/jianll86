#!/bin/bash
#spawn ssh  wasadmin@$ip  "echo wo > /opt/IBM/ceshi3"
#send {ps -ef|grep java|grep -v grep|grep -v dmgr|awk '{print $2}'|xargs kill -9}
cd /opt/
sed  -e 's/[ ]*$//g' /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ip.txt
sed -i 's/\r$//g'    /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ip.txt
iplist=`cat /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ip.txt`
for ip in $iplist
do
/usr/bin/expect <<-EOF
set timeout -1
set passwdlist { wasadmin { password1 password2} }
foreach {u p} \$passwdlist {
cd /opt/tomcatidc/
spawn   scp start-was-2.sh \$u@$ip:/opt/IBM/
lassign \$p s(1) s(2)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "\$s(\$i)\r";incr i;set okpasswd [expr {$i - 1}] ;exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "*]*"
send {nohup  /opt/IBM/start-was-2.sh &}
send {ls -l  /opt/IBM/start-was-2.sh &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
echo "$i was is completed!!!" >> /opt/start-was/start-was.log
done
for ip in $iplist
do
/usr/bin/expect <<-EOF
set timeout -1
set passwdlist { wasadmin { password1 password2} }
foreach {u p} \$passwdlist {
spawn  ssh \$u@$ip
lassign \$p s(1) s(2) s(3)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "\$s(\$i)\r";incr i;set okpasswd [expr {$i - 1}] ;exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "]*"
#send {ps -ef|grep java|grep -v grep|grep -v dmgr|awk '{print $2}'|xargs kill -9}
#send {nohup rm /opt/IBM/W*/A*/profiles/v*/*heapdump*}
send {nohup /opt/IBM/start-was-2.sh &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
echo "$i was is completed!!!" >> /opt/start-was/start-was.log
done
	
