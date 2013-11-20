#!/bin/sh

type=$1
file=$2

/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;set mapred.job.queue.name=hiidoagentlimit;\\
insert overwrite local directory 'uid_list_${type}_tmp_bak' \\
select c.yyid,c.sid,c.channel_typestr,c.mau from \\
(select a.yyid as yyid,a.sid as sid,a.channel_typestr as channel_typestr,if(b.mau is null,0,b.mau) as mau from \\
(select yyid,split(sid,',')[0] as sid,channel_typestr from datamine_whf_anchor_info where anchor_type=$type and sid is not null)a \\
left outer join \\
(select count(distinct uid) as mau,sid from warehouse.base_channel_server_duration_day where dr>0 and dt>='20131001' group by sid)b \\
on (a.sid=b.sid))c \\
order by c.mau desc \\
limit 200000"
cat uid_list_${type}_tmp_bak/* > ${file}.bak
rm -r uid_list_${type}_tmp_bak
cat ${file}.bak | tr '\001' '\t' | awk '{print $1," ",$2," ",$3}' > ${file}
rm ${file}.bak
