# Ruby / Sinatras app stuff
class aptupdate {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }
}

class ruby {
  package { "build-essential":
    ensure => present,
    require => Class["aptupdate"],    
  }  

  package { "ruby":
    ensure => present,
    require => Class["aptupdate"],    
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

include aptupdate
include ruby
include sinatra
