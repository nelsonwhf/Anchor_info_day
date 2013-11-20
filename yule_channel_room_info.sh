#!/bin/sh

dt=$1
echo $dt

#rm check_yule_channel_room_*

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidolimit;\\
insert overwrite table datamine.datamine_whf_channel_room_day partition(type=1,dt='$dt') \\
select c.uid,c.roomcid,c.sid,c.asid,d.name,c.channel_name,d.typestr,c.channel_typestr,d.type,c.channel_type from \\
(select a.uid as uid,a.roomcid as roomcid,a.contractcid as sid,b.asid as asid,b.name as channel_name,b.typestr as channel_typestr,b.type as channel_type from \\
(select uid,roomcid,contractcid from original_yule_room_user_day where dt='$dt' and status=4)a \\
left outer join \\
(select sid,typestr,name,type,asid from warehouse.base_channel_info)b \\
on (a.contractcid=b.sid))c \\
left outer join \\
(select sid,typestr,name,type,asid from warehouse.base_channel_info)d \\
on (c.roomcid=d.sid);"

#touch check_yule_channel_room_$dt
