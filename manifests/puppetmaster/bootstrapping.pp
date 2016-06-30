class bsl_bootstrap::puppetmaster::bootstrapping {
  if ! defined(File['/etc/puppetlabs/code/bsl_bootstrap']) {
    file { '/etc/puppetlabs/code/bsl_bootstrap':
      ensure => directory
    }
  }

  include 'bsl_bootstrap::puppetmaster::bootstrapping::hiera'
}
