#!/usr/bin/perl

use warnings;
use File::Basename qw(basename);
use feature "switch";

my $date	 = localtime;
my $cos 	 = "default";
my $domain	 = "getafix.tk"; 
my $password = "test123";
my ($folder, $base, $base1, $base2, $groot) = "";

open(FH1, '>', "create_accounts.zmp") or die $!;
open(FH2, '>', "create_address.zmp") or die $!;

# sanitize password
$password =~ s/\"/\\\"/g;

open(RFH, '<', "a-dept.csv") or die $!;
while (<RFH>) {
    chomp;
    next if /^\s*$/;    # skip empty lines
    next if /^#/;     # skip # lines

    ($base, $folder) = split( /,/, $_, 2 );
    if ($base == 0) {
        print FH2 (qq(cf -c red -V contact "/Contacts/$folder"));
        $base1 = $groot = $folder;
    } elsif ($base == 1) {
        print FH2 (qq(cf -c red -V contact "/$base1/$folder"));
        $base2 = $folder;
    } else {
        print FH2 (qq(cf -c red -V contact "/$base1/$base2/$folder"));
    }
    print FH2 (qq{\n});
}
close(RFH);

open(UFH, '<', "b-users.csv") or die $!;
while (<UFH>) {
    chomp;
    next if /^\s*$/;    # skip empty lines
    next if /^#/;     # skip # lines

    #Number,Name Prefix,Name,Given Name,Additional Name,Family Name,email,Username,NationalID,JobTitle,Company,Department
    my ( $num, $prefix, $name, $fn, $mn, $ln, $email, $uname, $nid, $title, $company, $dept ) = split( /,/, $_, 12 );
    $dept =~ s/\r//g;
        
    given ($dept) {
        when ("Corporate")  { $folder = "/$groot"; }
        when ("ESM")        { $folder = "/$groot/ESM"; }
        when ("Sales")      { $folder = "/$groot/ESM/Sales"; }
        when ("Pre-Sales")  { $folder = "/$groot/ESM/Pre-Sales"; }
        when ("Marketing")  { $folder = "/$groot/ESM/Marketing"; }
        when ("Product")    { $folder = "/$groot/Product"; }
        when ("Engineering"){ $folder = "/$groot/Product/Engineering"; }
        when ("Management") { $folder = "/$groot/Product/Management"; }
        when ("PS")         { $folder = "/$groot/Product/PS"; }
        when ("CustService"){ $folder = "/$groot/CustService"; }
        when ("Support")    { $folder = "/$groot/CustService/Support"; }
        default             { $folder = "/$groot" }
    }
    
    print FH1 (
        qq{ca "$email" "$password"},
        ( defined($fn)       	? qq{ givenName "$fn"}      : () ),
        ( defined($mn)          ? qq{ initials "$mn"}       : () ),
        ( defined($ln)          ? qq{ sn "$ln"}             : () ),
        #( defined($uname)       ? qq{ cn "$uname"}         : () ),
        ( defined($name)        ? qq{ displayName "$name"}  : () ),
        ( defined($title)		? qq{ title "$title"}		: () ),
        ( defined($dept)		? qq{ ou "$dept"}			: () ),
        ( defined($company)		? qq{ conpany "$company"}	: () ),
        qq{ zimbraNotes "HAB Testing $date"},
        qq{ zimbraPasswordMustChange FALSE},
        qq{\n}
    );
    print FH2 (
        qq{cct -f "$folder" email "$email"}, 
        ( defined($name)    ? qq{ fullName "$name"}         : ()),
        ( defined($fn)      ? qq{ firstName "$fn"}          : ()),
        ( defined($mn)      ? qq{ middleName "$fn"}         : ()),
        ( defined($ln)      ? qq{ lastName "$ln"}           : ()),
        ( defined($dept)    ? qq{ department "$dept"}       : ()),
        ( defined($company)	? qq{ company "$company"}       : ()),
        #( defined($manager)	? qq{ notes "M - $manager"} : ()),
        ( defined($title)	? qq{ jobTitle "$title"}        : ()),
        qq{ fileAs 2},
        qq{\n}
    );
}
print FH2 (qq{mfg /$groot all r\n});
close(UFH);
close(FH1);
close(FH2);

print ("\nRun the following commands to ...\n1. Create 100 users.\n2. Create a Hierarchy structure in the admin address book.\n\n");
print ("1.\tzmprov -f create_accounts.zmp\n");
print ("2.\tzmmailbox -z -m shared_address_user -f create_address.zmp\n\n");
print ("Mount the Contacts --> $groot address book when you create a new user.\n\n");