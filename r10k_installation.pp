exec { 'create-ssh-key':
  command => 'yes y | ssh-keygen -t dsa -C "r10k" -f /root/.ssh/id_dsa -q -N ""',
  path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  creates => '/root/.ssh/id_dsa.pub',
} ->

#https://docs.puppetlabs.com/references/latest/type.html#sshkey
/*sshkey { "github.com":
  ensure => present,
  type   => "ssh-rsa",
  target => "/root/.ssh/known_hosts",
  key    => "ssh-pub-key=="
} -> */

git_deploy_key { 'add_deploy_key_to_puppet_control':
  ensure       => present,
  name         => $::fqdn,
  path         => '/root/.ssh/id_dsa.pub',
  token        => '377ad7d2ed9fa63507f8f4773625504742e6744b',
  project_name => 'lucky27/puppet-control',
  server_url   => 'https://api.github.com',
  provider     => 'github',
} ->

class { 'r10k':
  configfile => '/etc/puppetlabs/r10k/r10k.yaml',
  sources    => {
    'puppet'    => {
      'remote'  => 'git@github.com:lucky27/puppet-control.git',
      'basedir' => "${::settings::environmentpath}",
      'prefix'  => false,
    }
  },
}
