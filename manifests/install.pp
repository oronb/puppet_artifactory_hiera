#install Artifactory

class artifactory::install (
  $type                           = $artifactory::params::type,
  $version                        = $artifactory::params::version,
  $user                           = $artifactory::params::user,
  $group                          = $artifactory::params::group,
  $source                         = $artifactory::params::source,
  $destination                    = $artifactory::params::destination,
  $ensure                         = $artifactory::params::ensure,
  $name                           = $artifactory::params::name,
  $repo_type                      = $artifactory::params::repo_type,
  $repo_source                    = $artifactory::params::repo_source,
  $repo_provider                  = $artifactory::params::repo_provider,
) inherits artifactory::params{

   if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  user { "${user}":
     ensure => 'present',
     system => true,
     shell  => '/bin/bash',
     home   => '/var/opt/jfrog',
     gid    => "${group}",
  }

  group { "${group}":
     ensure => 'present',
     system => true,
  }

  package { 'wget':
     ensure => 'present'
  }

  exec { "download ${package}":
    command => "wget -nc ${repo_source}",
    cwd     => "${source}",
    require => Package['wget'],
  } 

 if $artifactory_type == "undef" {
    package { "${package}":
      provider => "${repo_provider}",
      ensure   => 'latest',
      source   => "/tmp/${package}-${version}.${repo_type}",
      require  => Exec["download ${package}"]
    }
 }
 else { 
         package { "${package}":
         provider => "${repo_provider}",
         ensure   => 'latest',
         source   => "/tmp/${package}-${version}.${repo_type}",
         require  => Exec["download ${package}"]
         }   
 }

 file { "${destination}":
    ensure => 'directory',
    mode   => '0775',
    owner  => 'artifactory',
    group  => 'artifactory',
    require => Package["${package}"]
  } 

}
