# == Class: artifactory::service
#
# This class manages the artifactory service.
#
#
# === Authors
#
# * Oron Bortman <mail:orong1234@gmail.com>
#
class artifactory::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'artifactory':
    ensure  => running,
    enable  => true,
  }
}
