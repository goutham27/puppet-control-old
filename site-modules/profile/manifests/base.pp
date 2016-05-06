class profile::base {

  $ntp_servers = hiera('profile::base::ntp_servers')

  validate_array($ntp_servers)

  include ::hello_world

  class { '::ntp':
    servers => $ntp_servers,
  }

}
