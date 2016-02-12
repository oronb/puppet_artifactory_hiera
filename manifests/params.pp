#Parameter file
class artifactory::params {
	$user                        = "artifactory"
	$group                       = "artifactory"
	$version                     = hiera('artifactory::params::version','4.4.3')
	$java_version                = hiera('artifactory::params::java_version', '8')
	$source                      = "/tmp"
	$destination                 = "/opt/jfrog/artifactory"
	$package_artifactory_ensure  = "installed"

        if ($version =~ /^2/) or ($version =~ /^3/) {      #Check syntax
           $artifactory_type = 'old'
        }
	else {
   	   $artifactory_type = hiera('artifactory::params::artifactory_type', 'oss') 
        }

	case $java_version {
	      '7': {    $Xms           = hiera('artifactory::params::Xms', '512m')
		        $Xmx           = hiera('artifactory::params::Xmx', '2g')
		        $Xss           = hiera('artifactory::params::Xss', '256k')
	      		$PermSize      = hiera('artifactory::params::PermSize', '128m')
	    	        $MaxPermSize   = hiera('artifactory::params::MaxPermSize', '256m') 
              }

	      '8': {    $Xms           = hiera('artifactory::params::Xms', '512m')
	                $Xmx           = hiera('artifactory::params::Xmx', '2g')
	                $Xss           = hiera('artifactory::params::Xss', '256k') 
	      }	
	}
  
	case $::osfamily {
	     'Debian': {   $repo_type     = "deb"
		           $repo_provider = "dpkg"
               		   $package_java_name  = "openjdk-${java_version}-jdk"
                    if $artifactory_type == "pro" {
                           $package_artifactory_name    = "jfrog-artifactory-${artifactory_type}"
                           $path                        = "pool/main/j/jfrog-artifactory-${artifactory_type}-${repo_type}"
                           $repo_source                 = "http://jfrog.bintray.com/artifactory-${artifactory_type}-${repo_type}s/${path}/jfrog-artifactory-${artifactory_type}-${version}.${repo_type}"
                    }
                    if $artifactory_type == "oss" {
                           $package_artifactory_name    = "jfrog-artifactory-${artifactory_type}"
                           $path                        = "pool/main/j/jfrog-artifactory-${artifactory_type}-${repo_type}"
                           $repo_source                 = "http://jfrog.bintray.com/artifactory-${repo_type}s/${path}/jfrog-artifactory-${artifactory_type}-${version}.${repo_type}"
                    }
             }
	     'Redhat': { 
	                   $repo_type           = "rpm" 
		           $repo_provider       = "rpm" 
			   $package_java_name   = "java-1.${java_version}.0-openjdk"
	                 if $artifactory_type == "pro" {
	                   $package_artifactory_name    = "jfrog-artifactory-${artifactory_type}"
	                   $path                        = "org/artifactory/${artifactory_type}/${repo_type}/jfrog-artifactory-${repo_type}/${version}"
	                   $repo_source                 = "http://jfrog.bintray.com/artifactory-${artifactory_type}-${repo_type}s/$path/jfrog-artifactory${artifactory_type}-${version}.${repo_type}"
	                 }
	                 if  $artifactory_type == "oss" {
	                   $package_artifactory_name    = "jfrog-artifactory-${artifactory_type}"
	                   $repo_source                 = "http://jfrog.bintray.com/artifactory-${repo_type}s/jfrog-artifactory-${artifactory_type}-${version}.${repo_type}"
	                 }
	                 if  $artifactory_type == "old" { 
	                   $package_artifactory_name    = "artifactory"
	                   $repo_source                 = "http://jfrog.bintray.com/artifactory-${repo_type}s/artifactory-${version}.${repo_type}"
	                }
	     }
      }
}
