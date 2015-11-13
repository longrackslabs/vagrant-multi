
node 'web' {
  class { 'apache': }             # use apache module
  apache::vhost { 'slalom.vm':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }
}
file { "/var/www/html/sample-webapp":
  ensure => "link",
  target => "/vagrant/sample-webapp",
  require => Class["apache"],
}
