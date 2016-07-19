# Class: bsl_bootstrap::foreman::prepare
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
class bsl_bootstrap::foreman::prepare
{
  # Create custom facts for puppetserver to be used in hiera resolution for init script puppet run
  include 'bsl_puppet::server::facter'

  # creates an init script to run `puppet apply` on boot in order to apply run-time configuration
  include 'bsl_bootstrap::foreman::install'

  # uploading hiera config for barebones init run
  include 'bsl_bootstrap::foreman::bootstrapping'
}
