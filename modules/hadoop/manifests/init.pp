class hadoop(
	$hadoop_archive="hadoop-2.6.0.tar.gz",
	$hadoop_home="/usr/lib/hadoop/",
	$hadoop_folder="hadoop-2.6.0",
)
{
	Exec{
			path => ["/usr/bin","/usr/sbin","/bin"],
         }
# Create users hdfs,mapred,yarn

# Write Custom configuration template files 



    file { "/usr/lib/hadoop/${hadoop_archive}" :
                        ensure => "present",
                        source => "puppet:///modules/hadoop/${hadoop_archive}",
                        owner => root,
                        mode => 755,
			require => File['/usr/lib/hadoop']
        }

    exec { 'extract hadoop' :
                cwd => '/usr/lib/hadoop/',
                command => "tar -xzvf ${hadoop_archive}",
               # creates => $hadoop_home,
                require => File["/usr/lib/hadoop/${hadoop_archive}"],
        }
    
    file{ '/usr/lib/hadoop' :
                ensure => directory,
		mode => 755,
               # owner => hdfs,
               # group => hadoop,
               # require => File['/usr/lib/hadoop/${hadoop_archive}'],
        }

	

    file{ '/usr/lib/hadoop/hadoop-2.6.0/etc/hadoop/core-site.xml':
    			replace => true,
			ensure => "present",
    			source => "puppet:///modules/hadoop/core-site.xml",
			require => Exec['extract hadoop'],
			#after => File['/usr/lib/hadoop/hadoop-2.6.0/etc/hadoop/yarn-site.xml'],
    }


    file{ '/usr/lib/hadoop/hadoop-2.6.0/etc/hadoop/hdfs-site.xml':
    			replace => true,
			ensure => "present",
    			source => "puppet:///modules/hadoop/hdfs-site.xml",
			require => Exec['extract hadoop'],
			#after => File['/usr/lib/hadoop/hadoop-2.6.0/etc/hadoop/yarn-site.xml'],
    }


    file{ '/usr/lib/hadoop/hadoop-2.6.0/etc/hadoop/yarn-site.xml':
    			replace => true,
			ensure => "present",
    			source => "puppet:///modules/hadoop/yarn-site.xml",
			require => Exec['extract hadoop']
    }

    file{'/etc/profile.d/hadoop.sh':
				content => "export HADOOP_HOME=/usr/lib/hadoop/hadoop-2.6.0/\nexport HADOOP_MAPRED_HOME=/usr/lib/hadoop/hadoop-2.6.0/\nexport HADOOP_COMMON_HOME=/usr/lib/hadoop/hadoop-2.6.0/\nexport HADOOP_HDFS_HOME=/usr/lib/hadoop/hadoop-2.6.0/\nexport YARN_HOME=/usr/lib/hadoop/hadoop-2.6.0/\nexport HADOOP_COMMON_LIB_NATIVE_DIR=/usr/lib/hadoop/hadoop-2.6.0/lib/native\nexport PATH=$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin\n",			
		mode => 744,
		require => Exec['extract hadoop'],
        }

exec{'source':
	require => File['/etc/profile.d/hadoop.sh'],
	cwd => '/etc/profile.d',
        logoutput => true,
                command => "sh hadoop.sh"

}


}
