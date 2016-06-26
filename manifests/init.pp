# Class: bsl_bootstrap
# ===========================
#
# For use in bootstrapping base images such as Puppetmaster.
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
class bsl_bootstrap(
  $init_service = $bsl_bootstrap::params::init_service,
  $init_service_tmpl = $bsl_bootstrap::params::init_service_tmpl,
  $init_config = $bsl_bootstrap::params::init_config,
  $init_config_tmpl = $bsl_bootstrap::params::init_config_tmpl,
) inherits bsl_bootstrap::params {

}
