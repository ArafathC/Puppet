class hadoop::secondarynamenode inherits hadoop{
require hadoop
require hadoop::resourcemanager
Exec{
        path => ["/usr/bin","/usr/sbin","/bin"],
    }

exec { 'start secondarynamenode':
    #cwd    => '$hadoop_home/sbin/',
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/hadoop-daemon.sh --script hdfs start secondarynamenode",
    #require => Exec['format namenode'],
        # hasstatus => true,
        # subscribe => File['/etc/hadoop/conf/core-site.xml'], File['/etc/hadoop/conf/hdfs-site.xml'], File['/etc/had
#oop/conf/hadoop-env.sh']],
  }
}
