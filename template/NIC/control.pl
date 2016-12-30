use Cwd 'abs_path';
my @ipaPaths = glob(NIC->prompt(undef, "Path to .ipa"));
NIC->variable("IPA") = abs_path($ipaPaths[0]);
NIC->variable("PACKAGENAME") =~ s/[^a-zA-Z0-9.-]/-/g
