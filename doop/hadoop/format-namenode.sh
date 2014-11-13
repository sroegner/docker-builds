#!/bin/bash

rm -rf /data1/hdfs/*
h=$(hostname)
rm -rf /etc/hadoop/conf
cp -r /etc/hadoop/conf.templates /etc/hadoop/conf
sed -i "s/{{ namenode_hostname }}/${h}/g" /etc/hadoop/conf/*
sed -i "s/{{ datanode_hostname }}/${h}/g" /etc/hadoop/conf/*

echo ">>> Formatting hdfs namenode on host $h now"

su - hdfs << EOF
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs namenode -format
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs namenode &
sleep 5
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs datanode &
sleep 5
echo "Setting up jobhistory directories in hdfs"
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done_intermediate
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done_intermediate
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /mr-history
echo "Setting up hdfs://app-logs"
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /app-logs
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /app-logs
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /app-logs
echo "Setting up user directories in hdfs"
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/mapred
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/yarn
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/hadoop
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn /user/yarn
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R mapred /user/mapred
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R hadoop /user/hadoop
echo "Setting up hdfs://tmp"
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /tmp
HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /tmp
echo "Done - will terminate hdfs processes now"
killall java
EOF
