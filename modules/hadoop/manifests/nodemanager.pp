class hadoop::nodemanager inherits hadoop{
require hadoop

Exec{
        path => ["/usr/bin","/usr/sbin","/bin"],
    }


exec { 'start nodemanager':
    #cwd    => '$hadoop_home/sbin/',
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/yarn-daemon.sh start nodemanager",
    #require => Exec['format namenode'],
        # hasstatus => true,
        # subscribe => File['/etc/hadoop/conf/core-site.xml'], File['/etc/hadoop/conf/hdfs-site.xml'], File['/etc/had
#oop/conf/hadoop-env.sh']],
  }
}
