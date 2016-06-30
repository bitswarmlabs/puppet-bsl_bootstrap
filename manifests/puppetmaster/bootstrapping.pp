class bsl_bootstrap::puppetmaster::bootstrapping(
  $code_dir = $bsl_bootstrap::params::code_dir,
) inherits bsl_bootstrap::params {
  include 'bsl_bootstrap::puppetmaster::config'

  if ! defined(File[$code_dir]) {
    file { $code_dir:
      ensure => directory
    }
  }

  include 'bsl_bootstrap::puppetmaster::bootstrapping::hiera'
}
