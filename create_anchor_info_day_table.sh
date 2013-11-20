#!/bin/sh

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use datamine;create table datamine_whf_anchor_info_day\\
(uid bigint,yyid bigint,nick string,province string,city string,sign string,intro string,sex int,sid string,asid string,roomcid string,\\
channel_name string,channel_typestr string,channel_type int,room_name string,room_typestr string,room_type string,act_id string,\\
act_type string,act_sub_type string,act_name string,real_name string,profile string,resume string,agency_id bigint,agency_name string,\\
teacher_type string,speciality string) partitioned by (anchor_type int,dt string) stored as RCFILE;"
