class cups (
    $system_group = 'wheel',
    $kde          = false,
) {
    portage::package { 'net-print/cups':
        ensure => installed,
    }

    file { '/etc/cups/cups-files.conf':
        mode    => '0640',
        owner   => 'root',
        group   => 'lp',
        content => template('cups/cups-files.conf.erb'),
        require => Portage::Package['net-print/cups'],
        notify  => Openrc::Service['cupsd'],
    }

    openrc::service { 'cupsd':
        enable  => true,
        require => File['/etc/cups/cups-files.conf'],
    }

    if $kde {
        portage::package { 'kde-base/print-manager':
            ensure => installed,
        }
    }
}
