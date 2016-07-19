class bsl_bootstrap::foreman::bootstrapping(
  $code_dir = $bsl_bootstrap::params::code_dir,
) inherits bsl_bootstrap::params {
  include 'bsl_bootstrap::foreman::config'

  if ! defined(File[$code_dir]) {
    file { $code_dir:
      ensure => directory
    }
  }

  include 'bsl_bootstrap::foreman::bootstrapping::hiera'
}
