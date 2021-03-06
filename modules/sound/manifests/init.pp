class sound {
    portage::package { 'media-sound/alsa-utils':
        ensure => installed,
    }

    openrc::service { 'alsasound':
        runlevel => 'boot',
        enable   => true,
        require  => Portage::Package['media-sound/alsa-utils'],
    }
}
