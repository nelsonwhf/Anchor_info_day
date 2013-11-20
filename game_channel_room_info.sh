#!/bin/sh

dt=$1
echo $dt

#rm check_game_channel_room_*

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidolimit;\\
create temporary function ToArray as 'com.duowan.yy.etl.hive.ToArray';\\
insert overwrite table datamine.datamine_whf_channel_room_day partition(type=0,dt='$dt') \\
select d.uid,concat_ws(',',d.sid_array),concat_ws(',',d.sid_array),concat_ws(',',d.asid_array),\\
concat_ws(',',d.name_array),concat_ws(',',d.name_array),concat_ws(',',d.typestr_array),\\
concat_ws(',',d.typestr_array),concat_ws(',',d.type_array),concat_ws(',',d.type_array) from \\
(select c.uid,ToArray(distinct c.sid) as sid_array,ToArray(distinct c.typestr) as typestr_array,\\
ToArray(distinct c.name) as name_array,ToArray(distinct c.type) as type_array,ToArray(distinct c.asid) as asid_array from \\
(select a.uid as uid,b.sid as sid,b.typestr as typestr,b.name as name,b.type as type,b.asid as asid from \\
(select cast(uid as string) as uid,cast(channel as string) as channel from base_game_channel_info_day where type=1 and dt='$dt')a \\
join \\
(select cast(sid as string) as sid,typestr,name,cast(type as string) as type,cast(asid as string) as asid from warehouse.base_channel_info)b \\
on (a.channel=b.sid))c group by c.uid)d"

#touch check_game_channel_room_$dt
