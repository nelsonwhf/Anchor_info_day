#!/bin/sh

sdate='20130831'

#hive -e "use datamine;create table datamine_whf_fuyepcu_tmp(sid string,apcu double,mpcu int) partitioned by (dt string);"


while [ "$sdate" \> "201303" ]
do
   dt=` date "+%Y%m" -d"$sdate + 0 day" `
/data1/hadoop/zhengmy/hcat/bin/hive -e "set mapred.job.queue.name=hiidolimit;use warehouse;\\
insert overwrite table datamine.datamine_whf_fuyemau_tmp partition(dt='$dt') \\
select a.sid as sid,count(distinct a.uid) as dau,a.type as type from \\
(select uid,sid,dt,case when uid <2000000000 then 0 \\
when uid>=2140000000 and uid<2141000000 or (uid>=2125499900 and uid<2126499900) then 1 \\
else 2 end as type \\
from base_channel_server_duration_day \\
where substr(dt,1,6)='$dt' and sid='28607506' \\
and (uid<2000000000 or (uid>=2140000000 and uid<2142000000) or (uid>=2125499900 and uid< 2126499900) or (uid>=2122499900 and uid< 2125499900) and dr>0))a \\
group by a.sid,a.type;"
  sdate=` date "+%Y%m%d" -d"$sdate - 1 month - 1 day" `
  echo "$dt done!"
done
