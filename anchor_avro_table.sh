#!/bin/sh

~/hcat_udb_v10/bin/hive -e "use datamine;
create table datamine_whf_anchor_avro 
partitioned by (dt string,anchor_type int)
row format serde 
'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
stored as inputformat 
'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat' 
outputformat 
'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat' 
tblproperties ('avro.schema.literal'=
'{
 "namespace":"anchor_info_space",
 "name":"anchor_info",
 "type":"record",
 "fields":[
   {"name":"uid","type":"long"},
   {"name":"yyid","type":["long","null"]},
   {"name":"nick","type":["string","null"]},
   {"name":"province","type":["string","null"]},
   {"name":"city","type":["string","null"]},
   {"name":"sign","type":["string","null"]},
   {"name":"intro","type":["string","null"]},
   {"name":"sex","type":["int","null"]},
   {"name":"sid","type":["string","null"]},
   {"name":"asid","type":["string","null"]},
   {"name":"roomcid","type":["string","null"]},
   {"name":"channel_name","type":["string","null"]},
   {"name":"channel_typestr","type":["string","null"]},
   {"name":"channel_type","type":["string","null"]},
   {"name":"room_name","type":["string","null"]},
   {"name":"room_typestr","type":["string","null"]},
   {"name":"room_type","type":["string","null"]},
   {"name":"act_id","type":["long","null"]},
   {"name":"act_type","type":["string","null"]},
   {"name":"act_sub_type","type":["string","null"]},
   {"name":"act_name","type":["string","null"]},
   {"name":"real_name","type":["string","null"]},
   {"name":"profile","type":["string","null"]},
   {"name":"resume","type":["string","null"]},
   {"name":"agency_id","type":["long","null"]},
   {"name":"agency_name","type":["string","null"]},
   {"name":"teacher_type","type":["string","null"]},
   {"name":"speciality","type":["string","null"]}]
  }');"
