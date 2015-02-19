Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

# fix dnsmasq, which looks for /bin/test
file { '/bin/test':
   ensure => 'link',
   target => '/usr/bin/test',
}

stage { 'preinstall':
  before => Stage['main']
}
 
class apt_get_update {
  exec { 'apt-get -y update': }
}
 
class { 'apt_get_update':
  stage => preinstall
}

import "classes/*"

node default {
	include apt

	package {["php5-cli", ]:
		ensure => present,
	}

	class { 'apache': 
		mpm_module => 'prefork',
		default_vhost => false,

	}
	class {'::apache::mod::php':}
	class {'::apache::mod::rewrite':}

	$svc_host = hiera('svc_host')



	apache::vhost { 'mydefaulthost':
		port    => '8080',
		docroot => hiera('svc_path'),
		directories => [{
			path => hiera('svc_path'),
			allow_override => [ 'None' ],
			order => 'Allow,Deny',
			custom_fragment => '
				RewriteEngine On
				RewriteCond %{SCRIPT_FILENAME} -f [OR]
				RewriteCond %{SCRIPT_FILENAME} -d
				RewriteRule .+ - [L]
				
				RewriteRule ^(.*)$ /app.php [L,QSA]

				Require all granted'
		}],
	}->
	class { 'consul_client': 
		service_name => hiera('svc_name'),
		health_path  => "/usr/bin/python /vagrant/health.py http://localhost:8080/api/health",
	}


}
