

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

#class { 'ansible':
#  ensure => master
#}
#class { 'ansible':}


# Ruby stuff
class { 'ruby':
  gems_version  => 'latest'
}

class { 'install-data-app':
  require => [
    Class['ruby'],
    Class['sinatra'],
  ],
}
