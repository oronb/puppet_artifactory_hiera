#install Artifactory

class artifactory::install (
  $artifactory_type               = $artifactory::params::artifactory_type,
  $version                        = $artifactory::params::version,
  $user                           = $artifactory::params::user,
  $group                          = $artifactory::params::group,
  $source                         = $artifactory::params::source,
  $destination                    = $artifactory::params::destination,
  $package_artifactory_ensure     = $artifactory::params::package_artifactory_ensure,
  $package_artifactory_name       = $artifactory::params::package_artifactory_name,
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

  exec { "download ${package_artifactory_name}":
    command => "wget -nc ${repo_source}",
    cwd     => "${source}",
    require => Package['wget'],
  } 

 if $artifactory_type == "undef" {
    package { "${package_artifactory_name}":
      provider => "${repo_provider}",
      ensure   => 'latest',
      source   => "/tmp/${package_artifactory_name}-${version}.${repo_type}",
      require  => Exec["download ${package_artifactory_name}"]
    }
 }
 else { 
         package { "${package_artifactory_name}":
         provider => "${repo_provider}",
         ensure   => 'latest',
         source   => "/tmp/${package_artifactory_name}-${version}.${repo_type}",
         require  => Exec["download ${package_artifactory_name}"]
         }   
 }

 file { "${destination}":
    ensure => 'directory',
    mode   => '0775',
    owner  => 'artifactory',
    group  => 'artifactory',
    require => Package["${package_artifactory_name}"]
  } 

}
