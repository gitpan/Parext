package String::Parext;
require 5.001;
require Exporter;

# Documentation in pod format after __END__ token. See Perl
# man pages to convert pod format to man, html and other formats.

$Version = 1.1; sub Version {$Version}
@ISA = qw(Exporter);
@EXPORT = qw( setMarkParity setSpaceParity showParext
	      MarkBytes SpaceBytes
	      isMarkParity isSpaceParity
	    );

sub setSpaceParity {
    my(@s) = @_;
    foreach (@s) {
	tr/\200-\377/\0-\177/;
    }
    wantarray ? @s : join '', @s;
}

sub setMarkParity {
    my(@s) = @_;
    foreach (@s) {
	tr/\0-\177/\200-\377/;
    }
    wantarray ? @s : join '', @s;
}

sub showParext {
    my(@s) = @_;
    foreach (@s) {
	tr/\0-\177/s/;
	tr/\200-\377/m/;
    }
    wantarray ? @s : join '', @s;
}

sub SpaceBytes {
    my $count = 0;
    foreach (@_) {
	$count += tr/\0-\177//;
    }
    $count;
}

sub MarkBytes {
    my $count = 0;
    foreach (@_) {
	$count += tr/\200-\377//;
    }
    $count;
}

sub isSpaceParity {
    ! &MarkBytes;
}

sub isMarkParity {
    ! &SpaceBytes;
}

1;

__END__

=head1 NAME

String::Parext, setSpaceParity, setMarkParity, showParext, SpaceBytes,
MarkBytes, isSpaceParity, isMarkParity - Parity (odd/even) handling functions

=head1 SYNOPSIS

    use String::Parext;

=head1 DESCRIPTION

=over 8

=item setSpaceParity LIST

Copies the elements of LIST to a new list and converts the new elements to
strings of bytes with space parity (High bit cleared). In array context
returns the new list.  In scalar context joins the elements of the new
list into a single string and returns the string.

=item setMarkParity LIST

Does the same as the setSpaceParity function, but converts to strings with
mark parity (High bit set).

=item showParext LIST

Does the same as the setSpaceParity function, but converts bytes with space
parity to 's' and other bytes to 'm'.

=item SpaceBytes LIST

Returns the number of space parity bytes in the elements of LIST.

=item MarkBytes LIST

Returns the number of mark parity bytes in the elements of LIST.

=item isSpaceParity LIST

Returns TRUE if the LIST contains no byte with mark parity, FALSE otherwise.

=item isMarkParity LIST

Returns TRUE if the LIST contains no byte with space parity, FALSE otherwise.

=back

=head1 NOTES

Don't use this module unless you have to communicate with some old device
or protocol. Help the world and make your application 8 bit clean. Use the
internationally standardized ISO-8859-1 character set.

=head1 AUTHOR

Winfried Koenig <win@in.rhein-main.de>

 Copyright (c) 1995 Winfried Koenig. All rights reserved.
 This program is free software; you can redistribute it
 and/or modify it under the same terms as Perl itself.

=cut
