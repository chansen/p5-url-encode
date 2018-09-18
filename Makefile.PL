use strict;
use warnings;
use 5.008001;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  ABSTRACT_FROM    => 'lib/URL/Encode.pod',
  AUTHOR           => 'Christian Hansen <chansen@cpan.org>',
  LICENSE          => 'perl_5',
  META_MERGE       => {
    dynamic_config => 0,
    'meta-spec'    => {version => 2},
    resources      => {
      repository   => {
        type => 'git',
        url  => 'http://github.com/chansen/p5-url-encode.git',
        web  => 'http://github.com/chansen/p5-url-encode',
      },
    },
  },
  MIN_PERL_VERSION => '5.008001',
  NAME             => 'URL::Encode',
  PREREQ_PM        => {
    'Carp'         => '0',
    'Exporter'     => '0',
  },
  TEST_REQUIRES    => {
    'Test::More'   => '0.88',
  },
  VERSION_FROM     => 'lib/URL/Encode.pm',
  test             => {TESTS => 't/*.t t/*/*.t'},
);

unless (eval { ExtUtils::MakeMaker->VERSION('6.64') }) {
  my $test_requires = delete $WriteMakefileArgs{TEST_REQUIRES};
  @{$WriteMakefileArgs{PREREQ_PM}}{keys %$test_requires} = values %$test_requires;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION('6.52') };
delete $WriteMakefileArgs{MIN_PERL_VERSION}
  unless eval { ExtUtils::MakeMaker->VERSION('6.48') };
delete $WriteMakefileArgs{META_MERGE}
  unless eval { ExtUtils::MakeMaker->VERSION('6.46') };
delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION('6.31') };

WriteMakefile(%WriteMakefileArgs);
