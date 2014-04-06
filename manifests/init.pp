# vim: sts=4 ts=4 sw=4 expandtab autoindent
#
#INSTALL xorg and configure on Freebsd 10 
#fessoga5@gmail.com
#
class xorg (
    $enabled="YES",
    $device="Device 0",
    $driver="nvidia",
    $monitor_command="1920x1080_60 +0+0; nvidia-auto-select +0+0",
) 
{
    #$rc_status = $enabled ? {
    #    true => "YES",
    #    false => "NO",
    #}

    #augeas {"rc.conf":
    #    context => "/files/etc/rc.conf",
    #    changes => ["set hald_enable $rc_status"],
    #}

    #variables
    $path_freebsd = ["/bin", "/sbin","/usr/bin", "/usr/sbin", "/usr/local/bin", "/usr/local/sbin"]
    
    #Install latest nvidia drivers
    package {"nvidia-drivers": ensure => latest,}

    #Install xorg
    package {"xorg": ensure => latest,}

    file { "/etc/X11/xorg.conf":
        replace => "yes",
        owner   => "root",
        mode    => "644",
        content => template('xorg/xorg.conf'),
        require => [Package["xorg"], Package["nvidia-drivers"]],
    }

}
