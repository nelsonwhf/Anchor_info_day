#!/bin/sh

#/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;drop table datamine_whf_channel_room_tmp;"

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use datamine;create table datamine_whf_channel_room_day(uid bigint,roomcid string,contractcid string,\\
asid string,room_name string,channel_name string,room_typestr string,channel_typestr string,room_type string,channel_type string) \\
partitioned by (type int,dt string) \\
stored as RCFILE"
