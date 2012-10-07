#
#  default_if_empty.rb
#

module Puppet::Parser::Functions
	newfunction(:default_if_empty, :type => :rvalue, :doc => <<-EOS
		Returns the second object if the first one is empty. Otherwise, returns the first one.
		EOS
	) do |arguments|
		raise(Puppet::ParseError, "default_if_empty(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.size != 2

		return arguments[0].empty? ? arguments[1] : arguments[0]
	end
end
