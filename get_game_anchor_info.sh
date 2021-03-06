#!/bin/sh

dt=$1

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidolimit;\\
insert overwrite table datamine.datamine_whf_anchor_info_day partition(anchor_type=0,dt='$dt') \\
select a.uid,c.yyid,c.nick,c.province,c.city,c.sign,c.intro,c.sex,d.contractcid,d.asid,\\
d.roomcid,d.channel_name,d.channel_typestr,d.channel_type,d.room_name,d.room_typestr,d.room_type,\\
e.aid,e.act_type,e.act_sub_type,e.act_name,null,null,null,null,null,null,null from \\
(select distinct uid from hiidodb.original_video_live_day where appid=10057 and dt<='$dt')a \\
join \\
(select uid,channel from base_game_channel_info_day where dt='$dt' and type=1)b \\
on (a.uid=b.uid) \\
join \\
(select distinct uid,yyid,nick,province,city,sign,intro,sex from warehouse.base_user_info)c \\
on (b.uid=c.uid) \\
left outer join \\
(select uid,roomcid,contractcid,asid,room_name,channel_name,room_typestr,channel_typestr,\\
room_type,channel_type from datamine.datamine_whf_channel_room_day where type=0 and dt='$dt')d \\
on (c.uid=d.uid)
left outer join \\
(select uid,aid,act_type,act_sub_type,act_name \\
from datamine.datamine_whf_act_info_day where dt='$dt')e \\
on (d.uid=e.uid)"
