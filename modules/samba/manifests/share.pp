define samba::share (
    $path,
    $writable   = false,
    $createmask = undef,
    $validusers = undef,
) {
    concat::fragment { "smb.conf-share-${name}":
        content => template('samba/share.erb'),
        target  => '/etc/samba/smb.conf',
    }
}
