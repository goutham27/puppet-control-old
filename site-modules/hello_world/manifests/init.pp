# Class: hello_world
#
class hello_world {

  file { '/root/hello_world.txt':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "Hello, world!\n",
  }

  file { '/root/test_hiera.txt':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('hello_world::message', 'default'),
  }

}
