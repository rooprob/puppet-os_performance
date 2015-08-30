# == Class os_performance::network
#
# This class is called from os_performance for service network.
#
class os_performance::network(
  $ensure           = $os_performance::ensure,
  $local_port_range = $os_performance::local_port_range,
  $tcp_fin_timeout  = $os_performance::tcp_fin_timeout,
) {

  sysctl { 'net.ipv4.ip_local_port_range':
    ensure => $ensure,
    value  => $local_port_range,
  }

  # From http://wiki.mikejung.biz/Sysctl_tweaks
  # Settings used by Brendan Gregg
  # Being mindful of https://en.wikipedia.org/wiki/Bufferbloat

  # Increase Linux autotuning TCP buffer limits
  # Set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE
  sysctl { 'net.core.rmem_max':
    ensure => $ensure,
    value  => '16777216',
  }
  sysctl { 'net.core.wmem_max':
    ensure => $ensure,
    value  => '16777216',
  }
  sysctl { 'net.ipv4.tcp_rmem':
    ensure => $ensure,
    value  => '4096 12582912 16777216',
  }
  sysctl { 'net.ipv4.tcp_wmem':
    ensure => $ensure,
    value  => '4096 12582912 16777216',
  }
  sysctl { 'net.ipv4.tcp_max_syn_backlog':
    ensure => $ensure,
    value  => '8096',
  }
  # Raised from 128 to support bursts to 1000
  sysctl { 'net.core.somaxconn':
    ensure => $ensure,
    value  => '1000',
  }
  sysctl { 'net.core.netdev_max_backlog':
    ensure => $ensure,
    value  => '5000',
  }

  # TCP_TW_REUSE flag to allow reusing sockets in TIME_WAIT state for new connections
  sysctl { 'net.ipv4.tcp_tw_reuse':
    ensure => $ensure,
    value  => '1',
  }
  # From http://www.speedguide.net/articles/linux-tweaking-121, could cause
  # issue with detecting connections from multiple clients behind NAT, ie,
  # http://comments.gmane.org/gmane.comp.web.haproxy/15545
  # http://vincent.bernat.im/en/blog/2014-tcp-time-wait-state-linux.html
  sysctl { 'net.ipv4.tcp_tw_recycle':
    ensure => $ensure,
    value  => '0',
  }

  # Linux default ~60s
  # ss -tan state time-wait | wc -l
  # See also tcp_max_tw_buckets https://www.frozentux.net/ipsysctl-tutorial/chunkyhtml/tcpvariables.html
  sysctl { 'net.ipv4.tcp_fin_timeout':
    ensure => $ensure,
    value  => $tcp_fin_timeout,
  }

  # Disable TCP slow start on idle connections
  sysctl { 'net.ipv4.tcp_slow_start_after_idle':
    ensure => $ensure,
    value  => '0',
  }

  # UDP
  sysctl { 'net.ipv4.udp_rmem_min':
    ensure => $ensure,
    value  => '8192',
  }
  sysctl { 'net.ipv4.udp_wmem_min':
    ensure => $ensure,
    value  => '8192',
  }

  # iw10 -  tcp/ip congestion window by reducing ACKs
  # http://www.cdnplanet.com/blog/tune-tcp-initcwnd-for-optimum-performance/
  # https://ckon.wordpress.com/2013/03/11/centos-6-4-supports-iw10-tcpip-tuning/
  # https://lwn.net/Articles/508865/

  # route ip route change default via x.x.x.x dev ethX initcwnd 10 initrwnd 10
  #exec { 'route-change-initcwnd':
  #  command => 'ip route show | egrep "via \S+ dev"initcwnd 10 initrwnd 10'
  #}

  # tfo - TCP Fast Open (kernel >3.7)
  # https://bradleyf.id.au/nix/shaving-your-rtt-wth-tfo/
  # /proc/sys/net/ipv4/tcp_fastopen 1

  # Bufferbloat http://lwn.net/Articles/616241/
  sysctl { 'net.core.default_qdisc':
    ensure => $ensure,
    value  => 'fq_codel',
  }
}
