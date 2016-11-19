use Cwd 'abs_path';
my $ipaPath = NIC->prompt(undef, "Path to .ipa");
$ipaPath =~ s/^\s+|\s+$//g; # Trim whitespace
NIC->variable("IPA") = abs_path($ipaPath);
