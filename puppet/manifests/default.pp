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

# pm2
class pm2-gp {

  file {"/opt/nodejs":,
    ensure => "directory",
    mode => 775,
  }

  exec { 'install npm package pm2':
    command => "/usr/bin/sudo /usr/bin/npm install --unsafe-perm -g pm2",
    require => File["/opt/nodejs"],
  }
} 

# Node.js app stuff
class { 'nodejs': }
class { 'pm2-gp': }

class sample-node-app {

  file {["/opt/nodejs/sample-node"]:,
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
}

class {'sample-node-app':
  require => [
    Class["nodejs"],
    Class["pm2-gp"],
  ]
}

class npm-install {

  exec { "npm install" :
    cwd => "/opt/nodejs/sample-node",
    user => "root",
    path => "/usr/bin",
    require => Class["sample-node-app"],
  }
}

class { 'npm-install': }

exec { 'start sample node app':
  cwd => "/opt/nodejs/sample-node",
  command => "/usr/bin/pm2 --silent start app.js 2>&1&",
  require => Class["npm-install"]
}
