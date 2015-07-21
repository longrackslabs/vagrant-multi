# Node.js app stuff
class { 'nodejs': }

# then pm2
class { 'pm2-gp': }

class pm2-gp {

  file {"/opt/nodejs":,
    ensure => "directory",
    mode => 775,
    before => Exec['install npm package pm2']
  }

  exec { 'install npm package pm2':
    command => "/usr/bin/npm install --unsafe-perm -g pm2",
    require => Class["nodejs"],
  }
}

class { 'install-sample-node-app': }

# Then install the app bits
class install-sample-node-app {

  file {"/opt/nodejs/sample-node":,
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

  exec { "npm install" :
    cwd => "/opt/nodejs/sample-node",
    user => "root",
    path => "/usr/bin",
    require => [
      File["/opt/nodejs/sample-node"],
      File["/opt/nodejs/sample-node/app.js"],
      File["/opt/nodejs/sample-node/package.json"],
      Class["pm2-gp"]
    ]
  }
}

# Install node, pm2, app, and then start it
class start-sample-node-app {
  exec { 'start sample node app':
    require => [
      Class["install-sample-node-app"]
    ],
    cwd => "/opt/nodejs/sample-node",
    # command => "/usr/bin/pm2 start /opt/nodejs/sample-node/app.js 2>&1&",
    command => "/usr/bin/sudo env PATH=$PATH:/usr/bin pm2 startup /opt/nodejs/sample-node/app.js -u vagrant"
  }
}

class { 'start-sample-node-app': }
