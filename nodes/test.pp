node 'test.thestaticvoid.com' {
    class { 'profile::base':
        disk_profile       => cryptmirror,
        console_resolution => '1024x768',
        video_cards        => ['cirrus'],
        package_server     => 'http://packages.thestaticvoid.com/',
        roles              => ['desktop'],
    }
}
