#
#  as_array.rb
#

module Puppet::Parser::Functions
	newfunction(:as_array, :type => :rvalue, :doc => <<-EOS
		Converts object to an array (if the passed object is not array). Otherwise, just returns the array.
		EOS
	) do |arguments|
		raise(Puppet::ParseError, "as_array(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.size != 1

		value = arguments[0]
		if !value.is_a?(Array)
			value = [value]
		end

		return value
	end
end
