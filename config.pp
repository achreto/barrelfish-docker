define pip_install($package = $title)
{
  exec {"pip-install_${package}":
    require => Package['python-pip'],
    command => "/usr/bin/pip install ${package}",
    unless => "/usr/bin/pip list | grep ${package}",
  }
}

exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}

class barrelfish_build {
  # Packages for building Barrelfish code
  $barrelfish_build_env = [
    'qemu-system-x86', 'qemu-system-arm', 'qemu-utils',
    'build-essential', 'bison', 'flex', 'cmake', 
    'ghc', 'libghc-src-exts-dev', 'libghc-ghc-paths-dev',
    'libghc-parsec3-dev', 'libghc-random-dev', 'libghc-ghc-mtl-dev',
    'libghc-async-dev', 'gcc-arm-linux-gnueabi', 'g++-arm-linux-gnueabi',
    'libgmp3-dev', 'cabal-install', 'curl', 'freebsd-glue',
    'libelf-freebsd-dev', 'libusb-1.0-0-dev', 
    'gcc-aarch64-linux-gnu', 'g++-aarch64-linux-gnu',
    'gdb-multiarch', 'cpio',
    # For gem5: libpython2.7, google's tcmalloc, protobuf
    'libpython2.7', 'libprotobuf10', 'libtcmalloc-minimal4',
  ]

  # Packages for building Barrelfish tech notes
  $barrelfish_build_docs = [
    'texlive-latex-base', 'texlive-latex-extra', 'texlive-latex-recommended',
    'texlive-bibtex-extra', 'texlive-extra-utils',
    'texlive-fonts-recommended', 'texlive-font-utils',
    'texlive-generic-recommended', 'texlive-generic-extra',
    'texlive-pictures', 'texlive-science', 'graphviz', 'doxygen', 'lhs2tex',
  ]

  # Packages for running Barrelfish harness
  $barrelfish_harness_env = [
    'python-pexpect', 'python-pip' , 'python-junit.xml', 'mtools', 'parted',
    'telnet'
  ]

  package { $barrelfish_build_env:
    require => Exec['apt-update'],
    ensure => 'installed',
  }

  exec { 'cabal-update':
    require => Package['cabal-install'],
    command => 'cabal update',
    user => 'root',
    path => '/usr/bin',
    environment => [ 'HOME=/root' ],
  }

  exec { 'cabal-install_bytestring-trie':
    require => Exec['cabal-update'],
    command => 'cabal install --global bytestring-trie',
    user => 'root',
    path => '/usr/bin:/bin',
    environment => [ 'HOME=/root' ],
    unless => 'cabal list --installed --simple-output | grep bytestring-trie',
  }

  exec { 'cabal-install_pretty-simple':
    require => Exec['cabal-update'],
    command => 'cabal install --global pretty-simple',
    user => 'root',
    path => '/usr/bin:/bin',
    environment => [ 'HOME=/root' ],
    unless => 'cabal list --installed --simple-output | grep pretty-simple',
  }

  package { $barrelfish_build_docs:
    require => Exec['apt-update'],
    ensure => 'installed',
  }

  package { $barrelfish_harness_env:
    require => Exec['apt-update'],
    ensure => 'installed',
  }
  pip_install { 'GitPython': }

  # Xeon Phi compiler symlinks (needs /home/netos available)
  exec { 'xeon_phi_symlink':
    command => '/home/netos/tools/mpss-3.7.1/setup_mpss.sh',
    onlyif  => '/usr/bin/test -e /home/netos',
    unless  => '/usr/bin/test -e /opt/mpss/3.7.1/sysroots'
  }
}

class util_packages {
  $utils = [
    'git', 'valgrind', 'conserver-client', 'syslinux-utils',  'wget', 'zsh',
    'python-requests',
  ]

  package { 'syslinux':
    ensure => 'purged',
  }

  package { $utils:
    require => Exec['apt-update'],
    ensure => 'installed' 
  }

}


node 'default' {
  include barrelfish_build
  include util_packages
}