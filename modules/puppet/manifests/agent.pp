class puppet::agent (
    $master        = 'puppet',
    $dns_alt_names = undef,
) {
    portage::package { 'app-admin/puppet':
        ensure => installed,
    }

    file { '/etc/puppet/puppet.conf':
        mode    => '644',
        owner   => 'root',
        group   => 'root',
        content => template('puppet/agent.erb'),
        require => Portage::Package['app-admin/puppet'],
        notify  => Openrc::Service['puppet'],
    }

    openrc::service { 'puppet':
        # XXX: disable for now...
        enable => false,
    }
}