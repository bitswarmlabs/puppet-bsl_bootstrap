# Class: bsl_bootstrap::puppetmaster::setup
# ===========================
#
# For use in bootstrapping base images such as Puppetmaster.
#
# Examples
# --------
#
# @example
#    class { 'bsl_bootstrap::prepare':
#      app_project => 'base',
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
class bsl_bootstrap::puppetmaster::setup {
  hiera_include('classes')

  include 'bsl_puppet::server'
  include 'bsl_bootstrap::puppetmaster::config'

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_hostname) {
    class { 'bsl_puppet::server::hostname':
      hostname => $bsl_bootstrap::puppetmaster::config::hostname,
      domain   => $bsl_bootstrap::puppetmaster::config::domain,
    }
    ->Class['bsl_puppet::server']
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_puppetdb) {
    class { 'bsl_puppet::server::puppetdb':
      database_host        => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_host,
      database_username    => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_user,
      database_password    => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_pass,
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_hiera) {
    class { 'bsl_puppet::server::hiera':
      hiera_config_path => $bsl_bootstrap::puppetmaster::config::hiera_config_path,
      datadir           => $bsl_bootstrap::puppetmaster::config::hiera_datadir,
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_r10k) {
    class { 'bsl_puppet::server::r10k':
      webhooks_enabled => $bsl_bootstrap::puppetmaster::config::r10k_manage_webhooks,
      webhook_user     => $bsl_bootstrap::puppetmaster::config::r10k_webhook_user,
      webhook_pass     => $bsl_bootstrap::puppetmaster::config::r10k_webhook_pass,
      sources          => $bsl_bootstrap::puppetmaster::config::r10k_sources,
    }

    if $bsl_bootstrap::puppetmaster::config::r10k_init_deploy_enabled {
      class { 'bsl_puppet::server::r10k::deploy':
      }
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_puppetboard) {
    class { 'bsl_puppet::server::puppetboard':
    }
  }
}
