#!/usr/bin/perl

=head1 NAME

geolocatezip.pl

=head1 SYNOPSIS

./geolocatezip.pl, by (c) Jim Turner

=head1 DESCRIPTION

geolocatezip.pl attempts to first fetch the users current IP address, then uses that 
to fetch the zipcode for that IP address using geolocation.  Failing that, it attempts 
to fetch the city and state for the IP address and then uses a postal service site 
to attempt to look up a zip-code for that city and state.  If multiple zip-codes are 
returned, then the last one is returned.  The zip-code found is written to STDOUT.

The purpose of this program is for use by TkWeather in order to get the weather 
hopefully for the location the user's computer is actually in.  This is useful if 
the user is a frequent traveler and using a laptop.

NOTE:  works for U.S., maybe Canada too; for now.

=head1 LICENSE AND COPYRIGHT

Copyright 2015-2019 Jim Turner.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

#use LWP::Simple;
my $haveCurl = 0;
eval "use LWP::Curl; \$haveCurl = 1; 1";

#SITE FOR LOOKING UP USER'S TRUE IP-ADDRESS:
my $ipSite = 'https://www.ipinfodb.com/';
#my $html = LWP::Simple::get($ipSite);  #STEP 1:  FETCH IP AND IT'S CITY, STATE; OR ZIP:
my $html = '';

#STEP 1:  FETCH IP AND IT'S CITY, STATE; OR ZIP:
if ($haveCurl) {
	my $lwpcurl = LWP::Curl->new(timeout => 10);
	if ($lwpcurl) {
		$html = $lwpcurl->get($ipSite);
	} else {
		warn "f:Could not create curl object?, trying wget!...";
	}
}
$html = `wget -t 2 -T 20 -O- -o /dev/null \"$ipSite\" 2>/dev/null `  unless ($html);

if ($html =~ /Postcode\D+(\d+)/iso) {
	$zip = $1;
#print "-zip=$zip=\n";
	if ($zip =~ /\d\d\d\d\d/o) {   #IP INFO INCLUDES A VALID ZIP, RETURN THAT; WE'RE DONE!
		print $zip;
		exit(0);
	}
}

=head2 OBSOLETE

if ($html =~ m#(?:Region|State)(?:\<\/\w+\>)+\s+(\w+)#i) {  #EXTRACT THE STATE (SITE CURRENTLY RETURNS A FULL STATE NAME):
	$state = $1;
print "---st=$state=$2=\n";
	my %stateHash = (
			'TEXAS' => 'TX',
			'ALABAMA' => 'AL',
			'ALASKA' => 'AK',
			'ALBERTA' => 'AB',
			'ARIZONA' => 'AZ',
			'ARKANSAS' => 'AR',
			'BRITISH COLUMBIA' => 'BC',
			'CALIFORNIA' => 'CA',
			'COLORADO' => 'CO',
			'CONNECTICUT' => 'CT',
			'DELAWARE' => 'DE',
			'DISTRICT OF COLUMBIA' => 'DC',
			'FLORIDA' => 'FL',
			'GEORGIA' => 'GA',
			'HAWAII' => 'HI',
			'IDAHO' => 'ID',
			'ILLINOIS' => 'IL',
			'INDIANA' => 'IN',
			'IOWA' => 'IA',
			'KANSAS' => 'KS',
			'KENTUCKY' => 'KY',
			'LOUISIANA' => 'LA',
			'MAINE' => 'ME',
			'MANITOBA' => 'MB',
			'MARYLAND' => 'MD',
			'MASSACHUSETTS' => 'MA',
			'MICHIGAN' => 'MI',
			'MINNESOTA' => 'MN',
			'MISSISSIPPI' => 'MS',
			'MISSOURI' => 'MO',
			'MONTANA' => 'MT',
			'NEBRASKA' => 'NE',
			'NEVADA' => 'NV',
			'NEW BRUNSWICK' => 'NB',
			'NEW HAMPSHIRE' => 'NH',
			'NEW JERSEY' => 'NJ',
			'NEW MEXICO' => 'NM',
			'NEW YORK' => 'NY',
			'NEWFOUNDLAND AND LABRADOR' => 'NF',
			'NORTH CAROLINA' => 'NC',
			'NORTH DAKOTA' => 'ND',
			'NORTHWEST TERRITORIES' => 'NT',
			'NOVA SCOTIA' => 'NS',
			'OHIO' => 'OH',
			'OKLAHOMA' => 'OK',
			'ONTARIO' => 'ON',
			'OREGON' => 'OR',
			'PENNSYLVANIA' => 'PA',
			'PRINCE EDWARD ISLAND' => 'PE',
			'QUEBEC' => 'QC',
			'RHODE ISLAND' => 'RI',
			'SASKATCHEWAN' => 'SK',
			'SOUTH CAROLINA' => 'SC',
			'SOUTH DAKOTA' => 'SD',
			'TENNESSEE' => 'TN',
			'UTAH' => 'UT',
			'VERMONT' => 'VT',
			'VIRGINIA' => 'VA',
			'WASHINGTON' => 'WA',
			'WEST VIRGINIA' => 'WV',
			'WISCONSIN' => 'WI',
			'WYOMING' => 'WY',
			'YUKON' => 'YT'
	);
	$state =~ tr/a-z/A-Z/;
	$state = $stateHash{$state}  if (defined $stateHash{$state});  #CONVERT STATE NAMES TO PROPER CODE:
}
if ($html =~ m#City(?:\<\/\w+\>)+\s+(\w+)#i) {   #EXTRACT THE CITY:
	$city = $1;
}

print "-city=$city= st=$state=\n";
if ($city && $state) {    #WE HAVE A VALID CITY, STATE - NOW TRY TO FETCH A ZIP-CODE:
	$zipSite =~ s/\<city\>/$city/g;
	$zipSite =~ s/\<state>/$state/g;
#	$html = LWP::Simple::get($zipSite);
my $lwpcurl = LWP::Curl->new(timeout => 10);
die "f:Could not create curl object?!"  unless ($lwpcurl);
print "--ZIPSITE=$zipSite=\n";
$html = $lwpcurl->get($zipSite);  #STEP 1:  FETCH IP AND IT'S CITY, STATE; OR ZIP:
print "---html=".substr($html,0,40)."=\n";
	while ($html =~ s!\<td valign\=\"top\" class\=\"main\" style\=\"background\:url\(images\/table_gray.gif\); padding\:5px 10px\;\" headers\=\"units\"\>\s*(\d+)!!s) {
		$zip = $1;
print "-------zip=$zip=\n";
	}
	print $zip;
	exit(0);
}

=cut

if (open(LZ, "$ENV{HOME}/localzip"))
{
	$zip = <LZ>;
	chomp $zip;
	close LZ;
	if ($zip =~ /\d/)
	{
		print $zip;
		exit(0);
	}
}
print '';
exit(1);	
