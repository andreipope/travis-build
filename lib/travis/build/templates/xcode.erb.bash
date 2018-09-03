#!/bin/bash

mkdir "${TRAVIS_BUILD_HOME}/bin"

cat >"${TRAVIS_BUILD_HOME}/bin/xcodebuild" <<'XCODEBUILD_STUB'
#!/usr/bin/env perl

my $status = 1;

open my $fh, "-|", @ARGV
  or die "unable to run command: $!\n";

while (my $line = readline($fh)) {
	print $line;
	$status = 0 if $line =~ /^\*\* TEST SUCCEEDED \*\*$/;
}

close $fh;

exit $status;
XCODEBUILD_STUB

chmod +x "${TRAVIS_BUILD_HOME}/bin/xcodebuild"

export PATH="${TRAVIS_BUILD_HOME}/bin:${PATH}"
