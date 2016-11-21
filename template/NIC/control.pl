use Cwd 'abs_path';
NIC->variable("IPA") = abs_path(glob(NIC->prompt(undef, "Path to .ipa")));
