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

  include 'bsl_bootstrap::puppetmaster::config'

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_hostname) {
    class { 'bsl_puppet::server::hostname':
    hostname => $bsl_bootstrap::puppetmaster::config::hostname,
    domain => $bsl_bootstrap::puppetmaster::config::domain,,
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_puppetdb) {
    class { 'bsl_puppet::server::puppetdb':
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_hiera) {
    class { 'bsl_puppet::server::hiera':
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_r10k) {
    class { 'bsl_puppet::server::r10k':
      webhooks_enabled => $bsl_bootstrap::puppetmaster::config::r10k_manage_webhooks,
      webhook_user     => $bsl_bootstrap::puppetmaster::config::r10k_webhook_user,
      webhook_pass     => $bsl_bootstrap::puppetmaster::config::r10k_webhook_pass,
      sources          => $bsl_bootstrap::puppetmaster::config::r10k_souurces,
    }

    if $bsl_bootstrap::puppetmaster::config::r10k_init_deploy_enabled {
      include 'bsl_puppet::server::r10k::deploy'
    }
  }

  if str2bool($bsl_bootstrap::puppetmaster::config::manage_puppetboard) {
    include 'bsl_puppet::server::puppetboard'
  }
}