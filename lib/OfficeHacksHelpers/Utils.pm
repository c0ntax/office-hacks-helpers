package OfficeHacksHelpers::Utils;

use strict;
use warnings;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
use DBI;
use File::Basename;
use Cwd 'abs_path';

$VERSION        = 1.00;
@ISA            = qw(Exporter);
@EXPORT         = ();
@EXPORT_OK      = ();
%EXPORT_TAGS    = ();

sub new {
	my $class = shift;
	my %options = @_;
	print Dumper(\%options);
	my $self = {
		_verbose => defined($options{'verbose'}) ? $options{'verbose'} : 0,
		_redirectToStderr => defined($options{'redirectToStderr'}) ? $options{'redirectToStderr'} : 0,
	};
	
	bless ($self, $class);
	return $self;
}

sub dbConnect {
    my ($self, $dsn, $user, $pass) = @_;
    $self->vPrint("Connection to ", $dsn, "...");
    my $dbh = DBI->connect($dsn, $user, $pass);
    if (!$dbh) {
        $self->vPrint("Failed\n");   
        exit(1);
    } else {
        $self->vPrint("Done\n");
    }
    
    # And ensure that we're talking using UTF8
    
    $dbh->do('SET NAMES utf8');
    
    return $dbh;
}

sub getExecScriptPath {
	my ($self) = shift;
	return dirname(abs_path($0));
}

sub vPrint {
	my ($self) = shift;
    if ($self->{_verbose}) {
    	if (defined($self->{_redirectToStderr}) && $self->{_redirectToStderr}) {
    		print STDERR @_;
    	} else {
            print STDOUT @_;
    	}
    }
}

1;