#!/bin/sh

/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;select uid,anchor_type from datamine_whf_anchor_info where yyid is null and anchor_type<=2;" > invalid_uid_list
