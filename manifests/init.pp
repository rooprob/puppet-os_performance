# Class: os_performance
# ===========================
#
# Full description of class os_performance here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class os_performance (
) inherits ::os_performance::params {

  # validate parameters here


  include os_performance::network
  include os_performance::filesystem
}
