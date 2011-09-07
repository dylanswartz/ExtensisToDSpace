#!/usr/bin/perl
use strict;
use warnings;

$/ = "\r"; 		 #set the input recpord seperator 
open (DATA, "<$ARGV[0]") # open file from 1st command line arg
	or die ("Unable to open file"); 

my $header =  <DATA>;
my $PATH_COLUMN = 74;

while ( my $row = <DATA> ) {
	last unless $row =~ /\S/; # this doesn't do anything. Idk why.
	#last unless 0; # test last unless
	chomp $row;
  	my @cells = split /\t/, $row;
	$cells[$PATH_COLUMN]=~s/:://g;
	$cells[$PATH_COLUMN]=~s/:/\//g;
	#$cells[$PATH_COLUMN]=~s/\/\///g;
	
	print $cells[$PATH_COLUMN] . "\n";
	
}
