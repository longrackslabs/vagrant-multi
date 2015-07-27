
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
