

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

  file { "/etc/init/hello-ruby.conf":
    ensure => "link",
    target => "/vagrant/sample-ruby/hello-ruby.conf",
  }

  file { "/opt/ruby/sample-ruby/hello-ruby.rb":
    ensure => "link",
    target => "/vagrant/sample-ruby/hello-ruby.rb",
    require => [
      File["/opt/ruby"],
      File["/opt/ruby/sample-ruby"],
      File["/etc/init/hello-ruby.conf"]
    ]
  }

  file { "/opt/ruby/sample-ruby/start.sh":
    ensure => "link",
    target => "/vagrant/sample-ruby/start.sh",
    mode => 775,
    require => File["/opt/ruby/sample-ruby/hello-ruby.rb"],
  }

}

include 'upstart'

upstart::job { 'sample_ruby_service':
    description    => 'This is the upstart service for hello-ruby',
    chdir          => '/opt/ruby/sample-ruby',
    exec           => './start.sh',
    require        => Class['install-sample-ruby-app']
}

class { 'sinatra': }

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
