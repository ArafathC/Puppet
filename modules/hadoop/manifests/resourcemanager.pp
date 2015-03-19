class hadoop::resourcemanager inherits hadoop{
require hadoop
#require namenode,
#Exec{
#        path => ["/usr/bin","/usr/sbin","/bin"],
#    }

#exec {'format namenode':
#        #cwd    => '$hadoop_home/bin/',
#        command => "/usr/lib/hadoop/hadoop-2.6.0/bin/hadoop namenode -format"
#}

exec { 'start resourcemanager':
    #cwd    => '$hadoop_home/sbin/',
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/yarn-daemon.sh start resourcemanager",
    #require => Exec['format namenode'],
        # hasstatus => true,
        # subscribe => File['/etc/hadoop/conf/core-site.xml'], File['/etc/hadoop/conf/hdfs-site.xml'], File['/etc/had
#oop/conf/hadoop-env.sh']],
  }
}
