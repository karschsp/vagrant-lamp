class base {
  package { "git":
    ensure => present
  }
  package { "lynx":
    ensure => present
  }
  exec { "grab-epel":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    alias   => "grab-epel",
  }
  package { "vim-enhanced":
    ensure  => present,
  }
  package { "w3m":
    ensure => present,
  }
  package { "telnet":
    ensure  => present,
  }         
}


class httpd {

  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  package { "mod_ssl":
    ensure  => present
  }

  service { 'httpd':
    name      => 'httpd',
    require   => Package["httpd"],
    ensure    => running,
    enable    => true
  }

  file { "/etc/httpd/conf.d/vhost.conf":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/httpd/conf.d/vhost.conf",
  }
  
  file { "/etc/httpd/conf/httpd.conf":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/httpd/conf/httpd.conf",
  }  

  # Uncomment if you want to create these folders separately

  # file { "/etc/httpd/vhosts":
  #     ensure => "directory",
  #   }
  file { "/etc/httpd/vhosts_ssl":
      ensure => "directory",
    }
  # file { "/etc/httpd/ssl":
  #     ensure => "directory",
  #   }

  # How to create a writable folder

  # file { "/var/www/share":
  #   mode   => 777,
  #   ensure => "directory",
  # }

  file { "/etc/httpd/vhosts":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/httpd/vhosts",
    recurse => true,
  }

  # Uncomment if you want to specify SSL vhosts and SSL folder for your SSL files.

  # file { "/etc/httpd/vhosts_ssl":
  #     replace => true,
  #     ensure  => present,
  #     source  => "/vagrant/files/httpd/vhosts_ssl",
  #     recurse => true,
  #   }
  # file { "/etc/httpd/ssl":
  #     replace => true,
  #     ensure  => present,
  #     source  => "/vagrant/files/httpd/ssl",
  #     recurse => true,
  #   }

}


include base
include httpd