#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use JSON qw/decode_json/;
use Text::MicroTemplate qw/build_mt/;

my $template_file = shift or die 'Please specify the template file';
my $template = load_template($template_file);

my $ipv4_conf = load_ipv4_pppoe_conf();

print build_mt($template)->({
    ipv4_pppoe => $ipv4_conf,
})->as_string;

sub load_template {
    my ($template_file) = @_;

    open my $fh, '<', $template_file or die "Failed to open file: $!";
    return do { local $/; <$fh> };
}

sub load_ipv4_pppoe_conf {
    my $opened = open my $fh, '<', 'ipv4_pppoe_conf.json';
    unless ($opened) {
        return {};
    }

    my $conf_json = do { local $/; <$fh> };
    return decode_json($conf_json);
}

__END__

