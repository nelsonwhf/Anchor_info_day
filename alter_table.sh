#!/bin/sh

/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;alter table datamine_whf_anchor_info \\
add columns (real_name string,profile string,resume string,agency_id bigint,agency_name string,teacher_type string,speciality string);"
