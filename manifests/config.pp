#== Class: artifactory::config
#
# This class configures artifactory.  It should not be called directly
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>

class artifactory::config (

  $ajp_port           = $::artifactory::ajp_port,
  $version            = $artifactory::params::version,
  $destination        = $artifactory::params::destination,

) inherits artifactory::params {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { "${destination}/tomcat/conf/server.xml":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    mode    => '0444',
    content => template('artifactory/server.xml.erb'),
    #notify  => Class['artifactory::service'],
  }

  file { "/etc${destination}/default":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    content => template('artifactory/default.erb')
  }
}
