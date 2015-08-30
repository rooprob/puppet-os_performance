# == Class os_performance::filesystem
#
# This class is called from os_performance for service filesystem.
#
class os_performance::filesystem(
  $ensure        = $os_performance::ensure,
  $file_max      = $os_performance::file_max,
  $swappiness    = $os_performance::swappiness,
  $ulimit_nofile = $os_performance::ulimit_nofile,
) {

  # default on 2.6 is fs/file_table.c, One file with associated inode and
  # dcache is very roughly 1K. Per default don't use more than 10% of our
  # memory for files n = (mempages * (PAGE_SIZE / 1024)) / 10;
  sysctl { 'fs.file-max':
    ensure => $ensure,
    value  => $filemax,
  }

  # From http://wiki.mikejung.biz/Sysctl_tweaks
  # Settings recommended by Brendan Gregg,

  # Discourage Linux from swapping idle processes to disk (default = 60)
  sysctl { 'vm.swappiness':
    ensure => $ensure,
    value  => $swappiness,
  }
  sysctl { 'vm.dirty_ratio':
    ensure => $ensure,
    value  => 40,
  }
  sysctl { 'vm.dirty_background_ratio':
    ensure => $ensure,
    value  => 10,
  }

  include ::ulimit

  ulimit::rule { 'all_nofile_soft':
    ensure        => $ensure,
    ulimit_domain => '*',
    ulimit_type   => 'soft',
    ulimit_item   => 'nofile',
    ulimit_value  => $ulimit_nofile
  }

  ulimit::rule { 'all_nofile_hard':
    ensure        => $ensure,
    ulimit_domain => '*',
    ulimit_type   => 'hard',
    ulimit_item   => 'nofile',
    ulimit_value  => $ulimit_nofile
  }
}
