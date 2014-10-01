#!/bin/bash

su - hdfs << EOF
echo "Formatting namenode"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs namenode -format
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs namenode &
sleep 5
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs datanode &
sleep 5
echo "Setting up jobhistory directories in hdfs"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done_intermediate
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done_intermediate
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /mr-history
echo "Setting up hdfs://app-logs"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /app-logs
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /app-logs
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /app-logs
echo "Setting up user directories in hdfs"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/mapred
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/yarn
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/hadoop
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn /user/yarn
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R mapred /user/mapred
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R hadoop /user/hadoop
echo "Setting up hdfs://tmp"
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /tmp
JAVA_HOME=/usr HADOOP_ROOT_LOGGER="WARN,console" HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec  /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /tmp
EOF
