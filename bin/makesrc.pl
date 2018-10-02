#!/usr/bin/perl -w

use strict;

my $addr;

my %translate = (
	"db"	=> ".byte",
	"dw"	=> ".word",
	"ds"	=> ".byte"
);

my $running = 0;
my (%labels, %targets);

open(IN, '<', 'targets.txt') || goto read_labels;
while (<IN>) {
	chomp;
	my ($addr, $label) = split(/\s+/, $_, 2);
	$labels{hex($addr)} = $label;
}
close(IN);

read_labels:

open(IN, '<', 'inc/labels.txt') || goto read_input;
while (<IN>) {
	chomp;
	my ($addr, $label) = split(/\s+/, $_, 2);
	$labels{hex($addr)} = $label;
}
close(IN);

read_input:

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
		
		# fixup operands
		$data = split_data($addr, $op, $data);

		# generate label
		my $label = $labels{$addr};
		if ($label) {
			$label = $label . ":";
		} else {
			$label = "";
		}

		# output new text
		printf "%s\t\t%s\t%s", $label, $op, $data;
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

open(OUT, '>', 'targets.txt');
foreach my $addr (sort { $a <=> $b } keys %targets) {
	if (!$labels{$addr}) {
		printf OUT "%04x\t_%s%04X\n", $addr, $targets{$addr}, $addr;
	}
}
foreach my $addr (sort { $a <=> $b } keys %labels) {
	printf OUT "%04x\t%s\n", $addr, $labels{$addr};
}
close(OUT);

sub split_data {
	my ($loc, $op, $data) = @_;
	return "\t" unless defined($data);

	if ($data =~ /,/) {
		my @args = split(/\s*,\s*/, $data);
		@args = map { split_data($loc, $op, $_) } @args;
		return join(",", @args);
	} else {
		if ($data =~ /^'([^']*)'$/) {
			return sprintf('"%s"', $1);
		} else {
			$data =~ s/&/\$/g;

			if ($data =~ /^([0-9A-F]{2})$/i) {
				return sprintf("\$%02x", hex($1));
			} elsif ($data =~ /(.*?)\$?([0-9A-F]{4})(.*)/i) {

				my ($pre, $addr, $post) = ($1, hex($2), $3);

				if ($loc >= 0xc400 && (($addr >= 0xc000 && $addr < 0xfc00) || ($addr >= 0xff00))) {
					my $type = ($op =~ /^b/) ? "B" : "L";
					$targets{$addr} = $type;
					$labels{$addr} = $labels{$addr} || sprintf("_%s%04X", $type, $addr);
				}

				if ($labels{$addr}) {
					return sprintf("%s%s%s", ($pre || ""), $labels{$addr}, ($post || ""));
				} else {
					return sprintf("%s\$%04x%s", ($pre || ""), $addr, ($post || ""));
				}
			}

			return $data;
		}
	}
}
