class base {
  package { "git":
    ensure => present
  }
  package { "lynx":
    ensure => present
  }
  package { "nano":
    ensure => present
  }
  exec { "grab-epel":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    alias   => "grab-epel",
  }
  exec { "grab-webtatic":
    command => "/bin/rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm",
    creates => "/etc/yum.repos.d/webtatic.repo",
    alias   => "grab-webtatic",
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

class mysql {
  # Installs the MySQL server and MySQL client
  package { 
    ['mysql-server', 
     'mysql',
     'mysql-devel']: 
      ensure => installed, 
  }
  file { "/etc/my.cnf":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/mysqld/my.cnf",
  }   
  
  service { 'mysqld':
    name   => 'mysqld',
    require => Package['mysql-server'],
    ensure => running,
    enable => true,
  }
 }
 

class php {

  package { "php55w":
    ensure => present
  }
  package { "php55w-opcache":
    ensure => present
  }
  package { "php55w-cli":
    ensure => present
  }
  package { "php55w-common":
    ensure => present
  }
  package { "php55w-gd":
    ensure => present
  }
  package { "php55w-pdo":
    ensure => present
  }
  package { "php55w-mysql":
    ensure => present
  }
  package { "php55w-xml":
    ensure => present
  }  
  package { "php55w-pear":
    ensure => present
  }  
  package { "php55w-mbstring":
    ensure => present
  }
  package { "php55w-pecl-xdebug":
    ensure => installed
  }

  package { "php55w-devel":
    ensure => present
  }
  package { "pcre-devel":
    ensure => present
  }
  #package { "php-pecl-apc":
  #  ensure => present
  #}
  #package { "php-pecl-memcached":
  #  ensure => present,
  #}
  file { "/etc/php.ini":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/php/php.ini",
  }
  file {"/etc/php/":
    replace => false,
    ensure => directory,
    recurse => true,
  }
  file { "/etc/php/php.d/":
    replace => false,
	ensure => directory,
	recurse => true,
  }
  file { "/etc/php/php.d/apc.ini":
    replace => true,
    ensure  => file,
    source  => "/vagrant/files/php/php.d/apc.ini",
  }  
  file { "/etc/php.d/xdebug.ini":
    replace => true,
    ensure => file,
    source => "/vagrant/files/php/php.d/xdebug.ini",
  }

}

class memcached {
  package { "memcached":
    ensure => present,
  }
  service { "memcached":
    ensure => running,
    enable => true,
  }
}

class extras {
  package { "htop":
    ensure => present,
    require => Exec("grab-epel"),
  }    
  package { "pv":
    ensure => present,
    require => Exec("grab-epel"),
  } 
}


include base
include httpd
include mysql
include php
include memcached
include extras
include extras