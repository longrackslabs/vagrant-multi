
exec { "apt-get update":
    command => "/usr/bin/apt-get update",
}

# Web server, web app, etc.
package { "apache2":
  ensure => present,
  require => Exec["apt-get update"],
}

service { "apache2":
  ensure => running,
  require => Package["apache2"],
}

file { "/var/www/html/sample-webapp":
  ensure => "link",
  target => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify => Service["apache2"],
}

# Ruby stuff
class ruby {
  package { "build-essential":
    ensure => present,
    require => Exec["apt-get update"],
  }

  package { "ruby":
    ensure => present,
    require => Exec["apt-get update"],
  }
}

class sinatra {
  package { 'sinatra' :
    ensure => 'installed',
    provider => 'gem',
  }
}

# Then install the app bits
class install-sample-ruby-app {

  file {"/opt/ruby":
    ensure => "directory",
    mode => 775,
  }

  file {"/opt/ruby/sample-ruby":
    ensure => "directory",
    mode => 775,
  }

  file { "/opt/ruby/sample-ruby/hello-ruby.rb":
    ensure => "link",
    target => "/vagrant/sample-ruby/hello-ruby.rb",
    require => [
      File["/opt/ruby"],
      File["/opt/ruby/sample-ruby"]
    ]
  }

}

class { 'install-sample-ruby-app': }
class { 'sinatra': }
include apt
