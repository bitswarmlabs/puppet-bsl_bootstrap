# Class: bsl_bootstrap::puppetmaster::install
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
class bsl_bootstrap::puppetmaster::install(
  $ensure = 'file',
) {
  include 'bsl_bootstrap'
  include 'bsl_bootstrap::puppetmaster::config'

  file { $bsl_bootstrap::init_service:
    ensure  => $ensure,
    mode    => "0755",
    content => template("bsl_bootstrap/${bsl_bootstrap::init_service_tmpl}.erb"),
    notify  => Exec['bsl_bootstrap_update_rc.d'],
  }

  file { $bsl_bootstrap::init_config:
    ensure  => $ensure,
    mode    => "0644",
    content => template("bsl_bootstrap/${bsl_bootstrap::init_config_tmpl}.erb"),
    notify  => Exec['bsl_bootstrap_update_rc.d'],
  }

  exec { 'bsl_bootstrap_update_rc.d':
    command     => 'update-rc.d bsl_bootstrap defaults',
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    logoutput   => true,
    refreshonly => true,
  }
}
