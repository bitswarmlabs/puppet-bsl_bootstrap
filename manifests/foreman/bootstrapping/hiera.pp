class bsl_bootstrap::foreman::bootstrapping::hiera {
  include 'bsl_bootstrap::foreman::bootstrapping'
  include 'bsl_bootstrap::foreman::config'

  $foreman_fqdn = $bsl_bootstrap::foreman::config::foreman_fqdn
  $hostname = $bsl_bootstrap::foreman::config::hostname
  $domain = $bsl_bootstrap::foreman::config::domain
  $default_admin_acct_name = $bsl_bootstrap::foreman::config::default_admin_acct_name
  $default_admin_acct_pass = $bsl_bootstrap::foreman::config::default_admin_acct_pass
  $external_fqdn = $bsl_bootstrap::foreman::config::external_fqdn
  $github_api_token = $bsl_bootstrap::foreman::config::github_api_token
  $r10k_sources = $bsl_bootstrap::foreman::config::r10k_sources
  $code_dir = $bsl_bootstrap::foreman::bootstrapping::code_dir

  if !empty($r10k_sources) {
    $r10k_sources_yaml = inline_template('<%= { \'bsl_bootstrap::foreman::config::r10k_sources\' => @r10k_sources }.to_yaml.gsub("---\n", "") %>')
  }
  else {
    $r10k_sources_yaml = undef
  }

  file { "${$code_dir}/hiera.yaml":
    ensure  => file,
    source  => 'puppet:///modules/bsl_bootstrap/foreman/hiera.yaml',
    require => File[$code_dir],
  }

  file { "${$code_dir}/hieradata":
    ensure  => directory,
    require => File[$code_dir],
  }

  file { "${$code_dir}/hieradata/foreman.yaml":
    ensure  => file,
    content => template('bsl_bootstrap/foreman/hieradata/foreman-yaml.erb'),
    require => File[$code_dir],
  }
}
