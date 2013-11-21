#!/usr/bin/perl

## Set the init_script variable to the bash script that 
## starts / stops / restarts your server
my $init_script = "/etc/init.d/minecraft";

## Set coords for spawn and jail, at least.  You can add
## more coords if you have more destinations to support.
my $coords = { 
	'spawn' => "193 69 241", 
	'jail' => "2 2 2" 
};


# read the ops.txt file and make sure we don't ban ops.
my ($line, $cmd, $staff_username, $truncate, %ops);
unless(open(OPSFILE, "ops.txt")) {
 die "cannot read ops.txt file";
}
while ($line = <OPSFILE>) {
	chomp($line);
	$ops{$line} = 1;
}
close(OPSFILE);

unless(open(LOGFILE, "logs/latest.log")) {
 die "cannot read logfile";
}
while ($line = <LOGFILE>) {
   next if ($line !~ /\<\§[a-zA-Z0-9]([\w\d\_]+)\§r\>/);
   $staff_username = $1;
    # Found a line from a team member
    if ($line =~ /(ban|ban\-ip|kick|jail|unjail|pardon|pardon\-ip|spawn)\: *([a-zA-Z0-9\_]+)/i) {
  	next if ($1 =~ /^notch$/i); #;-)
  	next if ($ops{$1} && ($1 =~ /^(jail|ban)/i ));
    print STDERR "Found a request for: $1 $2\n";
	if ($1 eq "jail") {
		$cmd = "$init_script command tp $2 " . $coords->{'jail'};
	} elsif ($1 eq "unjail") {
		$cmd = "$init_script command tp $2 " . $coords->{'spawn'};
	} elsif ($1 eq "spawn") {
                $cmd = "$init_script command tp $2 " . $coords->{'spawn'};
    } else {
		$cmd = "$init_script command $1 $2";
	}
	`$cmd`;
	$truncate = 1;
    }
}
close(LOGFILE);

if ($truncate) {
	my $datestamp = `date +%F-%H-%M-%S`;
	chomp($datestamp);
	$cmd = "cp logs/latest.log logs/" . $datestamp . ".log";
	`$cmd`;
	$cmd = "truncate --size=0 logs/latest.log";
	`$cmd`;
}



