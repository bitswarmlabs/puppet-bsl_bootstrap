# Class: bsl_bootstrap::puppetmaster::puppetmaster
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
class bsl_bootstrap::puppetmaster::prepare
{
  include 'bsl_puppet::server::facter'
  include 'bsl_bootstrap::puppetmaster::install'
}
