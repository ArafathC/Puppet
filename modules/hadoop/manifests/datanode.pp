class hadoop::datanode inherits hadoop{
require hadoop

Exec{
        path => ["/usr/bin","/usr/sbin","/bin"],
    }

#exec {'format namenode':
#        #cwd    => '$hadoop_home/bin/',
#        command => "/usr/lib/hadoop/hadoop-2.6.0/bin/hadoop namenode -format"
#}

exec { 'start datanode':
    #cwd    => '$hadoop_home/sbin/',
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/hadoop-daemon.sh --script hdfs start datanode",
        # hasstatus => true,
        # subscribe => File['/etc/hadoop/conf/core-site.xml'], File['/etc/hadoop/conf/hdfs-site.xml'], File['/etc/had
#oop/conf/hadoop-env.sh']],
  }
}
