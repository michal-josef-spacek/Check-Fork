use strict;
use warnings;

use Check::Fork qw(check_fork $ERROR_MESSAGE);
use Config;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $ret = check_fork;
if ($Config{'d_fork'} || $Config{'d_pseudofork'}) {
	is($ret, 1, 'Test for successul forking.');
} else {
	ok(1, 'TODO: Support for other real example.');
}
