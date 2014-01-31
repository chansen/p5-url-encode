use strict;
use warnings;

use Test::More 'no_plan';

BEGIN {
    use_ok('URL::Encode', qw[ url_params_each
                              url_params_flat
                              url_params_mixed
                              url_params_multi ]);
}


my $enc = 'foo=1&bar=2&bar=3';

{
    my $exp = [ foo => 1, bar => 2, bar => 3 ];
    my $got = url_params_flat($enc);
    is_deeply($got, $exp, 'url_params_flat()');
}

{
    my $exp = { foo => 1, bar => [ 2, 3 ] };
    my $got = url_params_mixed($enc);
    is_deeply($got, $exp, 'url_params_mixed()');
}

{
    my $exp = { foo => [ 1 ], bar => [ 2, 3 ] };
    my $got = url_params_multi($enc);
    is_deeply($got, $exp, 'url_params_multi()');
}

{
    my @exp = qw(foo bar bar);
    my $cnt = 0;
    my $callback = sub {
        my ($key, $val) = @_;
        my $exp_key = shift @exp;
        my $exp_val = ++$cnt;
        is($key, $exp_key, 'url_params_each(): expected key');
        is($val, $exp_val, 'url_params_each(): expected value');
    };
    url_params_each($enc, $callback);
    is($cnt, 3, 'url_params_each(): callback invoked three times');
}


{
    my $enc = 'foo=1;bar=2;bar=3';
    my $exp = [ foo => 1, bar => 2, bar => 3 ];
    my $got = url_params_flat($enc);
    is_deeply($got, $exp, 'url_params_flat()');
}

{
    my $enc = 'foo=1& bar=2& bar=3';
    my $exp = [ foo => 1, bar => 2, bar => 3 ];
    my $got = url_params_flat($enc);
    is_deeply($got, $exp, 'url_params_flat()');
}

{
    my $enc = 'foo=1; bar=2& bar=3';
    my $exp = [ foo => 1, bar => 2, bar => 3 ];
    my $got = url_params_flat($enc);
    is_deeply($got, $exp, 'url_params_flat()');
}
