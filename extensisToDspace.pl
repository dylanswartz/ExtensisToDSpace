#! /usr/bin/perl
use strict;
use warnings;

$/ = "\r";               #set the input recpord seperator 
open (DATA, "<$ARGV[0]") # open file from 1st command line arg
        or die ("Unable to open file");

my $XML_FILE        = "dublin_core.xml";
my $CONTENTS_FILE   = "contents";
my $header          = <DATA>;
my $imagePath       = "";
my $imageName       = "";
my $imageAuthor     = "";
my $collectionTitle = "";

while ( my $row = <DATA> ) {
	# for every record, get the data, build an xml file,
	# and append to contents file.

	last unless $row =~ /\s/; # this doesn't do anything. Idk why.
	chomp $row; # removes trailing whitespace		
	my @cells = split /\t/, $row; # split into array

	# get image path
	$imagePath = getImagePath(\@cells);
	print $imagePath."\n";
	# get image file name (used as title too)
	$imageName = getImageFileName(\@cells);
	
      	# get current directory name (collection name)
	$collectionTitle = getCurrentDirectoryName(\@cells);

	# get author
	$imageAuthor = getAuthor(\@cells);
	
	# create xml file
	createXMLFile($imagePath, $imageName, $collectionTitle, $imageAuthor);

	# append to contents file	

}

# createXMLFile
# This subprocedure creates a Dublin Core XML file describing an image
# Input: imagePath, imageFileName, collectionName, author
sub createXMLFile { 
	my $imagePath       = $_[0];
	my $imageName       = $_[1];
	my $collectionTitle = $_[2];
	my $imageAuthor     = $_[3];

	#open FILE, ">", "$imagePath.$XML_FILE" or die $!
	#print $imagePath.$XML_FILE;
}

sub getImagePath {
	my @cells = @{$_[0]};
	my $string;
	$cells[74]=~s/:/\//g;
	$string = $cells[74];
	$string = substr $string,4;
	return $string;
}

sub getImageFileName {
	return $_[0][33];
}

sub getCurrentDirectoryName {
	my @cells = @{$_[0]};
	$cells[74]=~s/:/\//g;
	my $string = $cells[74];
	my @dirname = split '/', $string;
	return $dirname[-2]; 
}

sub getAuthor {
	return $_[0][4];
}	
