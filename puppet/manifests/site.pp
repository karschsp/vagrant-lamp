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
  package { "rubygems":
    ensure  => present,
  }        
}
include base