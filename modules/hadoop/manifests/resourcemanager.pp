class hadoop::resourcemanager inherits hadoop{
require hadoop

exec { 'start resourcemanager':
    command => "/usr/lib/hadoop/hadoop-2.6.0/sbin/yarn-daemon.sh start resourcemanager",
    
  }
}
