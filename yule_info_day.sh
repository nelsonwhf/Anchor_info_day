#!/bin/sh

ANCHOR_INFO_DIR=`dirname "$0"`
ANCHOR_INFO_DIR=`cd "$ANCHOR_INFO_DIR"; pwd`

export ANT_OPTS="-Xmx1024M -Dlog4j.configuration=file://$ANCHOR_INFO_DIR/log4j.properties"
#ant -lib $ANCHOR_INFO_DIR/antlib -listener org.apache.tools.ant.listener.Log4jListener -listener com.duowan.yy.ant.ext.AntExceptionListener -f $ANCHOR_INFO_DIR/get_data_test.xml get_anchor_info > /dev/null 2>&1

ant -lib $ANCHOR_INFO_DIR/antlib -listener org.apache.tools.ant.listener.Log4jListener -listener com.duowan.yy.ant.ext.AntExceptionListener -f $ANCHOR_INFO_DIR/anchor_info_data.xml get_yule_info > /dev/null 2>&1
