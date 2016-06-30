# Class: bsl_bootstrap::puppetmaster::done
# ===========================
#
# To be invoked after bootstrapping is successful, cleans up init scripts
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
class bsl_bootstrap::puppetmaster::done {
  class { 'bsl_bootstrap::puppetmaster::install':
    enable => false,
  }
}
