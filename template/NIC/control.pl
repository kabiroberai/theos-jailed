my $fileName = NIC->prompt(undef, "Path to .ipa");
local $/=undef;
open FILE, $fileName or die "Couldn't read $!";
NIC->mkfile("app.ipa")->data = <FILE>;
close FILE;
