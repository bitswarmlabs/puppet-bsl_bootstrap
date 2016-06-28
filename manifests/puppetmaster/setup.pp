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
  include 'bsl_bootstrap::puppetmaster::config'

  $hello_worlds = hiera('hello_worlds')
  notify { "## BSL_BOOTSTRAP HELLO FROM":
    message => join($hello_worlds, "\n  - "),
  }

  class { '::bsl_puppet':
    server                   => 'true',
    server_hostname          => $bsl_bootstrap::puppetmaster::config::hostname,
    server_domain            => $bsl_bootstrap::puppetmaster::config::domain,

    manage_hostname          => $bsl_bootstrap::puppetmaster::config::manage_hostname,
    manage_puppetdb          => $bsl_bootstrap::puppetmaster::config::manage_puppetdb,
    manage_hiera             => $bsl_bootstrap::puppetmaster::config::manage_hiera,
    manage_r10k              => $bsl_bootstrap::puppetmaster::config::manage_r10k,
    manage_r10k_webhooks     => $bsl_bootstrap::puppetmaster::config::r10k_manage_webhooks,
    manage_puppetboard       => $bsl_bootstrap::puppetmaster::config::manage_puppetboard,
    manage_dependencies      => 'true',

    puppetdb_database_host   => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_host,
    puppetdb_database_user   => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_user,
    puppetdb_database_pass   => $bsl_bootstrap::puppetmaster::config::puppetdb_postgresql_pass,

    r10k_init_deploy_enabled => $bsl_bootstrap::puppetmaster::config::r10k_init_deploy_enabled,
    r10k_webhook_user        => $bsl_bootstrap::puppetmaster::config::r10k_webhook_user,
    r10k_webhook_pass        => $bsl_bootstrap::puppetmaster::config::r10k_webhook_pass,
    r10k_sources             => $bsl_bootstrap::puppetmaster::config::r10k_sources,

    puppetboard_user         => $bsl_bootstrap::puppetmaster::config::puppetboard_user,
    puppetboard_pass         => $bsl_bootstrap::puppetmaster::config::puppetboard_pass,
    puppetboard_fqdn          => $bsl_bootstrap::puppetmaster::config::external_fqdn,

    config_via               => 'declare',
    manage_dependencies_via  => 'declare',
  }

  contain '::bsl_puppet'

  Class['::bsl_puppet']~>Service['puppetserver']
}
