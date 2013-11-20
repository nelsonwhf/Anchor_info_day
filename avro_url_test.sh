#!/bin/sh

~/hcat_udb_v10/bin/hive -e "use datamine;
create table datamine_whf_anchor_avro_test 
partitioned by (dt string,anchor_type int)
row format serde 
'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
stored as inputformat 
'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
outputformat 
'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
tblproperties ('avro.schema.url'='hdfs://localhost:9000/anchor_info/avro_schema/anchor_info.avsc');"
