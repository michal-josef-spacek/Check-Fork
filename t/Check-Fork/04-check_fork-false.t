use strict;
use warnings;

use Check::Fork qw(check_fork $ERROR_MESSAGE);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $test_config = {
	'd_fork' => undef,
	'd_pseudofork' => undef,
};
my $test_os = 'linux';
my $ret = check_fork($test_config, $test_os);
is($ret, 0, 'Test not forking on linux.');
is($ERROR_MESSAGE, 'No fork() routine available.', 'Test error message.');
