class roles::mangodb {
    package { 'epel-release': ensure => present } ->
    package { 'python-pip':   ensure => present } ->
    package { 'python-devel': ensure => present } ->
    package { 'python-gevent': ensure => present } ->
    exec { 'install_mangodb':
        command  => "curl -o /usr/local/bin/mangodb https://github.com/dcramer/mangodb/raw/master/server.py",
        path     => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin",
        creates  => "/usr/local/bin/mangodb",
    }
}
