#!/usr/bin/perl

use strict;
#NOTE: Windows compile:  perl2exe -gui -perloptions="-p2x_xbm -s" tkweather.pl
#NOTE: POD compile:  pp -g -o tkweather.exe tkweather.pl

=head1 NAME

	TkWeather, by (c) Jim Turner

=head1 SYNOPSIS

	tkweather.pl [-options=values] [zip-code|"lookup"]

=head1 DESCRIPTION

	This program fetches the current weather conditions every 12 
	minutes (720 seconds) (configurable) from 
	https://forecast.weather.gov and displays a nice square iconic button 
	showing the current weather condition.  Clicking the button shows the 
	current basic weather condition values, such as temperature, humidity, 
	and wind.  Clicking again shows additional information, namely the 
	barometric pressure, visiblility, and "heat index" or 
	"wind chill" or "misery index".  
	Holding the [Shift] key while 
	clicking displays a webpage showing the detailed weather info. 
	Double-clicking or holding the [Alt] key while clicking refreshes the 
	data. 
	Holding the [Shift] and [Ctrl] keys simultainously while clicking 
	exits the program.
	
	For anyone not from Houston, Texas,
	the old "misery index" is the temperature plus dewpoint.  Anything 
	over 150 is considered "miserable"!  I use this for planning 
	workouts.  The default is to use the more modern "heat index".  
	Specify "index=misery" for the old Houston "misery index".  
	"wind chill" is used if the temperature is below 70 and wind 
	is >= 10mph regardless.  This has now been updated to a more 
	temperature-friendly value (>=100 is "miserable") by multiplying 
	the old value by 2/3 (0.6667).

=head1 CONFIGURATION

	How to set up:

	1)  Create a "tkweather" directory in your home directory.

	2)  You will also need to specify your zipcode either as the 
	command-line argument or add a "zipcode=yourzip" line in 
	$HOME/tkweather/tkweather.cfg
	Otherwise you get the weather at the author's zipcode!
	If you specify a string, such as "lookup" instead of a number, 
	tkweather will attempt to look up your zip-code using geolocatezipp.pl.

	3)  The optional file:  $HOME/tkweather/tkweather.cfg takes the
	format (defaults shown below):  Any line starting with "#" is 
	ignored as a comment (Default values are shown).

	geometry=+100+100
	zipcode=76087
	#BROWSER TO BE INVOKED IF USER PRESSES SHIFT-CLICK ON BUTTON. 
	browser=mozilla
	#URL USED FOR SCRAPING WEATHER DATA.
	weatherurl=https://forecast.weather.gov/zipcity.php?Go2=Go&inputstring=<ZIP>
	#COMMAND URL TO BE INVOKED IF USER PRESSES SHIFT-CLICK ON BUTTON. 
	weathercmd=https://forecast.weather.gov/zipcity.php?Go2=Go&inputstring=<ZIP> &
	#MILLISECONDS TO WAIT BETWEEN QUERIES TO THE WEATHER URL.
	checkmsec=720000
	#BUTTON RELIEF (CHOICES:  flat, groove, raised, ridge, sunken)
	relief=ridge
	#INDEX:  "misery": USE OLD "MISERY INDEX" (HEAT+DEWPOINT),
	#OTHERWISE ("heat") USE MODERN "HEAT INDEX" AS REPORTED.
	#NOTE:  WIND CHILL IS REPORTED IF TEMP. < 70 AND WIND >= 10 MPH
	#REGARDLESS OF THIS SETTING!
	index=heat
	#OVERRIDEDIRECT ARGUMENT 0=MANAGED BY WINDOWMANAGER (DECORATE)
	#1=BYPASS WINDOWMANAGER (NO DECORATION).  USE 0 IF DOCKING IN
	#WINDOWMAKER OR AFTERSTEP.
	windowmgr=0
	#STARTUP ICON IMAGE (MUST BE IN $ENV{HOME}/tkweather/)
	startimage=tkweather.gif
	#WARN ON WHICH TYPES:
	warntypes=tornado|storm|blizard|freeze|flood
	#NORMAL TEXT FOREGROUND COLOR
	normalcolor=green
	#COLOR OF 1 PIXEL FRAME AROUND BUTTON
	framecolor=#222222
	#WARNING COLOR
	warningcolor=yellow
	#ALERT COLOR
	alertcolor=red
	#COLD WARNING COLOR  (I USE cyan)  DEFAULT IS warningcolor IF NOT DEFINED.
	cwarningcolor=<undef>
	#COLD ALERT COLOR    (I USE blue)  DEFAULT IS warningcolor IF NOT DEFINED.
	calertcolor=<undef>
	#HOT WARNING COLOR  (I USE orange)  DEFAULT IS warningcolor IF NOT DEFINED.
	hwarningcolor=<undef>
	#NORMAL BACKGROUND COLOR
	bgcolor=black
	#CONVERT TEMPS, WIND-SPEED ETC. TO METRIC IF SET.
	metric=0
	#DO NOT DISPLAY MESSAGE TO STDERR WHEN FETCHING WEATHER FROM WEB (IF SET):
	silent=0
	#DO NOT DUMP DEBUG INFORMATION TO STDERR (UNLESS SET)
	debug=0
	#SHOW SITE NAME IN TEMPERATURE BALLOON (IF SET)
	noshowsite=0
	#SHOW ZIPCODE IN BALLOON (0=always show, 1=only if zip=lookup, 2=never show)
	noshowzip=1
	#FONT (USED FOR THE TEXT VALUES IN BUTTON (SHOULD BE A SMALL ONE!)
	font=-*-lucida console-bold-r-*-*-9-*-*-*-*-*-*-*
	#DO NOT SHOW CPU TEMP. IN BALLOON IF SET:
	nocputemp=0

	4)  Copy the image "tkweather.gif" to $HOME/tkweather/

	5)  Copy tkweather.pl to somewhere in your PATH or wherever you 
	want to be able to run it from.  Make sure line 1 points to your
	perl interpreter.

	6)  To make this app appear in your AfterStep/Windowmaker "wharf", 
	add the following to your config file:
	*Wharf TkWeather "-" MaxSwallow "TkWeather" /usr/bin/nice -n 15 /usr/local/bin/tkweather.pl &
        
	7)  Enjoy!

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2003-2024 Jim Turner.

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

########### THIS SECTION NEEDED BY PAR COMPILER! ############
#NOTE:  FOR SOME REASON, v.pl NEEDS BUILDING WITH:  pp -M Tk::ROText ...!
#REASON:  par does NOT pick up USE and REQUIRE's quoted in EVAL strings!!!!!

#STRIP OUT INC PATHS USED IN COMPILATION - COMPILER PUTS EVERYTING IN IT'S OWN
#TEMPORARY PATH AND WE DONT WANT THE RUN-TIME PHISHING AROUND THE USER'S LOCAL
#MACHINE FOR (POSSIBLY OLDER) INSTALLED PERL LIBS (IF HE HAS PERL INSTALLED)!
BEGIN
{
	my @myNewINC = ();
	if ($0 =~ /exe$/io)
	{
		while (@INC)
		{
			$_ = shift(@INC);
			push (@myNewINC, $_)  if (/(?:cache|CODE)/o);
		}
		@INC = @myNewINC;
	}
}
################# END PAR COMPILER SECTION ##################
use Tk;
use Tk ':eventtypes';
use Tk::X11Font;
use Tk::ROText;
use Tk::JPEG;
#use Geo::Weather;
use LWP::Simple;
use  Tk::Balloon;

our $VERSION = '3.43';

my $havetime2str = 0;
eval { require 'Date/Time2fmtstr.pm'; $havetime2str = 1; };

	my $geometry = '';
	my ($cputmp, $sensorline, $ballonToggle);
	my $thisPgm = $0;
	$thisPgm =~ s#\\#\/#gs;
	(my $thisPgmName = $thisPgm) =~ s#.+\/([^\/]+)$#$1#;
	my $bummer = ($^O =~ /Win/) ? 1 : 0;
	if ($bummer)
	{
		$ENV{HOME} ||= $ENV{USERPROFILE}  if (defined $ENV{USERPROFILE});
		$ENV{HOME} ||= $ENV{ALLUSERSPROFILE}  if (defined $ENV{ALLUSERSPROFILE});
		$ENV{HOME} =~ s#\\#\/#gs;
	}

	my $checkmsec = '720000';
	my $checkmsec_onerror = '180000';
	my $relief = 'ridge';
	my $windowmgr = 0;
	my $startimage = 'tkweather.gif';
	my $icontype = 'gif';
	my $fcicontype = 'gif';
	my $index = 'heat';
	my $normalcolor = 'green';
	my $framecolor = '#222222';
	my $bgcolor = 'black';
	my $warningcolor = 'yellow';
	my $warntypes = 'tornado|storm|blizard|freeze|flood|heat';
	my $alertcolor = 'red';
	my $metric = 0;
	my $debug = 0;
	my $silent = 0;
	my $alertcmd = 0;
	my $balloons = 1;
	my $hwarningcolor;
	my $cwarningcolor;
	my $calertcolor;
	my $nocputemp = 0;
	my $noshowzip = 1;
	my $noshowsite = 0;
	my $font = '-*-lucida console-bold-r-*-*-9-*-*-*-*-*-*-*';

	#FETCH COMMAND-LINE OPTIONS:

	my (@NEWARGV, %opts, %noSimpleGet, @cputemp, @text, $referencedUrl);

	while (@ARGV) {
		$_ = shift(@ARGV);
		if (/^\-\-(\w+)/o) {
			my $one = $1;
			$opts{$one} = (/\=\"?([^\"]+)\"?$/o) ? $1 : 1;
		} elsif (/^\-(\w+)/o) {
			$opts{'-'} = $1;
			my @v = split('', $opts{'-'});
			my $opt;
			while (@v)
			{
				$opt = shift @v;
				$opts{$opt} = 1;
			}
			$opts{help} = 1  if ($opts{h});  #ALLOW OLD-STYLE "-h" for HELP!
			$opts{debug} = 1  if ($opts{d});
		} else {
			push (@NEWARGV, $_);
		}
	}
	my $cfgFile = $thisPgmName;
	if ($cfgFile =~ /\./) {
		$cfgFile =~ s/\..*$/\.cfg/;
	} else {
		$cfgFile .= '.cfg';
	}

	my $zipcode = '76087';    #DEFAULT IS AUTHOR'S ZIPCODE!
	my $browser = $bummer ? 'start' : 'mozilla';
	if ($opts{help}) {
		warn "..usage $0 [-d|--debug][--browser=<webbrowser>][--config=<configfile>[--geometry=wxh+x+y][--windowmgr=0|1][--index=heat|misery][--metric=0|1] [zipcode]\n";
		warn "..defaults (unless specified in config file):  --debug=0 --browser=$browser --config=$ENV{HOME}/tkweather/$cfgFile --windowmgr=0 --index=heat --metric=0 $zipcode\n";
		exit(0);
	}

	$cfgFile = $opts{config}  if (defined($opts{config}) && -f $opts{config} && -r $opts{config});
	$cfgFile = "$ENV{HOME}/tkweather/" . $cfgFile  unless ($cfgFile =~ m#^(?:\/|\w\:)#o);
	unless (-r $cfgFile)
	{
		$cfgFile = $thisPgm;
		if ($cfgFile =~ /\./) {
			$cfgFile =~ s/\..*$/\.cfg/;
		} else {
			$cfgFile .= '.cfg';
		}
	}

	if (-r $cfgFile && open(IN, $cfgFile))
	{
		my ($var, $val);
		while (<IN>)
		{
			chomp;
			next  if (/^\s*\#/o);
#		s/\s*\#.*$//o;
			($var, $val) = split(/\=/o, $_, 2);
			next  unless ($var =~ /^(?:zipcode|browser|weathercmd|checkmsec|relief|windowmgr|geometry|index|startimage|normalcolor|bgcolor|warntypes|warningcolor|alertcolor|debug|metric|silent|nocputemp|cwarningcolor|hwarningcolor|calertcolor|framecolor|font|balloons\d)$/o);
#print STDERR "--eval: var=$var= val=$val=\n";
			eval "\$$var = '$val';";
		}
	}

#NOW OVERRIDE ANY CONFIG FILE VALUES WITH SPECIFIED COMMAND-LINE OPTIONS:
	foreach my $var (qw(zipcode browser weathercmd checkmsec relief windowmgr geometry index startimage normalcolor bgcolor warntypes warningcolor alertcolor debug metric silent nocputemp cwarningcolor hwarningcolor calertcolor framecolor font balloons)) {
		next  unless (defined $opts{$var});
		eval "\$$var = '\$opts{$var}';";
	}

	push (@ARGV, shift(@NEWARGV)) while (@NEWARGV);

	my $weatherurl = 'https://forecast.weather.gov/zipcity.php?Go2=Go&inputstring=<ZIP>';
	my $weathercmd = 'https://forecast.weather.gov/zipcity.php?Go2=Go&inputstring=<ZIP>';
	my $idx = ($index =~ /misery/) ? 'MI' : 'HI';
#my $altweathercmds = 'https://www.wunderground.com/cgi-bin/findweather/getForecast?query=<ZIP><EXTRA>';
	my $siteName = 'NOAA';
	my $cpucrit = $metric ? 100 : 212;  #DEFAULT

	$zipcode = $ARGV[0]  if (defined $ARGV[0]);    #SET YOUR ZIP-CODE HERE.
	if ($zipcode !~ /\d+/)
	{
		my $zc = `geolocatezip.pl`;
		$zipcode = $1  if ($zc =~ /(\d\d\d\d\d)/);
		$noshowzip = 0  unless ($noshowzip > 1);
		print "-!!!!!!!!!!- (*) geolocates to ZIP=$zipcode= at=$@=\n"; #  if ($debug);
	}

	my $t = "-CONFIG FILE=$cfgFile=\n"  if ($debug);
	$weatherurl =~ s/\<ZIP\>/$zipcode/g;
	$weathercmd =~ s/\<ZIP\>/$zipcode/g;
	$referencedUrl = '';  #1ST TIME WE LOOKUP BY ZIP, THEN WE CAPTURE LOOKED UP URL TO AVOID RELOOKING UP OVERHEAD!

	my $btnState = 0;
	my $btnTextWidth = $bummer ? 10 : 6;
	my $btnTextHeight = $bummer ? 6 : 5;
	our $mw = MainWindow->new();
	$mw->title()  if ($bummer);
	$mw->overrideredirect($windowmgr);
	$mw->geometry($geometry)  if ($geometry);

	my $defaulticon = $mw->Photo(-format => $icontype, -file => "$ENV{HOME}/tkweather/$startimage");
	$mw->iconimage($defaulticon);
	my $skyicon = $defaulticon;
	my $forecasticon = $defaulticon;
	my $current;
	print STDERR "-font=$font=\n"  if ($debug);
	my $skybutton = $mw->Button(
		-fg => $normalcolor, 
		-activeforeground => $normalcolor,
		-image => $skyicon,
		-font => $font,
		-bg => 'black', 
		-activebackground => 'black',
		-width => 56,
		-height => 56,
		-pady => 2,
		-relief => $relief,
		-highlightbackground => $framecolor,
		-command => sub {
			#$skybutton->packForget();
			++$btnState;
			$btnState = 0  if ($btnState > 3);
			&reconfigButton();
		}
	)->pack(-side => 'left', -padx => 0, -pady => 0, -ipadx => 0, -ipady => 0);

	my $balloon;
	if ($balloons)
	{
		$balloon = $mw->Balloon();
		$balloon->attach($skybutton, -state => 'balloon', -balloonmsg => "TkWeather,v. $VERSION");
	}

	#$mw->bind('<Key>' => sub {
	#	my $mykey = $mw->XEvent->K;
	#	print STDERR "--TKWEATHER:  KEY=$mykey=\n"; 
	#});
	$mw->bind('<Return>' => sub { $skybutton->invoke; });
	$mw->bind('<Key-1>' => sub { $skybutton->invoke; });
	$mw->bind('<Key-l>' => sub { $skybutton->invoke; });
	$mw->bind('<Key-3>' => [\&reconfigButtonReverse]);
	$mw->bind('<Key-r>' => [\&reconfigButtonReverse]);
	$mw->bind('<Shift-Control-1>' => sub { print "Exiting!"; exit(0); });
	$mw->bind('<Shift-Control-exclam>' => sub { print "Exiting!"; exit(0); });
	$mw->bind('<Enter>' => sub { 
		if ($balloons)
		{
			++$ballonToggle;
			return unless ($ballonToggle % 2);   #FOR SOME REASON THIS GETS CALLED TWICE IN A ROW ON MOUSEOVER?!

			my $showSite = $noshowsite ? '' : " ($siteName)";
			$showSite .= ' ' . $zipcode  unless ($noshowzip);
			($_ = $balloon->{'clients'}{$skybutton}->{-balloonmsg}) =~ s/\;.+//o;
			$cputmp = &getSensorData();
			if ($cputmp)
			{
				$balloon->{'clients'}{$skybutton}->{-balloonmsg} = "$_; cpu:${cputmp}".chr(186)
						.$showSite;
			}
			else
			{
				s/\;.+//o;
				$balloon->{'clients'}{$skybutton}->{-balloonmsg} = "$_;"
						.$showSite;
			}
		}
	});

sub refresh_data { #REFRESH DATA
		--$btnState;  #UNDO THE BUTTON-STATE ADVANCE ON CLICK.
		$btnState = 3  if ($btnState < 0);
		--$btnState;
		$btnState = 3  if ($btnState < 0);
		&getweather();
}

	$mw->bind('<Double-1>' => [\&refresh_data]);
	$mw->bind('<Alt-1>' => [\&refresh_data]);
	$mw->bind('<ButtonRelease-3>' => [\&reconfigButtonReverse]);
	$mw->bind('<Alt-Key-1>' => [\&refresh_data]);
	$mw->bind('<Alt-Key-l>' => [\&refresh_data]);

sub Shift_1 {    #PULL UP SITE'S WEBPAGE:
print STDERR "-1- BEF: btnState=$btnState=\n"  if ($debug);
		--$btnState;
		$btnState = 3  if ($btnState < 0);
#		&getweather();
		$mw->update;
		my $cmd = $weathercmd;
print STDERR "-2- AFT: btnState=$btnState= browser=$browser= CMD=$cmd=\n"  if ($debug);
		system($browser, $cmd);
}

	$mw->bind('<Shift-1>' => [\&Shift_1]);    #Shift-Mousebutton1
	$mw->bind('<Key-exclam>' => [\&Shift_1]); #Shift-1 ("!")
	$mw->bind('<Key-L>' => [\&Shift_1]);      #Shift-l ("L")
	$mw->bind('<Shift-Return>' => [\&Shift_1]);

	my @wkdays = (qw(SU MO TU WE TH FR SA));

#1$weather = new Geo::Weather;
#1die "-Could not create Geo::Weather object $!"  unless ($weather);

	$mw->update();

	unless (&getweather())
	{
		$skyicon ||= $defaulticon;
		$forecasticon ||= $skyicon;
		&reconfigButton(1);
	}
#x $mw->repeat($checkmsec, \&getweather);

MainLoop;

sub getweather
{
	&doSomeOtherStuffFirst();

	unless ($silent && !$debug) {
		my $now = $havetime2str ? Date::Time2fmtstr::time2str(time, 'HH:mi - ') : '';
		print STDERR "i:${now}TkWeather v$VERSION fetching weather for zip: $zipcode...";
	}

	$current = &get_weather();
	unless (defined $current) {
print STDERR "s:get_weather() FAILED!\n"  unless ($silent && !$debug);
		$mw->after($checkmsec_onerror, \&getweather);
		return 0;
	}
	$mw->after($checkmsec, \&getweather);  #THIS SEEMS TO HAVE TO BE HERE TO REPEAT?!

	my $iconid = '';
	my $fciconid = '';
	my %out;

	print STDERR $current->{temp} . "°\n"  unless ($silent && !$debug);
	$_ = '';
	$_ = "-p $ENV{HTTP_PROXY}"  if ($ENV{HTTP_PROXY});
print STDERR "---pic=".$current->{pic}."=\n"  if ($debug);
	if ($current->{pic} =~ /([\w\d]+\.)(gif|jpg|png|svg)$/io)
	{
		$icontype = $2;
		$iconid = $1.$icontype;
		$icontype = 'jpeg'  if ($icontype =~ /jpg/io);   #FOR SOME REASON THEY DIDN'T NAME THIS RIGHT?!
	}
	elsif ($current->{pic} =~ /\.php\?(.+)/)
	{
		($iconid = $1) =~ s/[^a-z0-9\-\_]+//g;
		$icontype = 'gif';
		$iconid .= '.' . $icontype;
	}
	if ($current->{pic2} =~ /([\w\d]+\.)(gif|jpg|png|svg)$/io)
	{
		$fcicontype = $2;
		$fciconid = $1.$fcicontype;
		$fcicontype = 'jpeg'  if ($fcicontype =~ /jpg/io);   #FOR SOME REASON THEY DIDN'T NAME THIS RIGHT?!
	}
	elsif ($current->{pic2} =~ /\.php\?(.+)/)
	{
		($fciconid = $1) =~ s/[^a-z0-9\-\_]+//g;
		$fcicontype = 'gif';
		$fciconid .= '.' . $fcicontype;
	}
print STDERR "----iconid=$iconid= type=$icontype=\n"  if ($debug);
print STDERR "----fciconid=$fciconid= type=$fcicontype=\n"  if ($debug);
	if ($iconid)
	{
		my $iconid_new = $iconid;

		$iconid_new =~ s/\.(?:png|svg)/\.gif/io;
print STDERR "---------CHECKING for =$ENV{HOME}/tkweather/$iconid_new=\n"  if ($debug);
		my $gotit = 0;
		if (-r "$ENV{HOME}/tkweather/$iconid_new")
		{
			my @statInfo = stat "$ENV{HOME}/tkweather/$iconid_new";
print STDERR "---statinfo7=$statInfo[7]=\n"  if ($debug);
			if ($statInfo[7] >= 100)
			{
				if ($icontype =~ /(?:png|svg)/io)
				{
					$iconid = $iconid_new;
					$icontype = 'gif';
				}
print STDERR "+++Already have icon ($iconid) cached!\n"  if ($debug);
				$gotit = 1;
			}
		}
		unless ($gotit)
		{
print STDERR "---must download (new?) icon(".$current->{pic}.") => $ENV{HOME}/tkweather/$iconid!\n"  if ($debug);
			print "****** LWP REQUEST=lwp-request $_ -H \"Pragma: no-cache\" $current->{pic} >$ENV{HOME}/tkweather/$iconid=\n"  if ($debug);
			`lwp-request $_ -H "Pragma: no-cache" $current->{pic} >"$ENV{HOME}/tkweather/$iconid"`;
			my @statInfo = stat "$ENV{HOME}/tkweather/$iconid";
			if ($statInfo[7] < 100)
			{
print STDERR "-!!!!!!- LWP-REQUEST FAILED, WILL TRY WGET for image!\n"  if ($debug);
				`/usr/bin/wget -t 2 -T 20 \"$$current{pic}\" -O- 2>/dev/null >$ENV{HOME}/tkweather/$iconid`;
			}
print STDERR "-???- iconid=$iconid= type=$icontype=\n"  if ($debug);
			if ($icontype =~ /(?:png|svg)/io && -r "$ENV{HOME}/tkweather/$iconid")
			{
print STDERR "-?????? (convert -resize 60x60 \"$ENV{HOME}/tkweather/$iconid\" \"$ENV{HOME}/tkweather/$iconid_new\")\n"  if ($debug);
				`convert -resize 60x60 "$ENV{HOME}/tkweather/$iconid" "$ENV{HOME}/tkweather/$iconid_new"`;
				unlink "$ENV{HOME}/tkweather/$iconid"  unless ($debug);
				$iconid = $iconid_new;
				$icontype = 'gif';
			}
		}
	}
		
	if ($fciconid)
	{
		my $iconid_new = $fciconid;

		$iconid_new =~ s/\.(?:png|svg)/\.gif/io;
print STDERR "---------CHECKING for =$ENV{HOME}/tkweather/$iconid_new=\n"  if ($debug);
		my $gotit = 0;
		if (-r "$ENV{HOME}/tkweather/$iconid_new")
		{
			my @statInfo = stat "$ENV{HOME}/tkweather/$iconid_new";
print STDERR "---statinfo7=$statInfo[7]=\n"  if ($debug);
			if ($statInfo[7] >= 100)
			{
				if ($fcicontype =~ /(?:png|svg|jpg)/io)
				{
					$fciconid = $iconid_new;
					$fcicontype = 'gif';
				}
print STDERR "+++Already have forecast icon ($fciconid) cached!\n"  if ($debug);
				$gotit = 1;
			}
		}
		unless ($gotit)
		{
print STDERR "---must download (new?) icon(".$current->{pic2}.") => $ENV{HOME}/tkweather/$fciconid!\n"  if ($debug);
			print "****** LWP REQUEST=lwp-request $_ -H \"Pragma: no-cache\" $current->{pic2} >$ENV{HOME}/tkweather/$fciconid=\n"  if ($debug);
			`lwp-request $_ -H "Pragma: no-cache" $current->{pic2} >"$ENV{HOME}/tkweather/$fciconid"`;
			my @statInfo = stat "$ENV{HOME}/tkweather/$fciconid";
			if ($statInfo[7] < 100)
			{
print STDERR "-!!!!!!- LWP-REQUEST FAILED, WILL TRY WGET for image!\n"  if ($debug);
				`/usr/bin/wget -t 2 -T 20 \"$$current{pic2}\" -O- 2>/dev/null >$ENV{HOME}/tkweather/$fciconid`;
			}
print STDERR "-???- iconid=$fciconid= type=$fcicontype=\n"  if ($debug);
			if (-r "$ENV{HOME}/tkweather/$fciconid")
			{
				if ($fcicontype =~ /(?:png|svg|jpg)/io)
				{
print STDERR "-?????? (convert -resize 60x60 \"$ENV{HOME}/tkweather/$fciconid\" \"$ENV{HOME}/tkweather/$iconid_new\")\n"  if ($debug);
					`convert -resize 60x60 "$ENV{HOME}/tkweather/$fciconid" "$ENV{HOME}/tkweather/$iconid_new"`;
					unlink "$ENV{HOME}/tkweather/$fciconid"  unless ($debug);
					$fciconid = $iconid_new;
					$fcicontype = 'gif';
				}
				elsif ($fcicontype =~ /gif/io)
				{
					`mv "$ENV{HOME}/tkweather/$fciconid" "$ENV{HOME}/tkweather/.tmp.gif"`;
					`convert -resize 60x60 "$ENV{HOME}/tkweather/.tmp.gif" "$ENV{HOME}/tkweather/$fciconid"`;
					if (-r "$ENV{HOME}/tkweather/$fciconid") {
						unlink "$ENV{HOME}/tkweather/.tmp.gif"  unless ($debug);
					} else {  #IF RESIZE SOMEHOW FAILED!:
						`mv "$ENV{HOME}/tkweather/.tmp.gif" "$ENV{HOME}/tkweather/$fciconid"`;
					}
				}
			}
		}
	}

	my $barodir = $1  if ($current->{baro} =~ s/([A-Z])$//o);
	$current->{uvrating} = ($current->{uv} =~ /(\w+)$/o) ? $1 : '';
	$current->{baro} = $1  if ($current->{baro} =~ /^\s*([\d\.]+)/o);
	$current->{visb} = $1  if ($current->{visb} =~ /^\s*([\d\.]+)/o);
	$current->{visb} ||= '99.9';
	$current->{uv} = ($current->{uv} =~ /^\s*([\d\.]+)/o) ? $1 : 0;
	$_ = $current->{cond};
	$current->{cond} = substr($_,0,9)  if (length($_) > 9);
	$current->{baro} .= $barodir;
	my $winddir = 0; $current->{windspeed} = 0;
	($winddir, $current->{windspeed}) = ($1, $2)  if ($current->{wind} =~ /From\s+(\w+)\s+at\s+([\d\.]+)/o);
	$winddir =~ s/\s+//go;
	$winddir =~ s/North/N/igo;
	$winddir =~ s/South/S/igo;
	$winddir =~ s/East/E/igo;
	$winddir =~ s/West/W/igo;
	$winddir = 'CLM'  unless ($current->{windspeed} =~ /[1-9]/o);
	$winddir ||= 'CLM';
	my $idxdesc;
	if ($current->{temp} < 65 || ($current->{temp} < 70 && $current->{windspeed} >= 10))
	{
		$current->{misery} = $current->{heat};
		$idxdesc = 'WC';
	}
	else
	{
		$idxdesc = $idx;
		if ($idx =~ /M/o)
		{
			$_ = (($current->{dewp} *2) + $current->{humi}) / 3; #FACTOR IN BOTH REL. HUMIDITY & DEWPOINT. 
			#ENDED UP USING BOTH AND WEIGHING IN FAVOR OF DEWPOINT.
			#TWEAK MISERY INDEX TO FACTOR IN BREEZE! (WINDSPEED * (1 - HUMIDITY))
			#$misery = sprintf('%.0f',($current->{temp} + $_) - int($windspeed * (1 - ($current->{humi} / 100))));
			$current->{misery} = sprintf('%.0f',(($current->{temp} + $_) - int($current->{windspeed} * (1 - ($current->{humi} / 100)))) * 0.6667);
		}
		else
		{
			$current->{misery} = $current->{heat};
		}
	}

	foreach my $i (qw(cond temp humi baro dewp uv visb heat misery windspeed gust))
	{
		$out{$i} = $current->{$i};
	}
	$out{windspeed} = $metric ? sprintf('%.0f',1.609*$current->{windspeed})
			: sprintf('%.0f',$current->{windspeed});
	$out{winddir} = $winddir;
	$out{gust} = '';
	if ($metric) {
		foreach my $i (qw(temp dewp heat misery))  #CONVERT FAIRENHEIGHT TO CELCIUS
		{
			$out{$i} = sprintf('%.0f',($out{$i} - 32) / 1.8);
		}
		$out{visb} = sprintf('%.0f',1.609*$current->{visb});
		$out{windspeed} = sprintf('%.0f',1.609*$current->{windspeed});
		$out{gust} = sprintf('G%.0f',1.609*$current->{gust})  if ($current->{gust} > $current->{windspeed});
	} else {
		$out{windspeed} = sprintf('%.0f',$current->{windspeed});
		$out{gust} = sprintf('G%.0f',$current->{gust})  if ($current->{gust} > $current->{windspeed});
	}
	$_ = $balloon->{'clients'}{$skybutton}->{-balloonmsg};
#x	if ($current->{temp} < 65 || ($current->{temp} < 70 && $current->{windspeed} >= 10)
#x			&& ($current->{temp}-$current->{misery}) > 5)
	if ($idxdesc =~ /W/o)
	{
		$_ .= " (W.CHILL=".$out{heat}.")";
	}
	elsif ($idxdesc =~ /M/o)
	{
#		$_ .= ($misery >= 160) ? "(MISERY=$misery)" : "(Misery=$misery)"
#				if ($misery >= 150);
#		$_ .= " (MISERY=$misery)" 	if ($misery >= 150);
		$_ .= " (MISERY=".$out{misery}.")" 	if ($current->{misery} >= 100);
	}
	else  #($idxdesc eq 'HI')
	{
		$_ .= " (HEAT indx=".$out{heat}.")"  if ($current->{heat} > $current->{temp});
	}
	$balloon->{'clients'}{$skybutton}->{-balloonmsg} = $_;

	$skyicon = ''; $forecasticon = '';
	if ($iconid && -r "$ENV{HOME}/tkweather/$iconid")
	{
		eval { $skyicon = $mw->Photo(-format => $icontype, -file => "$ENV{HOME}/tkweather/$iconid"); };
	}
	$skyicon ||= $defaulticon;
	if ($fciconid && -r "$ENV{HOME}/tkweather/$fciconid")
	{
		eval { $forecasticon = $mw->Photo(-format => $fcicontype, -file => "$ENV{HOME}/tkweather/$fciconid"); };
	}
	$forecasticon ||= $defaulticon;
	my ($min, $hour, $wday);
	(undef,$min,$hour,undef,undef,undef,$wday) = localtime();
	if ($metric)
	{
		$text[1] = sprintf("%-2s %2.2d:%2.2d\n%-9s\nTmp:%3.0fc\nHum:%4s\n%3s%3.0f%3s",
					$wkdays[$wday], $hour, $min, $out{cond}, $out{temp}, 
					$out{humi}, $out{winddir}, $out{windspeed}, $out{gust});
	}
	else
	{
		$text[1] = sprintf("%-2s %2.2d:%2.2d\n%-9s\nTemp:%3.0f\nHum:%4s\n%3s%3.0f%3s",
					$wkdays[$wday], $hour, $min, $out{cond}, $out{temp}, 
					$out{humi}, $out{winddir}, $out{windspeed}, $out{gust});
	}
	$text[2] = sprintf("b:%5.2f%1s\nDew: %3d\n${idxdesc}:  %3d\nUV:   %2d\nVis:%4.1f", 
				$out{baro}, $barodir, $out{dewp}, $out{misery}, 
				$out{uv}, $out{visb});

	if ($debug)
	{
		foreach my $i (sort keys %$current)
		{
			print STDERR "----($i): $current->{$i}\n";
		}
	}

	&reconfigButton();
	if ($current->{alert} =~ /warning/io)  #FLIP THE BUTTON THRU THE 4 FACES TO ALERT USER:
	{
		$mw->bell;  #RING THE BELL!
		for (my $i=0;$i<=3;$i++) {
			++$btnState;
			$btnState = 0  if ($btnState > 3);
			sleep(1);
			&reconfigButton();
		}
		`$alertcmd $current`  if ($alertcmd && $current->{alert} =~ /warning/io);
	}
	return 1;
}

sub reconfigButton
{
	my $reset = shift || 0;
	my $fg = $normalcolor;
	my $bg = $bgcolor;
	if ($reset) {
		$btnState = 0;
	} else {
		if ($current->{temp} >= 90)
		{
			$fg = $hwarningcolor || $warningcolor  if ($btnState == 1);
			$bg = $hwarningcolor || $warningcolor;
		}
		elsif ($current->{temp} < 50)
		{
			$fg = $cwarningcolor || $warningcolor  if ($btnState == 1);
			$bg = $cwarningcolor || $warningcolor;
		}
		if ($current->{windspeed} >= 20)
		{
			$fg = $warningcolor || $warningcolor  if ($btnState == 1);
			$bg = $warningcolor || $warningcolor;
		}
		#if (($idx eq 'MI' && $misery >= 150) || $uvrating =~ /High/io
		if (($idx eq 'MI' && $current->{misery} >= 100) || $current->{uvrating} =~ /High/io
				|| $current->{uv} > 7
				|| $current->{visb} < 3)
		{
			$fg = $warningcolor  if ($btnState == 2);
			$bg = $warningcolor;
		}
		elsif (($idx eq 'HI' && $current->{misery} >= 95) || $current->{visb} < 3)
		{
			$fg = $warningcolor  if ($btnState == 2);
			$bg = $warningcolor;
		}
		elsif ($current->{alert} =~ /watch/io)
		{
			$fg = $warningcolor  if ($btnState == 0);
			$bg = $warningcolor;
		}
		if ($current->{windspeed} >= 35)
		{
			$fg = $alertcolor  if ($btnState == 1);
			$bg = $alertcolor;
		}
		if ($current->{temp} <= 32)
		{
			$fg = $calertcolor || $alertcolor  if ($btnState == 1);
			$bg = $calertcolor || $alertcolor;
		}
		elsif ($current->{temp} >= 100)
		{
			$fg = $alertcolor  if ($btnState == 1);
			$bg = $alertcolor;
		}
		#if (($idx eq 'MI' && $misery >= 160) || $current->{visb} < 1.5)
		if (($idx eq 'MI' && $current->{misery} >= 107) || $current->{visb} < 1.5)
		{
			$fg = $alertcolor  if ($btnState == 2);
			$bg = $alertcolor;
		}
		elsif (($idx eq 'HI' && $current->{misery} >= 105) || $current->{visb} < 1.5)
		{
			$fg = $alertcolor  if ($btnState == 2);
			$bg = $alertcolor;
		}
		if ($current->{alert} =~ /warning/io)
		{
			$fg = $alertcolor  if ($btnState == 0 || $btnState == 3);
			$bg = $alertcolor;
		}
		elsif ($cputmp >= $cpucrit)
		{
			$fg = $alertcolor  if ($btnState == 0 || $btnState == 3);
			$bg = $alertcolor;
		}
	}
	if ($btnState && $btnState < 3) {  #(1|2=text):
		$skybutton->configure(
				-image => undef,
				-height => $btnTextHeight,
				-width => $btnTextWidth,
				-text => $text[$btnState],
				-fg => $fg,
				-activeforeground => $fg,
				-bg => $bgcolor,
				-activebackground => $bgcolor,
		);
	} else {          #0=image:
		$skybutton->configure(
				-image => ($btnState == 3) ? $forecasticon : $skyicon,
				-height => 54,
				-width => 54,
				-fg => $fg,
				-activeforeground => $fg,
				-bg => $bg,
				-activebackground => $bg,
		);
	}
	$mw->update;
}

sub reconfigButtonReverse {
	$btnState -= 2;
	$btnState += 4  if ($btnState < 0);
	$skybutton->invoke;
}


sub get_weather
{
	print STDERR "-get weather: site url=$weatherurl=\n"  if ($debug);
	my $html = ($noSimpleGet{$weatherurl}) ? '' : LWP::Simple::get($weatherurl);
	unless ($html)
	{
print STDERR "-!!!!!!- LWP::Simple::get($weatherurl) FAILED! -- trying WGET:\n"  if ($debug);
		if (open (URLIN, "/usr/bin/wget -t 2 -T 20 \"$weatherurl\" -O- 2>/dev/null |"))
		{
			$html .= $_  while (<URLIN>);
			close URLIN;
		}
		$noSimpleGet{$weatherurl} = 1;
	}
	my $c;
	my $tempConv;
	my $t;
	my $html2 = '';
	if ($html)
	{
		if ($html =~ m#javascript\'\>window\.location\.href\=\'([^\']+)\'\<#o) { #MORE JAVASCRIPT CRAP!:
			my $weatherurlRedirect = $1;
print STDERR "-0: JS redirecting to ($weatherurlRedirect)\n"  if ($debug);
			$html = LWP::Simple::get($weatherurlRedirect);
		}
		if (!$referencedUrl && $html =~ m#\<span\s+class\=\"lang\-spanish\"\>\<a\s+href\=\"([^\"]+)#s) {
			($referencedUrl = $1) =~ s/\&lg\=sp.*$//so;
			$referencedUrl = 'https:'.$referencedUrl  if ($referencedUrl =~ m#^\/\/#);
			$weatherurl = $weathercmd = $referencedUrl;
print STDERR "-0: REDIRECTED TO URL=$weatherurl=\n"  if ($debug);
		}
		$c->{pic} = ($html =~ s#id\=\"current\_conditions\-summary\"\s+class\=\"[^\<]+?\<img\s+src\=\"([^\"]+)\"##) ? $1 : '';
print STDERR "-1: pic=".$c->{pic}."=\n"  if ($debug);
		$c->{pic2} = ($html =~ s#\<img\s+src\=\"([^\"]+)\"[^\>]+?class\=\"forecast\-icon\"\>##) ? $1 : '';
		$c->{pic2} ||= ($html =~ s#\<img\s+class\=\"forecast\-icon\"\s+src\=\"([^\"]+)\"[^\>]+?\>##) ? $1 : '';
		$c->{pic2} =~ s#DualImage\.php\?i\=([\w\d]+)[^\"]+$#https\:\/\/forecast\.weather\.gov\/newimages\/medium\/$1\.png#;
print STDERR "-1: pic=".$c->{pic}."=\n"  if ($debug);
		unless ($c->{pic})
		{
			$c->{pic} = $1  if ($html =~ s#\<img src\=\"([^\"]+)\"\s+width\=\"\d+\"\s+height\=\"\d+\"\s+alt\=\"##);
			$c->{pic} ||= $c->{pic2};
print STDERR "-2: pic=".$c->{pic}."=\n"  if ($debug);
		}
		$c->{pic} = 'https://forecast.weather.gov/' . $c->{pic}  unless ($c->{pic} =~ m#^\/#o);
		$c->{pic2} = 'https://forecast.weather.gov/' . $c->{pic2}  unless ($c->{pic2} =~ m#^\/#o);
print STDERR "-3: pic=".$c->{pic}."=\n"  if ($debug);
		if ($html =~ m!myforecast\-current\-lrg\"\>(.+?)\&deg\;F\<!o)
		{
			$c->{temp} = $1;
print STDERR "-NOAA: temp=".$c->{temp}."=\n"  if ($debug);
		}
		$c->{alert} = ($html =~ /\<div\s+class\=\"headline\-title\"\>.*?((?:$warntypes)\s+(?:watch|warning|advisory)).*?\<\/div\>/sio) ? $1 : '';
print STDERR "------ALERT0=".$c->{alert}."=\n"  if ($debug);
		$c->{alert} ||= ($html =~ /id\=\"anchor\-hazards\"\>.*?((?:$warntypes)\s+(?:watch|warning|advisory)).*?\</iso) ? $1 : '';
print STDERR "------ALERT1=".$c->{alert}."=\n"  if ($debug);
		$c->{alert} ||= ($html =~ /Hazardous weather condition\(s\)\:.*\<span class\=\"warn\"\>((?:$warntypes)\s+(?:watch|warning))\<\/span\>.+\<\/div\>/sio) ? $1 : '';
print STDERR "------ALERT2=".$c->{alert}."=\n"  if ($debug);
		$html =~ s!\/current\s+conditions.*$!!iso;
		if ($html =~ s!^.+?myforecast\-current\"\>([^\<]+)!!so)
		{
			($c->{long_cond} = $1) =~ s/\s+$//o;
			$c->{long_cond} =~ s/^\s+//o;
		}
		$c->{dewp} = $1  if ($html =~ m!Dewpoint.+?\>(\-?\d+)\s*\&deg\;F!so);
#############			$c->{uv} = $1  if ($html =~ m!UV\:\<\/td\>.+?\>(\d+) \<span!s);
		$c->{humi} = $1  if ($html =~ m!Humidity.+?\>(\d+)!so);
		$c->{gust} = '0';
		if ($html =~ s!Wind Speed.+?\>Calm!!sio) {
			$c->{wind} = "Calm";
		} else {
			$c->{wind} = "From $1 at $2"  if ($html =~ s!Wind Speed.+?\>(\w+)\s+(\d+)(?:\s+G\s*(\d+))?!!sio);
			$c->{gust} = $3 || '0';
		}
print STDERR "------wind=$c->{wind}= gust=$c->{gust}=\n"  if ($debug);
		$c->{baro} = $1  if ($html =~ m!Barometer.+?\>([\d\.]+)!so);
print STDERR "------baro=".$c->{baro}."=\n"  if ($debug);
		$c->{baro} .= ' ';
		$c->{heat} = $1  if ($html =~ m!(?:Wind\s+Chill|Heat\s+Index).+?\>(\-?[\d\.]+)!so);
		#$c->{heat} = $1  if ($html =~ /Feels Like\<BR\>\s*(\-?\d+)\&/s);
print STDERR "------WIND CHILL=".$c->{heat}."=\n"  if ($debug);
		$c->{visb} = $1  if ($html =~ m!Visibility.+?\>([\d\.]+)!so);
		$c->{cond} ||= $c->{long_cond};  #<img src="http://icons.wunderground.com/graphics/conds/nt_clear.GIF" alt
		$_ = $c->{cond};
		$tempConv = $c->{temp};
		$tempConv = ($tempConv - 32) / 1.8  if ($metric);
		if ($balloons)
		{
		  	my $alert = $c->{alert} ? "\U$c->{alert}\E! " : '';
			$balloon->{'clients'}{$skybutton}->{-balloonmsg} = (sprintf('%.0f',$tempConv).chr(186). (($alert || $c->{long_cond}) ? ", ${alert}$c->{long_cond}" : ''));
		}
		$balloon->idletasks  if ($balloons);
		$c->{heat} = $c->{temp}  unless ($c->{heat} =~ /\d/o);
	} else {
		print STDERR "******* NO HTML! ********\n";
		$noSimpleGet{$weatherurl} = 0;  #wget FAILED TOO, WE'LL GRY AGAIN LATER W/LWP::Simple::Get().
		return undef;
	};
	$cputmp = &getSensorData();
print STDERR "-called sensors cpu=$cputmp= crit=$cpucrit=!\n"  if ($debug);
	return $c;
}

sub getSensorData {
	return 0  unless (!$nocputemp && -x '/usr/bin/sensors');

	my ($cputmp);
	my @cputemp=`/usr/bin/sensors`;
print STDERR "-1: cputemp data=@cputemp=\n"  if ($debug >= 2);
	if ($sensorline)
	{
		my $t = $cputemp[$sensorline];
		$cputmp = $1  if ($t =~ s/\+([\d\.]+)//o);
		if ($metric)
		{
			$cputmp = ($cputmp - 32) / 1.8  unless ($t =~ /°C/o);
		}
		else
		{
			$cputmp = ($cputmp * 1.8) + 32  if ($t =~ /°C/o);
		}
		$cputmp = sprintf('%.0f', $cputmp);
print STDERR "--getSensorData SHORT: tmp=$cputmp= crit=$cpucrit= \n"  if ($debug);
		return $cputmp;
	}
	$sensorline = 0;
	while (@cputemp)
	{
		my $t = shift(@cputemp);
		++$sensorline;
		next  unless ($t =~ /^Core /o);
		if ($t =~ s/\+([\d\.]+)//o)
		{
			$cputmp = $1;
			$cpucrit = $1  if ($t =~ s/\+([\d\.]+)//o);
			if ($metric)
			{
				$cputmp = ($cputmp - 32) / 1.8  unless ($t =~ /°C/o);
				$cpucrit = ($cpucrit - 32) / 1.8  unless ($t =~ /°C/o);
			}
			else
			{
				$cputmp = ($cputmp * 1.8) + 32  if ($t =~ /°C/o);
				$cpucrit = ($cpucrit * 1.8) + 32  if ($t =~ /°C/o);
			}
			$cputmp = sprintf('%.0f', $cputmp);
print STDERR "--getSensorData LONG: t=$t= tmp=$cputmp= crit=$cpucrit= metric=$metric= sline=$sensorline=\n"  if ($debug);
			return $cputmp;
		}
	}
print STDERR "--getSensorData FAIL: crit=$cpucrit= metric=$metric=\n"  if ($debug);
	return 0;
}

#JWT:I PUT THIS HERE TO DO STUFF THAT NEEDS CHECKING EVERY FEW MINUTES,
#BUT DON'T WANT TO HAVE TO CREATE YET ANOTHER DAEMON TO DO!:
sub doSomeOtherStuffFirst {
	#USER CAN ADD ANYTHING HE WANTS DONE WHENEVER TKWEATHER FETCHES WEATHER DATA:
}

__END__
