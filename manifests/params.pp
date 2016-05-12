# Class: bsl_bootstrap::params
# ===========================
#
# Shared default parameters
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
class bsl_bootstrap::params {
  $bsl_bootstrap_scm_clone_url = 'https://github.com/bitswarmlabs/puppet-bsl_bootstrap.git'
  $bsl_bootstrap_module_home = "/etc/puppetlabs/code/modules/bsl_bootstrap"
  $bsl_bootstrap_module_version = 'latest'

  $puppet_binary = '/opt/puppetlabs/bin/puppet'

  # OS specific paths
  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease != '7' {
        $init_service        = '/usr/lib/systemd/system/bsl_bootstrap.service'
        $init_service_tmpl   = 'bsl_bootstrap.redhat.service'
        $init_config         = '/etc/sysconfig/bsl_bootstrap'
        $init_config_tmpl    = 'bsl_bootstrap.redhat.sysconfig'
      }
      else {
        fail("${::hostname}: This module does not support osfamily ${::osfamily} version ${::operatingsystemrelease}")
      }
    }
    'Debian': {
      $init_service          = '/etc/init.d/bsl_bootstrap'
      $init_service_tmpl     = 'bsl_bootstrap.debian.init'
      $init_config           = '/etc/default/bsl_bootstrap'
      $init_config_tmpl      = 'bsl_bootstrap.debian.default'
    }
    'Gentoo': {
      $init_service          = '/etc/init.d/bsl_bootstrap'
      $init_service_tmpl     = 'bsl_bootstrap.gentoo.init'
      $init_config           = '/etc/default/bsl_bootstrap'
      $init_config_tmpl      = 'bsl_bootstrap.gentoo.default'
    }
    'Suse': {
      if $::operatingsystemrelease >= '12' {
        $init_service        = '/etc/systemd/system/bsl_bootstrap.service'
        $init_service_tmpl   = 'bsl_bootstrap.suse.service'
        $init_config         = '/etc/sysconfig/bsl_bootstrap'
        $init_config_tmpl    = 'bsl_bootstrap.suse.sysconfig'
      }
      else {
        fail("${::hostname}: This module does not support osfamily ${::osfamily} version ${::operatingsystemrelease}")
      }

    }
    'Linux': {
      case $::operatingsystem {
        'Amazon': {
          $init_service      = '/etc/init.d/bsl_bootstrap'
          $init_service_tmpl = 'bsl_bootstrap.amazon.service'
          $init_config       = '/etc/sysconfig/bsl_bootstrap'
          $init_config_tmpl  = 'bsl_bootstrap.suse.sysconfig'
        }
        default: {
          fail("${::hostname}: This module does not support operatingsystem ${::operatingsystem}")
        }
      }
    }
    default: {
      fail("${::hostname}: This module does not support osfamily ${::osfamily}")
    }
  }
}
