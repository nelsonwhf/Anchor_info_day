#!/bin/sh

/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;set mapred.job.queue.name=hiidoagentlimit;\\
insert overwrite table datamine_whf_anchor_info partition(anchor_type=21) \\
select distinct uid,yyid,nick,province,city,sign,intro,sex,sid,asid,roomcid,channel_name,channel_typestr,\\
channel_type,room_name,room_typestr,room_type,act_id,act_type,act_sub_type,act_name,real_name,\\
profile,resume,agency_id,agency_name,teacher_type,speciality from datamine_whf_anchor_info where anchor_type=2"
