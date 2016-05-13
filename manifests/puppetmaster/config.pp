# Class: bsl_bootstrap::install::puppetmaster
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
  $manage_puppetdb = 'true',
  $manage_hostname = 'true',
  $manage_puppetboard = 'false',
  $manage_r10k = 'true',
  $r10k_init_deploy_enabled = 'false',
  $r10k_manage_webhooks = 'true',
  $r10k_webhook_user = 'puppet',
  $r10k_webhook_pass = 'changeme',
  $r10k_sources = undef,
  $hostname = 'puppet',
  $domain = 'local',
  $bootstrap_classname = 'bsl_bootstrap::puppetmaster::setup',
  $environment = "${::environment}",
  $init_service_facter_vars = ""
) {
  $target_certname = "${$hostname}.${domain}"

  file { '/etc/facter/facts.d/bitswarmlabs.yaml':
    ensure => file,
    content => template("bsl_bootstrap/bitswarmlabs-facts.yaml.erb")
  }
}
