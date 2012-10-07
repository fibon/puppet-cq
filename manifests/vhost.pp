# Definition: cq::host
#
# This class configures Adobe CQ5 dispatcher
#
# Parameters:
# - The $domain to run virtual host on
# - The $port to run virtual host on
# - The $priority of virtual host
# -	The $cache_dir to store dispatcher cache in
# - The array of CQ $instances (host:port) to be used as renderers
# - The array of $serveraliases
# - The $vhost_template to use to generate vhost config
# - The $farm_template to use to generate dispatcher farm config
# - The $farm_file to store farm configuration
#
# Actions:
# - Configures Apache Virtual Host and Dispatcher to run with Adobe CQ5 instance(s)
#
# Requires:
# - The stdlib module
# - The cq class
#
# Sample Usage:
#
#	cq::host { 'www.example.org': }
#
#	cq::host { 'cqhost':
#		domain			=> 'test.example.org',
#		instances		=>  ['localhost:4503', '127.0.0.1:4504'],
#		cache_dir		=>  '/tmp/cq/cache',
#		vhost_template	=>  'mymodule/mytemplate',
#	}
#

define cq::vhost(
	$domain				=  $name,
	$port				=  $cq::params::vhost_port,
	$priority			=  0,
	$cache_dir			=  $cq::cache_dir,

	$instances			=  "localhost:${cq::params::cq_port}",
	$serveraliases		=  '',

	$vhost_template		=  $cq::params::vhost_template,
	$farm_template		=  $cq::params::farm_template,
	$farm_file			=  "${cq::dispatcher_dir}/$name.farm",
) {

	# Create and clean out cache directory
	cq::dirutil { "$cache_dir": clear => true }

	# Create virtual host
	apache::vhost { "${name}-vhost":
		port               =>  $port,
		docroot            =>  $cache_dir,
		ssl                =>  false,
		priority           =>  $priority,
		servername         =>  $domain,
		serveraliases      =>  $serveraliases,
		options            =>  'IncludesNOEXEC',
		configure_firewall =>  false,
		template           =>  $vhost_template,
	}

	# Create farm configuration
	file { "$farm_file":
		ensure 		=>  file,
		content		=>  template($farm_template),
		mode		=>  '0644',
		require		=>  Cq::Dirutil["$cq::dispatcher_dir"],
	}

}

# TODO: log rotate, farm file dir not exit 
