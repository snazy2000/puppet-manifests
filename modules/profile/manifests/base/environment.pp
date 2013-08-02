class profile::base::environment {
    $is_puppet_master = puppet_master in $profile::base::roles
    $is_vpn_server = vpn_server in $profile::base::roles

    if $is_puppet_master and $is_vpn_server {
        $dns_alt_names = ['puppet.thestaticvoid.com', 'vpn.thestaticvoid.com']
    } elsif $is_puppet_master {
        $dns_alt_names = ['puppet.thestaticvoid.com']
    } elsif $is_vpn_server {
        $dns_alt_names = ['vpn.thestaticvoid.com']
    } else {
        $dns_alt_names = undef
    }

    #
    # Is a Puppet agent.
    #
    class { 'puppet::agent':
        master        => 'puppet.thestaticvoid.com',
        dns_alt_names => $dns_alt_names,
    }


    #
    # Uses a Dvorak keyboard.
    #
    class { 'keymaps':
        keymap => 'dvorak',
    }


    #
    # Is on the east coast of the US.
    #
    file { '/etc/localtime':
        ensure => link,
        target => '/usr/share/zoneinfo/America/New_York',
    }


    #
    # Has nothing to announce.
    #
    file { '/etc/motd':
        ensure => absent,
    }
}