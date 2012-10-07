# Definition: cq::mkdir
#
# This creates new directory (with parent directories if missing) on Linux systems
#
# Parameters:
# - The absolute $path to the directory to create
# - Whether to $clear directory after creation (might be not empty if already existed)
# - The $tarball to extract in the directory
#
# Actions:
# - Creates directory (with parent)
# - Optionally clears existing directory
# - Optionally unpacks the tarball into the directory
#
# Requires:
# - The stdlib module
#
# Sample Usage:
#
#	cq::mkdir { '/tmp/example':
#		clear		=>  true,
#	}
#
#	cq::mkdir { '/home/example':
#		tarball		=>  '/home/unpack.tar.gz',
#	}
#

define cq::dirutil(
    $path			=  $name,
    $clear			=  false,
	$tarball		=  '',
) {

	exec { "$path":
		command		=>  "mkdir -p $path",
		creates		=>  $path,
	}

	if $clear == true {
		exec { "rm -r $path/": }
	}

	if $tarball != '' {
		exec { "tar xzf $tarball":
			cwd			=>  $path,
			require		=>  Exec[ "$path" ],
		}
	}
}
