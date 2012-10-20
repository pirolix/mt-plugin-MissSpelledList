package MT::Plugin::OMV::MissSpelledList;
# $Id$

use strict;
use MT 3;
use MT::Template::Context;

use vars qw( $VENDOR $MYNAME $VERSION );
($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1];
(my $revision = '$Rev$') =~ s/\D//g;
$VERSION = '0.02'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    id => $MYNAME,
    key => $MYNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    doc_link => '',
    description => <<PERLHEREDOC,
Generate miss-spelled words list for surviving the search
PERLHEREDOC
});
MT->add_plugin ($plugin);

sub instance { $plugin; }



my %keymap = (
    0 => qq(9PO),
    1 => qq(2Q),
    2 => qq(13WQ),
    3 => qq(24EW),
    4 => qq(35RE),
    5 => qq(46TR),
    6 => qq(57YT),
    7 => qq(68UY),
    8 => qq(79IU),
    9 => qq(80OI),
    A => qq(QWSZ),
    B => qq(VGHN),
    C => qq(XDFV),
    D => qq(SERFCX),
    E => qq(W3RDS),
    F => qq(DRTGVC),
    G => qq(FTYHBV),
    H => qq(GYUJNB),
    I => qq(U89OKJ),
    J => qq(HUIKMN),
    K => qq(JIOLM),
    L => qq(KOP),
    M => qq(NJK),
    N => qq(BHJM),
    O => qq(I90PLK),
    P => qq(O0-L),
    Q => qq(12WSA),
    R => qq(E45TFD),
    S => qq(AWEDXZ),
    T => qq(R56YGF),
    U => qq(Y78IJH),
    V => qq(CFGB),
    W => qq(Q23ESA),
    X => qq(ZSDC),
    Y => qq(T67UHG),
    Z => qq(ASX),
);

###
MT::Template::Context->add_container_tag ($MYNAME => sub {
    my ($ctx, $args, $cond) = @_;

    defined (my $out = $ctx->slurp ($args, $cond))
        or return;

    my @ret = ($out);
    foreach my $index (1..length $out) {
        my $chr = uc substr $out, $index-1, 1;
        next if $chr !~ /[0-9A-Z]/;
        my @keymap = split //, $keymap{$chr};
        push @keymap, '';
        foreach (@keymap) {
            my $buf = $out;
            substr ($buf, $index-1, 1) = $_;
            push @ret, $buf;
        }
    }

    join $args->{glue} || '', @ret;
});

1;
__END__