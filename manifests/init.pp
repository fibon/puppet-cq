# Class: cq
#
# This class prepares Linux operating system to run Adobe CQ5 solutions
#
# Parameters:
#
# Actions:
#   - Installs Apache
#   - Installs Dispatcher
#
# Requires:
#   - The stdlib module
#
# Sample Usage:
#
#	class { 'cq':
#		cq_bundle => '/home/cq5/cq-quickstart-5.5.0-xxx.jar',
#		cq_license => '/home/cq5/license.properties',
#		dispatcher_bundle => '/home/cq5/dispatcher-apache2.4-linux-x86-64-xxx.tar.gz',
#	}
#

class cq (
	$cq_bundle,
	$cq_license,
	$dispatcher_bundle	=  '',

	$dir				=  '/opt/cq5',
	$cache_dir			=  "$dir/cache",
	$tmp				=  '/tmp/cq5',

	$dispatcher_any		=  'dispatcher.any',
	$dispatcher_config	=  'puppet:///modules/cq/dispatcher.any',
) {

	include cq::params

	cq::dirutil { "$dir": }
	cq::dirutil { "$tmp": clear => true }

	if $dispatcher_bundle != '' {

		include apache

		$tmp_dispatcher		=  "$tmp/dispatcher"
		cq::dirutil { "$tmp_dispatcher":
			tarball		=>	$dispatcher_bundle,
			require		=>  Cq::Dirutil["$tmp"],
		}

		# Copy so to libexec
		# Create module in modules-available
		# Enable module

		$dispatcher_dir		=  "${apache::params::vdir}../dispatcher"
		cq::dirutil { "$dispatcher_dir": }
		file { "$dispatcher_dir/$dispatcher_any":
			source		=>  "$dispatcher_config",
			ensure		=>  file,
			require		=>  Cq::Dirutil["$dispatcher_dir"],
		}
	}

}
