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

=pod

=encoding utf8

=head1 NAME

Check::Fork - Check fork functionality.

=head1 DESCRIPTION

TODO

=head1 SYNOPSIS

 use Check::Fork qw(check_fork $ERROR_MESSAGE);

 my $ret = check_fork();
 print $ERROR_MESSAGE."\n";

=head1 SUBROUTINES

=head2 C<check_fork>

 my $ret = check_fork();

Check possibility of forking functionality on system.
Return value is 1 as possible fork() or 0 as not possible fork().
If return value is 0, set C<$ERROR_MESSAGE> variable.

Returns 0/1.

=head1 ERRORS

 check_fork():
         Set $ERROR_MESSAGE variable if $ret is 0:
                 No fork() routine available.
                 $^O: No interpreter-based threading implementation.
                 $^O: No PERL_IMPLICIT_SYS ccflags set.

=head1 EXAMPLE

 use strict;
 use warnings;

 use Check::Fork qw(check_fork $ERROR_MESSAGE);

 if (check_fork()) {
         print "We could fork.\n";
 } else {
         print "We couldn't fork.\n";
         print "Error message: $ERROR_MESSAGE\n";
 }

 # Output on Unix with Config{'d_fork'} set:
 # We could fork.

 # Output on Unix without Config{'d_fork'} set:
 # We couldn't fork.
 # Error message: No fork() routine available.

 # Output on Windows without $Config{'useithreads'} set:
 # We couldn't fork.
 # Error message: MSWin32: No interpreter-based threading implementation.

=head1 DEPENDENCIES

L<Config>,
L<Exporter>,
L<Readonly>.

=head1 SEE ALSO

=over

=item L<Check::Socket>

Check socket functionality.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Check-Fork>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© Michal Josef Špaček 2021

BSD 2-Clause License

=head1 VERSION

0.01

=cut
