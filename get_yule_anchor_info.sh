#!/bin/sh

dt=$1

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use hiidodb;set mapred.job.queue.name=hiidolimit;\\
insert overwrite table datamine.datamine_whf_anchor_info_day partition(anchor_type=1,dt='$dt') \\
select e.uid,e.yyid,e.nick,e.province,e.city,e.sign,e.intro,e.sex,e.sid,e.asid,\\
e.roomcid,e.channel_name,e.channel_typestr,e.channel_type,e.room_name,e.room_typestr,e.room_type,\\
f.aid,f.act_type,f.act_sub_type,f.act_name,null,null,null,null,null,null,null from \\
(select a.uid as uid,b.yyid as yyid,b.nick as nick,b.province as province,b.city as city,\\
b.sign as sign,b.intro as intro,b.sex as sex,c.contractcid as sid,c.asid as asid,\\
c.roomcid as roomcid,c.channel_name as channel_name,c.channel_typestr as channel_typestr,c.channel_type as channel_type,\\
c.room_name as room_name,c.room_typestr as room_typestr,c.room_type as room_type from \\
(select distinct uid from hiidodb.original_video_live_day where appid=15012 and dt<='$dt')a \\
left outer join \\
(select distinct uid,yyid,nick,province,city,sign,intro,sex from warehouse.base_user_info)b \\
on (a.uid=b.uid) \\
left outer join \\
(select uid,roomcid,contractcid,asid,room_name,channel_name,room_typestr,channel_typestr,\\
room_type,channel_type from datamine.datamine_whf_channel_room_day where type=1 and dt='$dt')c \\
on (b.uid=c.uid))e \\
left outer join \\
(select uid,aid,act_type,act_sub_type,act_name \\
from datamine.datamine_whf_act_info_day where dt='$dt')f \\
on (e.uid=f.uid);"
