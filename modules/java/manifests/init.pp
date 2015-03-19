class java(
	$java_archive = "jdk-8u31-linux-x64.tar.gz",
	$java_home = "/usr/lib/jvm/jdk1.8.0_31",
	$java_folder = "jdk1.8.0_31")
	{
		Exec{

			path => ["/usr/bin","/usr/sbin","/bin"],
		}


	file { "/tmp/${java_archive}" :
			ensure => "present",
			source => "puppet:///modules/java/${java_archive}",
			owner => root,
			mode => 755,
	}

	#exec{'create folder' :
	#	cwd => '/usr/lib',
	#	#creates => jvm,
	#	command => "mkdir jvm",
	#}

	exec { 'extract jdk' :
		cwd => '/tmp',
		command => "/bin/tar xzvf ${java_archive}",
		creates => $java_home,
		require => File["/tmp/${java_archive}"],
	}

	file{ '/usr/lib/jvm' :
		ensure => directory,
		owner => root,
		require => Exec['extract jdk'],
	}

	exec{'move jdk':
		cwd => '/tmp',
		creates => $java_home,
		require => File['/usr/lib/jvm'],
		command => "mv ${java_folder} /usr/lib/jvm/",
	}

	exec{'install java':
		require => Exec['move jdk'],
		logoutput => true,
		command => "update-alternatives --install /bin/java java ${java_home}/bin/java 1"
	}
	exec{'set java':
		require => Exec['install java'],
		logoutput =>true,
		command => "update-alternatives --set java ${java_home}/bin/java"

	}


	exec{'install javac':
		require => Exec['move jdk'],
		logoutput =>true,
		command => "update-alternatives --install /bin/javac javac ${java_home}/bin/javac 1"

	}
	
	exec{'set javac':
		require => Exec['install javac'],
		logoutput =>true,
		command => "update-alternatives --set javac ${java_home}/bin/javac"
	}

	file{"/etc/profile.d/java.sh":
		content => "export JAVA_HOME=${java_home}\n export PATH=\$PATH:\$JAVA_HOME/bin\n"
	}
	
	}
