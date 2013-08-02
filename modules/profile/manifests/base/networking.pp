class profile::base::networking {
    #
    # Use DHCPCD to manage network interface (unless I'm a desktop)
    #
    unless desktop in $profile::base::roles {
        openrc::service { 'dhcpcd':
            enable => true,
        }
    }


    #
    # Is a VPN client (if it's not also a server)
    #
    unless vpn_server in $profile::base::roles {
        class { 'openvpn::client':
            server      => 'vpn.thestaticvoid.com',
            ca_cert     => '/etc/puppet/ssl/certs/ca.pem',
            client_cert => "/etc/puppet/ssl/certs/${fqdn}.pem",
            client_key  => "/etc/puppet/ssl/private_keys/${fqdn}.pem",
        }
    }
}