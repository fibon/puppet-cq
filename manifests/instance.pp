# Definition: cq::instance
#
# This class installs and configures Adobe CQ5 instance
#
# Parameters:
# - The $port to run the instance on
# - The $mode to run the instance with ('author', 'publish')
# - The $dir to install CQ in
# - The $jar_name to be used by this instance
# - The $cq_jar to install
# - The $cq_license to use
# - The $daemon_script
# - The $daemon_template
#
# Actions:
# - Installs and configures CQ5 instance
#
# Requires:
# - The stdlib module
# - The cq class
#
# Sample Usage:
#
#	cq::instance { 'myauthor': }
#
#	cq::instance { 'mypublish': }
#		port			=>  '5555',
#		mode			=>  'publish',
#		cq_license		=>  '/home/cq/license.properties',
#  }
#

define cq::instance(
    $port			=  $cq::params::cq_port,
    $mode			=  $cq::params::cq_mode,

	$dir			=  "${cq::dir}/$name",
	$jar_name		=  "cq5-$mode-nobrowser-$port.jar",

	$cq_jar			=  $cq::cq_jar,
	$cq_license		=  $cq::cq_license,

	#TODO
	$daemon_script		= "/etc/init.d/cq5-${name}",
	$daemon_template	= 'cq/cq-service-daemon.erb',
) {

	# Ensures an instance directory exists
	cq::dirutil { "$dir": }

	# Copies CQ binaries to instance directory
	file { "$dir/$jar_name":
		ensure		=>  file,
		source		=>  $cq_jar,
		require		=>  Exec["$dir"],
	}

	# Copies CQ license to instance directory
	file { "$dir/license.properties":
		ensure		=>  file,
		source		=>  $cq_license,
		require		=>  Exec["$dir"],
	}

	# Creates CQ daemon script
	file { "${daemon_script}":
		ensure		=>  file,
		content		=>  template("${daemon_template}"),
		mode		=>  '0755',
	}

}

#TODO auto hotfixes, daemon
