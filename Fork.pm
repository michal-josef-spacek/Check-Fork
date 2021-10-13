package Check::Fork;

use base qw(Exporter);
use strict;
use warnings;

use Config;
use Readonly;

our $ERROR_MESSAGE;
Readonly::Array our @EXPORT_OK => qw(check_fork $ERROR_MESSAGE);

our $VERSION = 0.01;

sub check_fork {
	if (! $Config{'d_fork'}) {
		$ERROR_MESSAGE = 'No fork() routine available.';
		return 0;
	}

	if (($^O eq 'MSWin32' || $^O eq 'NetWare')) {
		if (! $Config{'useithreads'}) {
			$ERROR_MESSAGE = "$^O: No interpreter-based threading implementation.";
			return 0;
		}
		if ($Config{'ccflags'} !~ /-DPERL_IMPLICIT_SYS/) {
			$ERROR_MESSAGE = "$^O: No PERL_IMPLICIT_SYS ccflags set.";
			return 0;
		}
	}

	return 1;
}

1;

__END__
