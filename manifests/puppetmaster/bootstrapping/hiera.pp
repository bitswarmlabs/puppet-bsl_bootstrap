class bsl_bootstrap::puppetmaster::bootstrapping::hiera {
  include 'bsl_bootstrap::puppetmaster::bootstrapping'
  include 'bsl_bootstrap::puppetmaster::config'

  $puppetmaster_fqdn = $bsl_bootstrap::puppetmaster::config::puppetmaster_fqdn
  $hostname = $bsl_bootstrap::puppetmaster::config::hostname
  $domain = $bsl_bootstrap::puppetmaster::config::domain
  $default_admin_acct_name = $bsl_bootstrap::puppetmaster::config::default_admin_acct_name
  $default_admin_acct_pass = $bsl_bootstrap::puppetmaster::config::default_admin_acct_pass
  $external_fqdn = $bsl_bootstrap::puppetmaster::config::external_fqdn
  $github_api_token = $bsl_bootstrap::puppetmaster::config::github_api_token
  $r10k_sources = $bsl_bootstrap::puppetmaster::config::r10k_sources
  $r10k_sources_yaml = inline_template('<% { :bsl_bootstrap::puppetmaster::config::r10k_sources => @r10k_sources }.to_yaml.gsub("---\n", "") %>')

  $code_dir = $bsl_bootstrap::puppetmaster::bootstrapping::code_dir
  file { "${$code_dir}/hiera.yaml":
    ensure  => file,
    source  => 'puppet:///modules/bsl_bootstrap/puppetmaster/bootstrapping-hiera.yaml',
    require => File[$code_dir],
  }

  file { "${$code_dir}/hieradata":
    ensure  => directory,
    require => File[$code_dir],
  }

  file { "${$code_dir}/hieradata/puppetmaster.yaml":
    ensure  => file,
    content => template('bsl_bootstrap/hieradata-puppetmaster-yaml.erb'),
    require => File[$code_dir],
  }
}
