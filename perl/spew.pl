#!/usr/bin/perl -w
#
# spew - Generate random tabloid-style headlines.
#
# The original version of this program was written by Greg Smith and
# appeared in comp.sources.games volume 1 and comp.sources.misc
# volume 10.  A copy of Greg's program and his original file may be
# found in ftp://ftp.uu.net/usenet/comp.sources.misc/volume10/spew.Z.
#
#
# Usage:  spew [-a] [-d] [-f filename] [num]
#
#    -a     Analyze the input file and print a few statistics about it.
#           This option is mutually-exclusive of -d.
#
#    -p     Print a nicely sorted, formatted and indented version
#           of what was read in.  THIS DOES NOT PRESERVE COMMENTS.
#           This option is mutually-exclusive of -a.
#
#    -f     The file from which headlines should be read.  This
#           defaults to whatever's in the RULESFILE environment
#           variable if it is defined, or "headline" if not.  The
#           standard input may be selected with a hyphen.
#
#    num    The number of headlines to be spewed.  The default is
#           one.  This is ignored if -a or -d are in force.
#
#
# $Id: spew,v 1.3 1995/08/03 23:50:04 mark Exp $
# $Source: /home/mark/src/perl/RCS/spew,v $
# $Author: mark $
#

# This code, stolen from the perl manual page, forces this to be run
# by perl from perl, sh, or csh.  It must be first.

eval '(exit $?0)' && eval 'exec /usr/local/bin/perl -S $0 ${1+"$@"}'
& eval 'exec /usr/local/bin/perl -S $0 $argv:q'
    if 0;


require 5.000;			# Gotta keep up with the times.
use Getopt::Long;

$debug = 0;			# 1=Basic debugging, 9=Loads of debugging

($whoami = $0) =~ s|.*/||g;

sub barf {
    die "$whoami: ", @_;
}

sub usage {
    die "Usage: $whoami [-a] [-p] [-f filename] [number]\n";
}


$sep = "\376";			# String separator

srand($$);			# Double-seed the random number generator...
#srand( rand(65536) );		# Seems to work better this way.


# Parse the options

GetOptions( "a", "p", "f=s" ) || usage();

$analyze = defined($opt_a);
$prettyprint = defined($opt_p);

$opt_p = $opt_a;		# Keep the compiler quiet


# If the user specified -a and -d, ralph loudly.

barf "Can't use -a and -p together.\n" if ( $analyze && $prettyprint );


# All we should have left on the command line, if anything, is the
# number of times we should spew.  If it's there, it had better be a
# number.

if ($#ARGV == -1)
{
    $num_spews = 1;
}
else
{
    usage() if ( defined($ARGV[0]) && ($ARGV[0] !~ /^\d+$/) );
    $num_spews = $ARGV[0];
}

# If there wasn't a rule file on the command line, try to get one from
# the environment.  Failing that, try "headline."  Failing that, barf.

if ( defined($opt_f) )
{
    $rules_file = $opt_f;
    print STDERR "Using command-line's \"$rules_file\" for input\n"
	if $debug;
}
elsif ( defined($ENV{"RULESFILE"}) )
{
    $rules_file = $ENV{"RULESFILE"};
    print STDERR "Using envronment's \"$rules_file\" for input\n"
	if $debug;
}
else
{
    $rules_file = "headline";
    print STDERR "Using default \"$rules_file\" for input\n"
	if $debug;
}

# Try to open the file.  If it's named '-', just assign standard input

if ( $rules_file ne "-" )
{
    open( HEADLINE, $rules_file )
	|| barf "Can't open $rules_file: $!\n";
}
else
{
    open( HEADLINE, "<&STDIN" ) || barf "Can't dupe standard input: $!\n";
}

# Read in the entire file and build a bunch of associative arrays for
# the categories.

$class = "";			# No class to start with

while (<HEADLINE>)
{
    chop;
    s/^\s*//;			# Strip leading whitespace
    s/\s*$//;			#  ...trailing whitespace
    s/\\\*.*$//;		#  ...and comments.

    next if /^$/;		# Bail out if there's nothing left

    # The %% at the end of the file is optional in this version,
    # but we'll support it anyway for backward compatibility
    last if /^%%$/ ;		# Stop if we reach the end

    if ( /^%/ )			# Start a new class
    {
	s/^%(\w+)(\{(\w+)\})?//; # Chop % and match variants

	$class = $1;		# The class name
	$variants = $3;		# Its vairants

	print STDERR "CLASS $class:\n" if $debug > 10;
	print STDERR "  Variants: $variants\n"
	    if defined($variants) && ($debug > 10);

	$expansion{$class} = "";
	$variants{$class} = " " . $variants if $variants;

	next;
    }

    barf "No class in place before first component line.\n"
	unless $class;

    # This catches (nnn)text type entries and sets up to put extras
    # in the array.
    $repeats = s/^\((\d+)\)// ? $1 : 1;

    print STDERR "  $_", ( $repeats > 1 ? " x $repeats" : "" ), "\n"
	if ($debug > 10);

    $expansion{$class} .= ($_ . $sep) x $repeats;
}

close(HEADLINE);		# Clean up any leftovers


do { analyze(); exit 0 } if $analyze;
do { prettyprint(); exit 0 } if $prettyprint;

do { prettyprint(); exit 0 } if $analyze;

# Now so some spewing.  This consists of spouting out whatever's in
# the "MAIN" class.

print &expand("MAIN", "") until ($num_spews-- == 0);



# This subroutine does the actual expanding of the categories.

sub expand {
    barf "Expand: Syntax is expand( category, variant )\n" if $#_ ne 1;

    local($class, $variant, $item, $text, $_ );

    ($class, $variant) = @_;
    @exlist = defined($expansion{$class}) ?
	split( $sep, $expansion{$class} ) : () ;

    # Check that the class exists
    barf "No class \"$class\"\n"
	if $#exlist == -1;

    # Make sure the variant is good
    barf "Variants may be only one letter or the ampersand.\n"
	if ! ($variant =~ /^[A-Za-z &]?$/ );

    # Select an item at random from the expansion list
    $item = int(rand($#exlist+1));
    $_ = $exlist[$item];

    print STDERR "Expanding $class/$variant to $_\n" if $debug;

    $text = "";

    while ( /./ )
    {
	s/^([^\\]+)//;		# Chop everything up to a backslash
	$text .= $1 if defined $1; # Dump chopped text out

	last if /^$/;		# Bail if that's it.

	s/\\([\w]+|!)(\/(([\w &]))?)?//; # Trim out keyword and variant

	$keyword = $1;
	$keyvariant = defined($3) ? $3 : $variant;
    
	if ( $keyword eq "!" )	# A special case.
	{
	    $text .= "\n";
	    next;
	}

	$keyvariant = $variant if $keyvariant eq "&";

	$text .= expand($keyword,$keyvariant); # Expand 
    }

    # If the option requested isn't in the list, 



    # Go through the entire expanded string and do the options
    # substitutions.

    $_ = $text;

    while ( s/\{[^\}]*\}/$sep/ )
    {
	($seplist = $&) =~ s/\{|\}//g; # Chop the braces off the ends
	@list = split( /\|/, $seplist );
	$index = index( $variants{$class}, $variant );
	$replacement = $list[$index] ? $list[$index] : "";
	s/$sep/$replacement/; 
    }
    
    $_;
}


sub count_up {

    local($count, $class, $total_headlines);

    ($class) = @_;

    # If the class doesn't exist, return 1 so the caller will do the
    # multiply and treat this reference as if it never happened.

    if ( ! defined( $expansion{$class} ) )
    {
	warn "Warning: Class \"$class\" is undefined.\n";
	return 1;
    }


    # If we're referring to something not fully evaluated, we've got
    # infinite recursion possible.  Politely return 1;

    if ( grep($_ eq $class,@count_stack) )
    {
	print STDERR "Infinite loop on $class: @count_stack\n" if $debug;
	return 1;
    }

    print STDERR "Counting $class\n" if $debug;

    # If the number of possibilities for the class has already been
    # calculated, just return it.

    if ( defined($headlines{$class}) )
    {
	print STDERR "  Already seen it -- $headlines{$class}\n" if $debug;
	return $headlines{$class};
    }

    # Otherwise, dig through the class and see how many headlines it
    # returns, recursing for class references as necessary.

    $total_headlines = 0;

    foreach ( split($sep, $expansion{$class}) )
    {
	$count = 1;		# We always get at least one.

	while ( /./ )
	{
	    s/^([^\\]+)//;		# Chop everything up to a backslash
	    last if /^$/;		# Bail if nothing's left

	    s/\\([\w]+|!)(\/(([\w &]))?)?//; # Trim out keyword and variant

	    if ( ($1 ne "!") && ($1 ne $class) )
	    {
		print STDERR "  Recursing on $1\n" if $debug;
		push( @count_stack, $class );
		$count *= count_up($1);
		pop( @count_stack );
	    }
	}

	$total_headlines += $count;
    }

    print STDERR "  Counted $total_headlines for $class\n" if $debug;
    $headlines{$class} = $total_headlines;
}


sub commas {			# Stolen from the Camel
    local($_) = @_;
    1 while s/(.*\d)(\d\d\d)/$1,$2/;
    $_;
}

sub analyze {

    @classes = keys(%expansion);

    $tally = count_up("MAIN");

    # If it looks like an exponentiated number, expand it.
    if ( $tally =~ /^(\d+)\.(\d+)e\+(\d+)$/ )
    {
	$nbase = $1 . $2;
	$exponent = $3;
	$total = $nbase . ( "0" x ($exponent - length($nbase)) );
    }
    else
    {
	$total = $tally;
    }


    print commas($#classes + 1), " classes generating about ",
    commas($total), " unique headlines\n";

}


# Dump out a nicely-sorted list of what came in.

sub prettyprint {
    $classes = 0;

    foreach ( sort(keys(%expansion)) )
    {
	# Print the name of the class and its variants (if it has them)
	print "\n" if $classes++;
	print "%$_";
	if ( defined($variants{$_}) )
	{
	    ($vars = $variants{$_}) =~ s/ //;
	    print "{$vars}";
	}
	print "\n";

	# Dump each expansion in the class
	@lines = sort(split($sep, $expansion{$_}));

	$repeat_count = 0;
	for ( $line_no = 0; $line_no <= $#lines; $line_no++ )
	{
	    # If the next line's the same, increment the repeat count and
	    # skip this one.
	    if ( ($line_no < $#lines) &&
		($lines[$line_no] eq $lines[$line_no+1]) )
	    {
		$repeat_count++;
		next;
	    }

	    $repeat_count++;
	    print "(", $repeat_count, ")" if ($repeat_count > 1);
	    print "$lines[$line_no]\n";
	    $repeat_count = 0;

	}

    }
}
