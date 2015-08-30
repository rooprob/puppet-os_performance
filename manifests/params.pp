# == Class os_performance::params
#
# This class is meant to be called from os_performance.
# It sets variables according to platform.
#
class os_performance::params {
  $ensure           = 'present'
  $file_max         = 200000
  $swappiness       = 0
  $ulimit_nofile    = 8092
  $local_port_range = '1024 65535'
  $tcp_fin_timeout  = 60

  case $::osfamily {
    'Debian': {
    }
    'RedHat', 'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
