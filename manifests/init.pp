# Class: bsl_bootstrap
# ===========================
#
# For use in bootstrapping base images such as Puppetmaster.
#
# Examples
# --------
#
# @example
#    class { 'bsl_bootstrap':
#      bsl_bootstrap_scm_clone_url => 'https://mygitrepo/puppet-bsl_bootstrap.git',
#    }
#
# Authors
# -------
#
# Reuben Avery <ravery@bitswarm.io>
#
# Copyright
# ---------
#
# Copyright 2016 Bitswarm Labs
#
class bsl_bootstrap(
  $bsl_bootstrap_module_clone_url = $bsl_bootstrap::params::bsl_bootstrap_scm_clone_url,
  $bsl_bootstrap_module_home = $bsl_bootstrap::params::bsl_bootstrap_module_home,
  $bsl_bootstrap_module_version = $bsl_bootstrap::params::bsl_bootstrap_module_version,
) inherits bsl_bootstrap::params {
  file { $bsl_bootstrap_module_home:
    ensure => directory,
  }

  $ensure = $bsl_bootstrap_module_version ? {
    /([vV]?([0-9]+\.)*[0-9]+)/ => $bsl_bootstrap_module_version,
    'latest'                   => 'latest',
    default                    => 'present',
  }

  vcsrepo { $bsl_bootstrap_module_home:
    ensure   => $ensure,
    provider => git,
    source   => $bsl_bootstrap_scm_clone_url,
    revision => 'master',
  }
}
