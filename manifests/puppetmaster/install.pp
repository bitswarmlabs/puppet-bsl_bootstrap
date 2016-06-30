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
  $enable = 'true',
) {
  include '::systemd'
  include 'bsl_bootstrap'
  include 'bsl_bootstrap::puppetmaster::config'

  # always make these services stopped, they should only start at boot
  $svc_ensure = 'stopped'
  $svc_enable = str2bool($enable)

  file { $bsl_bootstrap::puppetmaster::config::init_early_service:
    ensure  => file,
    mode    => "0755",
    content => template("bsl_bootstrap/puppetmaster/${bsl_bootstrap::puppetmaster::config::init_early_service_tmpl}.erb"),
    notify  => Service[$bsl_bootstrap::puppetmaster::config::init_early_svc],
    before  => Service[$bsl_bootstrap::puppetmaster::config::init_early_svc],
  }~>
  Exec['systemctl-daemon-reload']

  file { $bsl_bootstrap::puppetmaster::config::init_early_config:
    ensure  => file,
    mode    => "0644",
    content => template("bsl_bootstrap/puppetmaster/${bsl_bootstrap::puppetmaster::config::init_early_config_tmpl}.erb"),
    notify  => Service[$bsl_bootstrap::puppetmaster::config::init_early_svc],
    before  => Service[$bsl_bootstrap::puppetmaster::config::init_early_svc],
  }~>
  Exec['systemctl-daemon-reload']

  file { $bsl_bootstrap::puppetmaster::config::init_final_service:
    ensure  => file,
    mode    => "0755",
    content => template("bsl_bootstrap/puppetmaster/${bsl_bootstrap::puppetmaster::config::init_final_service_tmpl}.erb"),
    notify  => Service[$bsl_bootstrap::puppetmaster::config::init_final_svc],
    before  => Service[$bsl_bootstrap::puppetmaster::config::init_final_svc],
  }~>
  Exec['systemctl-daemon-reload']

  file { $bsl_bootstrap::puppetmaster::config::init_final_config:
    ensure  => file,
    mode    => "0644",
    content => template("bsl_bootstrap/puppetmaster/${bsl_bootstrap::puppetmaster::config::init_final_config_tmpl}.erb"),
    notify  => Service[$bsl_bootstrap::puppetmaster::config::init_final_svc],
    before  => Service[$bsl_bootstrap::puppetmaster::config::init_final_svc],
  }~>
  Exec['systemctl-daemon-reload']

  service { $bsl_bootstrap::puppetmaster::config::init_early_svc:
    ensure  => $svc_ensure,
    enable  => $svc_enable,
  }

  service { $bsl_bootstrap::puppetmaster::config::init_final_svc:
    ensure  => $svc_ensure,
    enable  => $svc_enable,
  }
}
