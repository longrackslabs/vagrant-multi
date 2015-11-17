
node 'web' {
  class { 'apache': }             # use apache module
  apache::vhost { 'slalom.vm':  # define vhost resource
    port    => '80',
    docroot => '/var/www/html'
  }
}
file { "/var/www/html/web":
  ensure => "link",
  target => "/vagrant/web",
  require => Class["apache"],
}
