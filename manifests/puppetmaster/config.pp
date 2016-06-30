# Class: bsl_bootstrap::puppetmaster::config
# ===========================
#
# Creates a boot script for Puppetmaster nodes which will run a `puppet apply` with certain templated parameters.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Examples
# --------
#
# @example
#
# class { 'bsl_bootstrap::install::puppetmaster':
#   github_api_token         => 'fooboo123',
#
#   manage_hiera             => true,
#   manage_puppetdb          => true,
#   manage_hostname          => true,
#   manage_puppetboard       => true,
#
#   manage_r10k              => true,
#   r10k_init_deploy_enabled => false,
#   r10k_webhook_user        => 'puppet',
#   r10k_webhook_pass        => 'puppet123',
#   r10k_sources             => {
#     'local' => {
#       remote  => 'git@mygitrepo.com/r10k_site.git',
#       basedir => "/etc/puppetlabs/code/environments",
#     }
#   }
# }
#
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
class bsl_bootstrap::puppetmaster::config(
  $manage_hiera = 'true',
  $manage_puppetdb = 'false',
  $manage_hostname = 'true',
  $manage_puppetboard = 'false',
  $manage_r10k = 'true',

  $environment = 'production',
  $hostname = hiera('hostname', 'puppet'),
  $domain = hiera('domain', 'local'),
  $external_fqdn = hiera('external_fqdn', $::fqdn),
  $puppetmaster_fqdn = hiera('puppetmaster', 'puppet'),

  $github_api_token = hiera('github_api_token', false),
  $default_admin_acct_name = hiera('default_admin_acct_name', 'admin'),
  $default_admin_acct_pass = hiera('default_admin_acct_pass', 'admin'),

  $puppetdb_postgresql_host = 'localhost',
  $puppetdb_postgresql_user = 'puppetdb',
  $puppetdb_postgresql_pass = 'puppetdb',

  $r10k_init_deploy_enabled = $::bootstrapping,
  $r10k_manage_webhooks = 'false',
  $r10k_webhook_user = hiera('default_admin_acct_user', 'admin'),
  $r10k_webhook_pass = hiera('default_admin_acct_pass', 'admin'),
  $r10k_sources = undef,

  $bootstrap_classname = 'bsl_bootstrap::puppetmaster::setup',
  $init_service_facter_vars = "FACTER_bootstrapping='true' FACTER_app_project='${::app_project}'",
  $init_service_puppet_args = '--show_diff --verbose --detailed_exit_codes',
  $init_service_puppet_log = '/var/log/bsl_bootstrap.log',

  $puppetboard_user = hiera('default_admin_acct_name', 'admin'),
  $puppetboard_pass = hiera('default_admin_acct_pass', 'admin'),
) {
  if empty($domain) {
    $target_certname = $hostname
  }
  else {
    $target_certname = "${hostname}.${domain}"
  }

  $hello_world = hiera('hello_world', false)
  if $hello_world {
    notify { '## bsl_bootstrap hello_world': message => $hello_world }
  }
}
