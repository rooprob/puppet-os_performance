# == Class os_performance::network
#
# This class is called from os_performance for service network.
#
class os_performance::network {

  # http://www.nateware.com/linux-network-tuning-for-2013.html#.Vd7CkNOeDGc

  sysctl { 'net.ipv4.ip_local_port_range':
    ensure    => 'present',
    value     => '10000 65000',
  }

  # Increase Linux autotuning TCP buffer limits
  # Set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE
  # Don't set tcp_mem itself! Let the kernel scale it based on RAM.
  sysctl { 'net.core.rmem_max':
    ensure    => 'present',
    value     => '16777216',
  }
  sysctl { 'net.core.rmem_default':
    ensure    => 'present',
    value     => '16777216',
  }
  sysctl { 'net.core.wmem_max':
    ensure    => 'present',
    value     => '16777216',
  }
  sysctl { 'net.core.wmem_default':
    ensure    => 'present',
    value     => '16777216',
  }
  sysctl { 'net.core.optmem_max':
    ensure    => 'present',
    value     => '40960',
  }
  sysctl { 'net.ipv4.tcp_rmem':
    ensure    => 'present',
    value     => '4096 87380 16777216',
  }
  sysctl { 'net.ipv4.tcp_wmem':
    ensure    => 'present',
    value     => '4096 65536 16777216',
  }

  # Make room for more TIME_WAIT sockets due to more clients,
  # and allow them to be reused if we run out of sockets
  # Also increase the max packet backlog
  sysctl { 'net.core.netdev_max_backlog':
    ensure    => 'present',
    value     => '50000',
  }
  sysctl { 'net.ipv4.tcp_max_syn_backlog':
    ensure    => 'present',
    value     => '30000',
  }
  sysctl { 'net.ipv4.tcp_max_tw_buckets':
    ensure    => 'present',
    value     => '2000000',
  }
  sysctl { 'net.ipv4.tcp_tw_reuse':
    ensure    => 'present',
    value     => '1',
  }
  sysctl { 'net.ipv4.tcp_fin_timeout':
    ensure    => 'present',
    value     => '10',
  }

  # Disable TCP slow start on idle connections
  sysctl { 'net.ipv4.tcp_slow_start_after_idle':
    ensure    => 'present',
    value     => '0',
  }
# If your servers talk UDP, also up these limits
  sysctl { 'net.ipv4.udp_rmem_min':
    ensure    => 'present',
    value     => '8192',
  }
  sysctl { 'net.ipv4.udp_wmem_min':
    ensure    => 'present',
    value     => '8192',
  }
}
