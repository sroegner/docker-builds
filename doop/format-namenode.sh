#!/bin/bash

#su - hdfs -c 'HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs namenode -format'
su - hdfs << EOF
echo "Formatting namenode"
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs namenode -format
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs namenode &
sleep 5
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs datanode &
sleep 5
echo "Setting up jobhistory directories in hdfs"
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done_intermediate
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done_intermediate
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /mr-history/done
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /mr-history/done
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /mr-history
echo "Setting up hdfs://app-logs"
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /app-logs
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn:hadoop /app-logs
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /app-logs
echo "Setting up user directories in hdfs"
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/mapred
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/yarn
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /user/hadoop
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R yarn /user/yarn
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R mapred /user/mapred
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chown -R hadoop /user/hadoop
echo "Setting up hdfs://tmp"
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -mkdir -p /tmp
HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec JAVA_HOME=/usr /usr/lib/hadoop-hdfs/bin/hdfs dfs -chmod -R 1777 /tmp
EOF
