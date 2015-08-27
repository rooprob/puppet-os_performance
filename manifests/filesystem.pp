# == Class os_performance::filesystem
#
# This class is called from os_performance for service filesystem.
#
class os_performance::filesystem {

  sysctl { 'fs.file-max':
    ensure    => 'present',
    value     => '100000',
  }

  # Discourage Linux from swapping idle processes to disk (default = 60)
  sysctl { 'vm.swappiness':
    ensure    => 'present',
    value     => '10',
  }

  include ulimit

  ulimit::rule {
    'all_nofile_soft':
      ulimit_domain => '*',
      ulimit_type   => 'soft',
      ulimit_item   => 'nofile',
      ulimit_value  => '1024';
    'all_nofile_hard':
      ulimit_domain => '*',
      ulimit_type   => 'hard',
      ulimit_item   => 'nofile',
      ulimit_value  => '50000';
  }
}
