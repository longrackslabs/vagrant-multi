exec { "apt-get update":
  path => "/usr/bin",
}

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

# Node.js app stuff
class { 'nodejs': }

class { '::mysql::server':
  root_password  => 'foo',
}

file {["/opt/nodejs", "/opt/nodejs/sample-node"]:,
  ensure => "directory",
  mode => 775,
}

file { "/opt/nodejs/sample-node/app.js":
  ensure => "link",
  target => "/vagrant/sample-node/app.js",
  require => File["/opt/nodejs/sample-node"],
}

file { "/opt/nodejs/sample-node/package.json":
  ensure => "link",
  target => "/vagrant/sample-node/package.json",
  require => File["/opt/nodejs/sample-node"],
}
