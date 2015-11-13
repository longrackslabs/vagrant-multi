

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

  file { "/opt/ruby/sample-ruby/start.sh":
    ensure => "link",
    target => "/vagrant/sample-ruby/start.sh",
    mode => 775,
    require => File["/opt/ruby/sample-ruby/hello-ruby.rb"],
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
  gems_version  => 'latest'
}

class { 'install-sample-ruby-app':
  require => [
    Class['ruby'],
    Class['sinatra'],
  ],
}
