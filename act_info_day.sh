#!/bin/sh

dt=` date -d "-1 day" "+%Y%m%d" `
echo $dt

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidolimit;\\
create temporary function ToArray as 'com.duowan.yy.etl.hive.ToArray';\\
insert overwrite table datamine.datamine_whf_act_info_day partition(dt='$dt') \\
select d.uid,concat_ws(',',d.aid_array),concat_ws(',',d.type_array),\\
concat_ws(',',d.sub_type_array),concat_ws(',',d.name_array) from \\
(select c.uid as uid,ToArray(distinct c.aid) as aid_array,ToArray(distinct c.type) as type_array,\\
ToArray(distinct c.sub_type) as sub_type_array,ToArray(distinct c.name) as name_array from \\
(select a.anchor_uid as uid,b.aid as aid,b.type as type,b.sub_type as sub_type,b.name as name from \\
(select anchor_uid,cast(act_id as string) as act_id from original_anchor_living_act_day where dt='$dt')a \\
join \\
(select cast(aid as string) as aid,cast(type as string) as type,cast(sub_type as string) as sub_type,name from original_act_info_day where dt<='$dt')b \\
on (a.act_id=b.aid))c \\
group by c.uid)d;"
