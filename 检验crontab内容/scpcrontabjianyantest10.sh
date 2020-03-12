#!/bin/bash
lpp=`cat $1`
for ip in $lpp
do
cd /opt
/usr/bin/expect <<-EOF
set timeout 10s
set passwdlist { wasadmin { password1 password2} }
foreach {u p} \$passwdlist {
cd /opt/tomcatidc/
spawn   scp /opt/tomcatidc/jiancecrontab.sh \$u@$ip:/home/wasadmin/
lassign \$p s(1) s(2) s(3)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" { send "\$s(\$i)\r";incr i;set okpasswd [ expr {$i - 1} ] ;exp_continue }
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
}
expect eof
EOF
/usr/bin/expect <<-EOF
set timeout 10s
set passwdlist { wasadmin { password1 password2} }
foreach {u p} \$passwdlist {
cd /opt/tomcatidc/
spawn   scp /opt/tomcatidc/jiancecrontab.sh \$u@$ip:/home/wasadmin/
lassign \$p s(1) s(2) s(3)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" { send "\$s(\$i)\r";incr i;set okpasswd [ expr {$i - 1} ] ;exp_continue }
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
}
expect eof
EOF
/usr/bin/expect <<-EOF
set timeout 10s
set passwdlist { wasadmin { password1 password2} }
foreach {u p} \$passwdlist {
#spawn   ssh  \$u@$ip"/bin/sh /home/wasadmin/jiancecrontab.sh \n "
spawn   ssh  \$u@$ip
lassign \$p s(1) s(2) s(3)
set i 1
expect {
"*yes/no*"  {send "yes\r";exp_continue}
"*assword:*" { send "\$s(\$i)\r";incr i;set okpasswd [ expr {$i - 1} ] ;exp_continue }
"*]*" {send "hostname\r"}
"Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)." {puts "ipaddr:$ip password:unkonw"; exit }
}
}
expect "*$"
send {nohup /bin/sh /home/wasadmin/jiancecrontab.sh &}
send "\r"
expect "*$"
send "exit\r"
expect "*$"
expect eof
EOF
done
