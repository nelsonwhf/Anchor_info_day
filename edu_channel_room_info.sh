#!/bin/sh

dt=$1
echo $dt

#rm check_edu_channel_room_*

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidoagentlimit;\\
create temporary function ToArray as 'com.duowan.yy.etl.hive.ToArray';\\
insert overwrite table datamine.datamine_whf_channel_room_day partition(type=2,dt='$dt') \\
select e.uid,concat_ws(',',e.sid_array),concat_ws(',',e.sid_array),concat_ws(',',e.asid_array),\\
concat_ws(',',e.name_array),concat_ws(',',e.name_array),concat_ws(',',e.typestr_array),\\
concat_ws(',',e.typestr_array),concat_ws(',',e.type_array),concat_ws(',',e.type_array) from \\
(select d.uid,ToArray(distinct d.sid) as sid_array,ToArray(distinct d.typestr) as typestr_array,\\
ToArray(distinct d.name) as name_array,ToArray(distinct d.type) as type_array,ToArray(distinct d.asid) as asid_array from \\
(select a.uid as uid,b.channellongid as sid,c.typestr as typestr,c.name as name,c.type as type,c.asid as asid from \\
(select cast(uid as string) as uid,cast(agencyid as string) as agencyid from edu_teacher_day where dt='$dt')a \\
join \\
(select cast(agencyid as string) agencyid,cast(channellongid as string) as channellongid from edu_agency_day where dt='$dt')b \\
on (a.agencyid=b.agencyid) \\
join \\
(select cast(sid as string) as sid,cast(typestr as string) as typestr,name,cast(type as string) as type,cast(asid as string) as asid from warehouse.base_channel_info)c \\
on (b.channellongid=c.sid))d group by d.uid)e"

#touch check_edu_channel_room_$dt
