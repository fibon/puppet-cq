# Class: cq::params
#
# This class manages some of the Adobe CQ5 parameters
#
# Parameters:
# - $cq_port - the default CQ instance port
# - $cq_mode - the default CQ instance mode
# - $vhost_port - the defalt virtual host port to listen to
# - $vhost_template - the defalt virtual host config template
# - $farm_template - the defalt dispatcher farm config template
#
# Actions:
# - No actions. Just keeps default parameter values.
#
# Requires:
# - Nothing
#
# Sample Usage:
# - $cq::params::cq_port
# - "${cq::params::cq_mode}"
#
class cq::params {

	$cq_port			=  '4502'
	$cq_mode			=  'author'

	$vhost_port			=  '80'
	$vhost_template		=  'cq/cq-vhost-default.conf.erb'
	$farm_template		=  'cq/cq-dispatcher-author-default.any.erb'	

}
