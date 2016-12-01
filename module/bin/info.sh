#!/bin/bash

source "$STAGE"

bundle_id="$(defaults read "$appdir/Info.plist" CFBundleIdentifier)"
product_name="${bundle_id##*.}"

r=$(tput sgr0)
b=$(tput bold)
n=$'\n'
function add { capabilities="$capabilities$n>>> $b$1$r"; }

codesign -d --entitlements - "$appdir/$app_binary" > "$ENTITLEMENTS" 2>/dev/null
if [[ $? != 0 ]]; then
	error "Failed to get entitlements for $appdir/$app_binary"
fi

for ent in $(grep -a '<key>' "$ENTITLEMENTS"); do
	case $(echo $ent | cut -f2 -d\> | cut -f1 -d\<) in
		com.apple.developer.networking.vpn.api)
			add "Personal VPN";;
		com.apple.external-accessory.wireless-configuration)
			add "Wireless Accessory Configuration";;
		com.apple.developer.homekit)
			add "HomeKit";;
		com.apple.developer.healthkit)
			add "HealthKit";;
		inter-app-audio)
			add "Inter-App Audio";;
		com.apple.developer.siri)
			add "Siri";;
		com.apple.developer.icloud*)
			add "iCloud (requires extra configuration)";;
	esac
done

if [[ -n $capabilities ]]; then
	capabilities="$(cat <<ENT
12. Select the ${b}Capabilities$r tab to the right of ${b}General$r.
13. Enable the following capabilities (ignore any that give you an error):
$capabilities
ENT)$n"
fi

eval "less -R <<EOF$n$(<$INFO_TEMPLATE)"
