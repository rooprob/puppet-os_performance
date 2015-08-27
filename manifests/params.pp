# == Class os_performance::params
#
# This class is meant to be called from os_performance.
# It sets variables according to platform.
#
class os_performance::params {
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
