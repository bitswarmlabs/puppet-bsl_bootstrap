# Class: bsl_bootstrap::foreman::done
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
class bsl_bootstrap::foreman::done {
  class { 'bsl_bootstrap::foreman::install':
    enable => false,
  }
}
