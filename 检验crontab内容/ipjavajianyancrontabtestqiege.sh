#!/bin/bash
#spawn ssh  wasadmin@$ip  "echo wo > /opt/IBM/ceshi3"
#send {ps -ef|grep java|grep -v grep|grep -v dmgr|awk '{print $2}'|xargs kill -9}
time=`date +%H:%M`
ps -ef|grep sh|grep scpcrontabjianyantest10|grep -v grep | grep -v $time |awk '{print $2}'|xargs kill -9
cd /opt/
cat /dev/null > /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
ps -ef|grep sh|grep  jiancecrontab|grep -v grep |awk '{print $2}'|xargs kill -9
ps -ef|grep ssh|grep logger|awk  '{print $2}'|xargs kill -9
ps -ef|grep expect|awk '{print $2}'|xargs kill -9
sleep 8s
#rm /opt/log/* -f
sed  -e 's/[ ]*$//g' /opt/tomcatidc/ipjavajianyancrontab.txt
sed -i 's/\r$//g'    /opt/tomcatidc/ipjavajianyancrontab.txt
sed  -e 's/[ ]*$//g' /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
sed -i 's/\r$//g'    /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
iplist=`cat /opt/tomcatidc/ipjavajianyancrontab.txt`
rm -f /opt/tomcatidc/qiegeipjianipcrontabyantest/x*
rm -f /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt
rm -f /opt/tomcatidc/mulucrontabjieguo/10*
sleep 5s
cp /opt/tomcatidc/ipjavajianyancrontab.txt /opt/tomcatidc/qiegeipjianipcrontabyantest/
cd  /opt/tomcatidc/qiegeipjianipcrontabyantest/
hangshu=`cat /opt/tomcatidc/ipjavajianyancrontab.txt  |wc -l`

if [ $hangshu -gt 0 ] && [ $hangshu -le 100 ];then
split -l 3  /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt -a 4 xa
elif [ $hangshu -gt 100 ] && [ $hangshu -le 800 ];then
split -l 8  /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt -a 4 xa

elif [ $hangshu -gt 800 ] && [ $hangshu -le 1500 ];then

split -l 15  /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt -a 4 xa
elif [ $hangshu -gt 1500 ] && [ $hangshu -le 2000 ];then
split -l 20  /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt -a 4 xa

else
split -l 30  /opt/tomcatidc/qiegeipjianipcrontabyantest/ipjavajianyancrontab.txt -a 4 xa
fi


#split -l 70 /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/qiegeipjianyantest/ipjavajianyan.txt -a 4 xa
sleep 12s
ln=`ls -l /opt/tomcatidc/qiegeipjianipcrontabyantest/xa*|wc -l`
ipqiegelist=`ls -l /opt/tomcatidc/qiegeipjianipcrontabyantest/xa*|awk '{print $9}'`
sleep 8s
#for num in $ipqiegelist
#do
#ipqielistttt=`cat $num`
#nohup /opt/tomcatidc/zhixingdanjianyan.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
#done
#hangshu=`cat /opt/tomcatidc/webapps/jcIDCpiliangcaozuo/upload/ipjavajianyan.txt  |wc -l`
#if  
if [ $hangshu -gt 0 ] && [ $hangshu -le 100 ];then
for num in $ipqiegelist
do
#ipqielistttt=`cat $num`
nohup /opt/tomcatidc/scpcrontabjianyantest10.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
done
sleep 115s
cat /opt/tomcatidc/mulucrontabjieguo/10*  >> /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
elif [ $hangshu -gt 100 ] && [ $hangshu -le 800 ];then

for num in $ipqiegelist
do
#ipqielistttt=`cat $num`
nohup /opt/tomcatidc/scpcrontabjianyantest10.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
done

sleep 320s
cat /opt/tomcatidc/mulucrontabjieguo/10*  >> /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
elif [ $hangshu -gt 800 ] && [ $hangshu -le 1500 ];then
for num in $ipqiegelist
do
#ipqielistttt=`cat $num`
nohup /opt/tomcatidc/scpcrontabjianyantest10.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
done
sleep 750s
cat /opt/tomcatidc/mulucrontabjieguo/10*  >> /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt

elif [ $hangshu -gt 1500 ] && [ $hangshu -le 2000 ];then
for num in $ipqiegelist
do
#ipqielistttt=`cat $num`
nohup /opt/tomcatidc/scpcrontabjianyantest10.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
done
sleep 900s
cat /opt/tomcatidc/mulucrontabjieguo/10*  >> /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
else
for num in $ipqiegelist
do
#ipqielistttt=`cat $num`
nohup /opt/tomcatidc/scpcrontabjianyantest10.sh $num  >> /opt/tomcatidc/ipjavalogzong.log &
done
	sleep 1250s
cat /opt/tomcatidc/mulucrontabjieguo/10*  >> /opt/tomcatidc/ipzhenghemulucrontabjieguo/ipjinch.txt
fi
