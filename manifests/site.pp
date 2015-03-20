#Use the below to test if everything is fine
#file {'/tmp/example-ip':                                            # resource type file and filename
#  ensure  => present,                                               # make sure it exists
#  mode    => 0644,                                                  # file permissions
#  content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
#}

include java


node 'puppet-94c34466-bcae-40e5-9fb6-f65558065c02.novalocal' {

	include hadoop::namenode
}

node 'puppet-686bc64a-931c-4365-958d-358ecff68905.novalocal' {
	include hadoop::secondarynamenode
	include hadoop::resourcemanager

}

node 'puppet-046f708b-78db-493b-82f8-953b70cfbf2a.novalocal' {
	include hadoop::datanode
	include hadoop::nodemanager

} 
