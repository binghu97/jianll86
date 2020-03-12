#!/bin/bash
#spawn ssh  wasadmin@$ip  "echo wo > /opt/IBM/ceshi3"
#send {ps -ef|grep java|grep -v grep|grep -v dmgr|awk '{print $2}'|xargs kill -9}
cd /opt/
sed  -e 's/[ ]*$//g' /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ipfeiwaschadatasource.txt
sed -i 's/\r$//g'    /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ipfeiwaschadatasource.txt
iplist=`cat /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ipfeiwaschadatasource.txt`
for ip in $iplist
do
/usr/bin/expect <<-EOF
set timeout 1s
set passwdlist { wasadmin { pasword1 pasword2} }
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
send {nohup  rm /home/wasadmin/chafeiwassourcedandian* &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
/usr/bin/expect <<-EOF
set timeout 3s
set passwdlist { wasadmin { pasword1 pasword2} }
foreach {u p} \$passwdlist {
cd /opt/tomcatidc/
spawn   scp /opt/chafeiwassourcedandian/chafeiwassourcedandian.sh \$u@$ip:/home/wasadmin
lassign \$p s(1) s(2)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "\$s(\$i)\r";incr i;set okpasswd [expr {$i - 1}] ;exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "*]*"
#send {nohup  /opt/qifeiwas.sh &}
send {chmod a+x  /home/wasadmin/chafeiwassourcedandian* &}
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
set timeout 3s
set passwdlist { wasadmin { pasword1 pasword2} }
foreach {u p} \$passwdlist {
cd /opt/tomcatidc/
spawn   scp /opt/chafeiwassourcedandian/chafeiwassourcedandian2.sh \$u@$ip:/home/wasadmin
lassign \$p s(1) s(2)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" {send "\$s(\$i)\r";incr i;set okpasswd [expr {$i - 1}] ;exp_continue}
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
expect "*]*"
#send {nohup  /opt/qifeiwas.sh &}
send {chmod a+x  /home/wasadmin/chafeiwassourcedandian* &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
/usr/bin/expect <<-EOF
set timeout 3s
set passwdlist { wasadmin { pasword1 pasword2} }
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
send {nohup  /bin/sh /home/wasadmin/chafeiwassourcedandian.sh &}
send "\r"
send {nohup  /bin/sh /home/wasadmin/chafeiwassourcedandian2.sh &}
send "\r"
expect "]*"
send "exit\r"
}
EOF
echo "$i was is completed!!!" >> /opt/start-was/start-was.log
done
	
