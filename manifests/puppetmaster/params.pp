class bsl_bootstrap::puppetmaster::params {

  # OS specific paths
  case $::osfamily {
    # 'RedHat': {
    #   fail("${::hostname}: This module does not support osfamily ${::osfamily} version ${::operatingsystemrelease}")
    #
    #   if $::operatingsystemmajrelease != '7' {
    #     $init_early_svc              = 'bsl-bootstrap-init'
    #     $init_early_service        = '/usr/lib/systemd/system/bsl-bootstrap-init.service'
    #     $init_early_config         = '/etc/sysconfig/bsl-bootstrap-init'
    #     $init_early_service_tmpl   = 'bsl-bootstrap-init_redhat_service'
    #     $init_early_config_tmpl    = 'bsl-bootstrap-init_redhat_sysconfig'
    #
    #     $init_final_svc              = 'bsl-bootstrap-final'
    #     $init_final_service        = '/usr/lib/systemd/system/bsl-bootstrap-final.service'
    #     $init_final_config         = '/etc/sysconfig/bsl-bootstrap-final'
    #     $init_final_service_tmpl   = 'bsl-bootstrap-final_redhat_service'
    #     $init_final_config_tmpl    = 'bsl-bootstrap-final_redhat_sysconfig'
    #   }
    #   else {
    #     fail("${::hostname}: This module does not support osfamily ${::osfamily} version ${::operatingsystemrelease}")
    #   }
    # }
    'Debian': {
      $init_early_svc              = 'bsl-bootstrap-init'
      $init_early_service          = '/etc/init.d/bsl-bootstrap-init'
      $init_early_config           = '/etc/default/bsl-bootstrap-init'
      $init_early_service_tmpl     = 'bsl-bootstrap-init_debian_init'
      $init_early_config_tmpl      = 'bsl-bootstrap-init_debian_default'

      $init_final_svc              = 'bsl-bootstrap-final'
      $init_final_service          = '/etc/init.d/bsl-bootstrap-final'
      $init_final_config           = '/etc/default/bsl-bootstrap-final'
      $init_final_service_tmpl     = 'bsl-bootstrap-final_debian_init'
      $init_final_config_tmpl      = 'bsl-bootstrap-final_debian_default'
    }
    # 'Gentoo': {
    #   $init_early_svc              = 'bsl-bootstrap-init'
    #   $init_early_service          = '/etc/init.d/bsl-bootstrap-init'
    #   $init_early_config           = '/etc/default/bsl-bootstrap-init'
    #   $init_early_service_tmpl     = 'bsl-bootstrap-init_gentoo_init'
    #   $init_early_config_tmpl      = 'bsl-bootstrap-init_gentoo_default'
    #
    #   $init_final_svc              = 'bsl-bootstrap-final'
    #   $init_final_service          = '/etc/init.d/bsl-bootstrap-init'
    #   $init_final_config           = '/etc/default/bsl-bootstrap-init'
    #   $init_final_service_tmpl     = 'bsl-bootstrap-init_gentoo_init'
    #   $init_final_config_tmpl      = 'bsl-bootstrap-init_gentoo_default'
    #
    # }
    # 'Suse': {
    #   if $::operatingsystemrelease >= '12' {
    #     $init_service        = '/etc/systemd/system/bsl_bootstrap.service'
    #     $init_service_tmpl   = 'bsl_bootstrap.suse.service'
    #     $init_config         = '/etc/sysconfig/bsl_bootstrap'
    #     $init_config_tmpl    = 'bsl_bootstrap.suse.sysconfig'
    #
    #     $init_early_svc              = 'bsl-bootstrap-init'
    #     $init_early_service          = '/etc/systemd/system/bsl-bootstrap-init.service'
    #     $init_early_config           = '/etc/sysconfig/bsl-bootstrap-init'
    #     $init_early_service_tmpl     = 'bsl-bootstrap-init_suse_service'
    #     $init_early_config_tmpl      = 'bsl-bootstrap-init_suse_sysconfig'
    #
    #     $init_final_svc              = 'bsl-bootstrap-final'
    #     $init_final_service          = '/etc/systemd/system/bsl-bootstrap-final.service'
    #     $init_final_config           = '/etc/sysconfig/bsl-bootstrap-final'
    #     $init_final_service_tmpl     = 'bsl-bootstrap-final_suse_service'
    #     $init_final_config_tmpl      = 'bsl-bootstrap-final_suse_sysconfig'
    #   }
    #   else {
    #     fail("${::hostname}: This module does not support osfamily ${::osfamily} version ${::operatingsystemrelease}")
    #   }
    # }
    # 'Linux': {
    #   case $::operatingsystem {
    #     'Amazon': {
    #       $init_service      = '/etc/init.d/bsl_bootstrap'
    #       $init_service_tmpl = 'bsl_bootstrap.amazon.service'
    #       $init_config       = '/etc/sysconfig/bsl_bootstrap'
    #       $init_config_tmpl  = 'bsl_bootstrap.suse.sysconfig'
    #     }
    #     default: {
    #       fail("${::hostname}: This module does not support operatingsystem ${::operatingsystem}")
    #     }
    #   }
    # }
    default: {
      fail("${::hostname}: This module does not support osfamily ${::osfamily}")
    }
  }
}
