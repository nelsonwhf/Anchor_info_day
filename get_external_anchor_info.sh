#!/bin/sh

/data1/hadoop/wanghf/hcat/bin/hive -e "use datamine;set mapred.job.queue.name=hiidoagentlimit;\\
insert overwrite table datamine_whf_anchor_info partition(anchor_type=3) \\
select b.uid,b.yyid,b.nick,b.province,b.city,b.sign,b.intro,b.sex,null,null,\\
null,null,null,null,null,null,null,\\
null,null,null,null,null,null,null,null,null,null,null from \\
(select yyid from datamine_whf_externalanchor_temp)a \\
join \\
(select distinct uid,yyid,nick,province,city,sign,intro,sex from warehouse.base_user_info)b \\
on (a.yyid=b.yyid)"
