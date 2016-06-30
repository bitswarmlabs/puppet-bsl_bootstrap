class bsl_bootstrap::puppetmaster::bootstrapping::hiera {
  include 'bsl_bootstrap::puppetmaster::config'

  $github_api_token = hiera('github_api_token', false)
  $puppetmaster_fqdn = hiera('puppetmaster', 'puppet')
  $default_admin_acct_name = hiera('default_admin_acct_name', 'admin')
  $default_admin_acct_pass = hiera('default_admin_acct_pass', 'admin')
  $server_external_fqdn = hiera('external_fqdn', $::fqdn)

  file { '/etc/puppetlabs/code/bsl_bootstrap/hiera.yaml':
    ensure  => file,
    source  => 'puppet:///modules/bsl_bootstrap/bootstrapping-hiera.yaml',
    require => File['/etc/puppetlabs/code/bsl_bootstrap'],
  }

  file { '/etc/puppetlabs/code/bsl_bootstrap/hieradata':
    ensure  => directory,
    require => File['/etc/puppetlabs/code/bsl_bootstrap'],
  }

  file { '/etc/puppetlabs/code/bsl_bootstrap/hieradata/puppetmaster.yaml':
    ensure  => file,
    content => template('bsl_bootstrap/hieradata-puppetmaster-yaml.erb'),
    require => File['/etc/puppetlabs/code/bsl_bootstrap'],
  }
}
