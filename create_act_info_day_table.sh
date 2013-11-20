#!/bin/sh

#/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;drop table datamine_whf_act_info_tmp;"

/data/hadoop/etl/content_tag/anchor_data_day/hcat_udb_v10/bin/hive -e "use datamine;create table datamine_whf_act_info_day(uid bigint,aid string,act_type string,\\
act_sub_type string,act_name string) partitioned by (dt string) \\
stored as RCFILE"
