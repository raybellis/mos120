#!/usr/bin/perl -w

use strict;

my $addr;

my %translate = (
	"db"	=> ".byte",
	"dw"	=> ".word",
	"ds"	=> ".byte"
);

my $running = 0;

sub split_data;

while (<>) {
	chomp;
	s/ *$//;

	study;
	if (/^\s*\*/) {
		printf ";%s\n",  $_;
		$running = 0;
	} elsif (/^;/) {
		print $_ . "\n";
		$running = 0;
	} elsif (/^(\s+);(.*)$/) {
		if ($running) {
			print "\t\t\t";
		}
		printf "\t\t; %s\n", $2;
	} elsif (/^\s*$/)  {
		print "\n";
		$running = 0;
	} elsif (/^([0-9A-F]{4})\s+([^\s]+)\s*([^;]*?)\s*(;.*)?$/)  {

		my ($a, $op, $data, $comment) = (lc($1), lc($2), $3, $4);

		# output .org line for first address seen
		if (!$addr) {
			printf(".org\t\t\$%s\n\n", $a);
		}
		$addr = hex($a);

		# convert pseudo-operators
		if ($translate{$op}) {
			$op = $translate{$op};
		}
		
		# fixup operands (FIXME)
		$data = split_data($data);

		# output new text
		printf "\t\t%s\t%s", $op, $data;
		if (defined $comment) {
			$comment =~ s/^;\s*(.*?)$/$1/;
			printf "\t\t; %s", $comment;
		}
		print "\n";
		$running = 1;

	} else {
		print "; ### $_\n";
		$running = 0;
	}
}

sub split_data {
	my $data = shift;
	return "\t" unless defined($data);

	if ($data =~ /,/) {
		my @args = split(/\s*,\s*/, $data);
		@args = map { split_data($_) } @args;
		return join(",", @args);
	} else {
		if ($data =~ /^'([^']*)'$/) {
			return sprintf('"%s"', $1);
		} else {
			$data =~ s/&/\$/;

			if ($data =~ /^([0-9A-F]{2})$/i) {
				return sprintf("\$%02x", hex($1));
			} elsif ($data =~ /^([0-9A-F]{3,4})$/i) {
				return sprintf("\$%04x", hex($1));
			}

			return $data;
		}
	}
}
