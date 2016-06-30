class bsl_bootstrap::puppetmaster::bootstrapping::hiera {
  include 'bsl_bootstrap::puppetmaster::bootstrapping'
  include 'bsl_bootstrap::puppetmaster::config'

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
