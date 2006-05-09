#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 12;

BEGIN {
 use_ok("Gives");
}

sub foo_list : Gives(qw(LIST))  {
  return (@_);
}

$@ = undef;
eval {
  my $test : Gives('SCALAR');
};
ok($@, "Gives not applicable to non-CODE");

my @list = foo_list(1..4);
ok(@list == 4, "LIST context works");

foreach (1..4) {
  ok($list[$_-1] == $_);
}

$@ = undef;
my $scal = undef;
eval {
  $scal = foo_list(1..4);
};
ok($@, "SCALAR context caused error");
ok(!defined $scal);

$@ = undef;
eval {
  foo_list(1..4);
};
ok($@, "VOID context caused error");

$@ = undef;
eval {
  if (foo_list(1)) {
    warn("You should not be seeing this message");
  }
};
ok($@, "BOOL context caused error");

{
  local $TODO = "HASH context";
  $@ = undef;
  eval {
    my $ref = { foo_list(1..4) };
  };
  ok($@, "HASH context caused error");
}
