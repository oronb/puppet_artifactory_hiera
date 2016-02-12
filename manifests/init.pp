# == Class: artifactory
#
# This class just installs artifactory
#
#
# === Parameters
#
# [*ensure*]
#   String.  Version of artifactory to be installed or latest/present
#   Default: latest
#
#
# === Examples
#
# * Installation:
#     class { 'artifactory': }
#
#
# === Authors
#
# * Oron Bortman <orong1234@gmail.com>
#
class artifactory(
  $ajp_port  = 8019,
) {
  
  class { 'artifactory::java': } ->
  class { 'artifactory::install': } ->
  class { 'artifactory::config': } ~>
  class { 'artifactory::service': }

}
