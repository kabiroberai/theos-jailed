#!/bin/bash

source "$STAGE"

r=$(tput sgr0)
b=$(tput bold)
n=$'\n'
function add { capabilities="$capabilities$n>>> $b$1$r"; }

if [[ -z $BUNDLE_ID ]]; then
	BUNDLE_ID="$app_bundle_id"
	delete_app="$(cat <<ENT
${b}Note$r: Since you do not wish to change the bundle ID of the target app, 
      you must delete the original before installing the tweak. This will only
      work if you use a wildcard profile.
ENT)$n"
fi

organization_identifier="${BUNDLE_ID%.*}"
product_name="${BUNDLE_ID##*.}"
prefix=$(uuidgen)
prefix="${prefix::8}"

entitlements=$(codesign -d --entitlements - "$appdir")

for ent in $(echo "$entitlements" | grep "<key>"); do
	case $(echo "$ent" | cut -f2 -d\> | cut -f1 -d\<) in
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
		com.apple.security.application-groups)
			add "App Groups";;
		com.apple.developer.pass-type-identifiers)
			add "Wallet";;
		com.apple.developer.default-data-protection)
			add "Data Protection";;
		com.apple.developer.icloud*)
			add "iCloud (requires extra configuration)";;
	esac
done

if [[ -n $capabilities ]]; then
	capabilities="$(cat <<ENT
10. Select the ${b}Capabilities$r tab to the right of ${b}General
11. Enable the following capabilities (ignore any that give you an error):
$capabilities
ENT)$n"
fi

eval "less -R 1>&3 <<EOF$n$(<$INFO_TEMPLATE)"
