# Class: os_performance
# ===========================
#
# Full description of class os_performance here.
#
# Parameters
# ----------
#
# * `ensure`
#   Ensure settings are made - a reboot maybe necessary if changed
#
class os_performance (
  $ensure  = $os_performance::params::ensure
) inherits ::os_performance::params {

  # validate parameters here
  class { '::os_performance::network':
    ensure => $ensure,
  }
  class { '::os_performance::filesystem':
    ensure => $ensure,
  }
}
