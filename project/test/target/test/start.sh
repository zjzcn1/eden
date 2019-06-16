#!/bin/sh
MAIN_CLASS="com.github.zjzcn.test.Application"

CURRENT_DIR=`dirname "$0"`
PROJECT_DIR=`cd $CURRENT_DIR && pwd`
DT=`date +"%Y%m%d_%H%M%S"`

MEM_OPTS="-Xms2g -Xmx2g -Xmn768m"
GC_OPTS="$GC_OPTS -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:CMSInitiatingOccupancyFraction=60 -XX:CMSTriggerRatio=70"
GC_OPTS="$GC_OPTS -Xloggc:$PROJECT_DIR/logs/gc_$DT.log"
GC_OPTS="$GC_OPTS -XX:+PrintGCDateStamps -XX:+PrintGCDetails"
GC_OPTS="$GC_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$PROJECT_DIR/logs/heapdump_$DT.hprof"
START_OPTS="$START_OPTS -Duser.dir=$PROJECT_DIR"
CLASS_PATH="$PROJECT_DIR:$PROJECT_DIR/config:$PROJECT_DIR/lib/*:$CLASS_PATH"

#run java
mkdir -p "$PROJECT_DIR/logs/"
exec java -server $MEM_OPTS $GC_OPTS $START_OPTS -cp $CLASS_PATH $MAIN_CLASS --spring.profiles.active=prod

