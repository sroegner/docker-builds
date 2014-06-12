export JAVA_HOME=/usr
export HADOOP_PREFIX=/usr/lib/hadoop
export HADOOP_CONF_DIR=/etc/hadoop/conf
export PATH=$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:${JAVA_HOME}/bin:$PATH

export HADOOP_HEAPSIZE=1024

export HADOOP_NAMENODE_OPTS="$HADOOP_NAMENODE_OPTS"
export HADOOP_SECONDARYNAMENODE_OPTS="$HADOOP_SECONDARYNAMENODE_OPTS"
export HADOOP_DATANODE_OPTS="$HADOOP_DATANODE_OPTS"
export HADOOP_BALANCER_OPTS="$HADOOP_BALANCER_OPTS"
export HADOOP_JOBTRACKER_OPTS="$HADOOP_JOBTRACKER_OPTS"
export HADOOP_TASKTRACKER_OPTS="$HADOOP_TASKTRACKER_OPTS"

export HADOOP_USER=hadoop
export HDFS_USER=hdfs
export MAPRED_USER=mapred
export YARN_USER=yarn

export HADOOP_LOG_DIR=/var/log/hadoop
export HDFS_LOG_DIR=/var/log/hadoop
export MAPRED_LOG_DIR=/var/log/hadoop
export HADOOP_MAPRED_LOG_DIR=/var/log/hadoop
export YARN_LOG_DIR=/var/log/hadoop

export HADOOP_PID_DIR=/var/run/hadoop
export HDFS_PID_DIR=/var/run/hadoop
export MAPRED_PID_DIR=/var/run/hadoop
export HADOOP_MAPRED_PID_DIR=/var/run/hadoop
export YARN_PID_DIR=/var/run/hadoop

