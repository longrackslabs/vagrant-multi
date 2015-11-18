
node 'data' {
  class { 'apache': }             # use apache module

  apache::vhost { 'slalom.vm':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }

  file { "/var/www/html/index.html":
    ensure => "link",
    target => "/vagrant/data/html/index.html",
  }

  # class {'passenger':}
}

# Then install the app bits
class install-data-app {

  file {"/opt/ruby":
    ensure => "directory",
    mode => 775,
  }

  file {"/opt/ruby/data":
    ensure => "directory",
    mode => 775,
  }

  file { "/opt/ruby/data/hello-ruby.rb":
    ensure => "link",
    target => "/vagrant/data/hello-ruby.rb",
    require => [
      File["/opt/ruby"],
      File["/opt/ruby/data"]
    ]
  }

  file { "/opt/ruby/data/start.sh":
    ensure => "link",
    target => "/vagrant/data/start.sh",
    mode => 775,
    require => File["/opt/ruby/data/hello-ruby.rb"],
  }

}

class sinatra {
  package { 'sinatra' :
    ensure => 'installed',
    provider => 'gem',
  }
}

class { 'sinatra': }

class sinatra-jsonp {
  package { 'sinatra-jsonp' :
    ensure => 'installed',
    provider => 'gem',
  }
}

class {'sinatra-jsonp':}

# Ruby stuff
class { 'ruby':
  version => '1.9.3',
  gems_version => 'latest',
}

include ruby::dev



class { 'install-data-app':
  require => [
    Class['ruby'],
    Class['sinatra'],
    Class['ruby::dev']
  ],
}
