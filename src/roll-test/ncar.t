#!/usr/bin/perl -w
# ncar roll installation test.  Usage:
# ncar.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my @packages = (
  'jasper','ncl_ncarg','ncview'
);

if($appliance =~ /$installedOnAppliancesPattern/) {
  foreach my $package(@packages) {
    ok(-d "/opt/$package", "$package installed");
  }
} else {
  ok(! $isInstalled, 'eman2 not installed');
}

$packageHome = '/opt/jasper';
SKIP: {
  skip 'jasper not installed', 1 if ! -d $packageHome;
  $output = `module load jasper; jasper --help  2>&1`;
  like($output, qr/JasPer Transcoder/, "jasper works");
}

$packageHome = '/opt/ncl_ncarg';
SKIP: {
  skip 'ncl_ncarg not installed', 1 if ! -d $packageHome;
  $output = `module load ncl_ncarg; ncl -V 2>&1`;
  like($output, qr/6.2.1/, "ncl_ncarg works");
}

$packageHome = '/opt/ncview';
SKIP: {
  skip 'ncview not installed', 1 if ! -d $packageHome;
  $output = `module load ncview; ncview  2>&1`;
  like($output, qr/Ncview 2.1.7 David W. Pierce  29 March 2016/, "ncview works");
}


foreach my $package(@packages) {
      `/bin/ls /opt/modulefiles/applications/$package/[0-9]* 2>&1`;
      ok($? == 0, "$package module installed");
     `/bin/ls /opt/modulefiles/applications/$package/.version.[0-9]* 2>&1`;
       ok($? == 0, "$package version module installed");
      ok(-l "/opt/modulefiles/applications/$package/.version",
      "$package  version module link created");
}
