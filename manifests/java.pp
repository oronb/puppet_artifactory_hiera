#java.pp
class artifactory::java (
#$java_version         = artifactory::params::java_version,
$package_java_name    = $artifactory::params::package_java_name
) inherits artifactory::params {
   package { "${package_java_name}":
   #provider => $repo_type,
   ensure   => 'installed',
   #source   => "/tmp/${package_name}-${version}.${repo_type}",
   #require  => Exec["download ${package_name}-${version}"]
    }
}

