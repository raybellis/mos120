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
	next if /^\s*$/;
	my ($addr, $label) = split(/\s+/, $_, 2);
	$labels{hex($addr)} = $label;
}
close(IN);

read_labels:

open(IN, '<', 'inc/labels.txt') || die;
while (<IN>) {
	chomp;
	if (/^(\w+)\s*=\s*\$([0-9a-f]{4})$/i) {
		my ($label, $addr) = ($1, hex($2));
		$labels{$addr} = $label;
	}
}
close(IN);

open(IN, '<', 'src/_exports.s') || die;
while (<IN>) {
	chomp;
	if (/^\.export\s+(\w+)\s*=\s*\$([0-9a-f]{4})$/i) {
		my ($label, $addr) = ($1, hex($2));
		$labels{$addr} = $label;
	}
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
	} elsif (/^;\s*$/) {
		print "\n";
		$running = 0;
	} elsif (/^;/) {
		print $_ . "\n";
		$running = 0;
	} elsif (/^(\s+);(\s*)(.*)$/) {
		my $comment = $3 ? " $3" : "";
		printf("%*s;%s\n", ($running ? 56 : 24), "", $comment);
	} elsif (/^\s*$/)  {
		print "\n";
		$running = 0;
	} elsif (/^([0-9A-F]{4})\s+([^\s]+)\s*([^;]*?)\s*(;.*)?$/)  {

		my ($a, $op, $data, $comment) = (lc($1), lc($2), $3, $4);

		# output .org line for first address seen
		if (!$addr) {
			printf("%16s%-8s\$%s\n\n", "", ".org", $a);
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
		if (defined $label) {
			$label .= ':';
		} else {
			$label = "";
		}

		# fixup comments
		if (defined $comment) {
			$comment =~ s/^;\s*(.*)$/; $1/;
		} else {
			$comment = "";
		}

		# output new text
		printf("%-15s %-7s %-32s%s\n", $label, $op, $data, $comment);
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
	return unless defined($data);

	if ($data =~ /,/) {
		my @args = split(/\s*,\s*/, $data);
		@args = map { split_data($loc, $op, $_) } @args;
		return join(",", @args);
	} else {
		if ($data =~ /^'([^']*)'$/) {
			return sprintf('"%s"', $1);
		} else {
			$data =~ s/&/\$/g;

			if ($data =~ /(.*?)\$([0-9A-F]{4})(.*)?/i) {

				my ($pre, $addr, $post) = ($1, hex($2), $3);

				if ($loc >= 0xc3e7 && (($addr >= 0xc000 && $addr < 0xfc00) || ($addr >= 0xff00))) {
					my $type = ($op =~ /^b/) ? "B" : "L";
					$targets{$addr} = $type;
					$labels{$addr} = $labels{$addr} || sprintf("_%s%04X", $type, $addr);
				}

				if ($labels{$addr}) {
					return sprintf("%s%s%s", ($pre || ""), $labels{$addr}, ($post || ""));
				} else {
					return sprintf("%s\$%04x%s", ($pre || ""), $addr, ($post || ""));
				}

			} elsif ($data =~ /(.*?)\$([0-9A-F]{1,2})(.*)?/i) {

				my ($pre, $addr, $post) = ($1, hex($2), $3);

				return sprintf("%s\$%02x%s", ($pre || ""), $addr, ($post || ""));

			}

			return $data;
		}
	}
}
