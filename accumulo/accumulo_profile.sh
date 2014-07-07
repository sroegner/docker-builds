export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64

pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH=$PATH:$1
           else
              PATH=$1:$PATH
           fi
        fi
}

pathmunge /usr/lib/hadoop/bin
pathmunge /usr/lib/accumulo/bin
pathmunge /usr/lib/zookeeper/bin
