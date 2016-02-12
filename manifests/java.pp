#java.pp
class artifactory::java (
$package_java_name    = $artifactory::params::package_java_name
) inherits artifactory::params {
   package { "${package_java_name}":
   provider => $repo_type,
   ensure   => 'installed',
    }
}

