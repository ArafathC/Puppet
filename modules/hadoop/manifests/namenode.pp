class hadoop::namenode inherits hadoop{
	
require hadoop

Exec{
	path => ["/usr/bin","/usr/sbin","/bin"],
    }

exec {'format namenode':
	#cwd    => '$hadoop_home/bin/',
	command => "/usr/lib/hadoop/hadoop-2.6.0/bin/hadoop namenode -format"
}

exec { 'start namenode':
    #cwd    => '$hadoop_home/sbin/',
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/hadoop-daemon.sh --script hdfs start namenode",
    require => Exec['format namenode'],    
	# hasstatus => true,
   	# subscribe => File['/etc/hadoop/conf/core-site.xml'], File['/etc/hadoop/conf/hdfs-site.xml'], File['/etc/hadoop/conf/hadoop-env.sh']],
  }

  


}
