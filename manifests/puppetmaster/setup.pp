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

  if $bsl_bootstrap::puppetmaster::config::manage_hostname {
    include 'bsl_puppet::server::hostname'
    Class['bsl_puppet::server::hostname']->Class['bsl_puppet::server']
  }

  if $bsl_bootstrap::puppetmaster::config::manage_puppetdb {
    include 'bsl_puppet::server::puppetdb'
  }

  if $bsl_bootstrap::puppetmaster::config::manage_hiera {
    include 'bsl_puppet::server::hiera'
  }

  if $bsl_bootstrap::puppetmaster::config::manage_r10k {
    include 'bsl_puppet::server::r10k'
    if $bsl_bootstrap::puppetmaster::config::r10k_init_deploy_enabled {
      include 'bsl_puppet::server::r10k::deploy'
    }
  }

  if $bsl_bootstrap::puppetmaster::config::manage_puppetboard {
    include 'bsl_puppet::server::puppetboard'
  }
}