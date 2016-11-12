Theos and Cycript for non-jailbroken iOS devices
================================================
This is a module for Theos designed to work with apps on non-jailbroken iOS devices. For the original (iOS 8/9) theos-jailed, see https://github.com/BishopFox/theos-jailed.

* You use it just as you would for a jailbroken device tweak (edit Tweak.xm then "make")
* It integrates Cycript
* It patches App Store apps (.ipa files) to load your tweak, Cycript, etc
* It re-signs the patched app using your Apple iOS Developer certificate
* You can then easily (re)install the patched app to your jailed device
* You can remotely attach to Cycript using `cycript -r hostname:31337`

Requirements
============
* iOS device
* Apple Developer account
* Xcode with iPhone SDK
* Patience and luck

Quick How-to
============
1. [Install and configure Theos](https://github.com/theos/theos/wiki/Installation)
* Extract and decrypt your target app. Save as a .ipa
* Clone this project to your computer (recommended), or download it as a ZIP
* Install the module and template by runnning `./install`
* Install [**optool**](https://github.com/alexzielenski/optool/releases/latest) and [**ios-deploy**](https://github.com/phonegap/ios-deploy#installation) to any directory in your PATH
* Change to the base directory for your new tweak (eg. `cd ~/Desktop`)
* Run `nic.pl` and choose the **jailed** template
* Enter a name for your tweak
* Enter an absolute or relative path to your decrypted .ipa file (it will be copied into the project directory)
* Once done, change into your new tweak directory (eg. `cd ~/Desktop/mytweak`)
* Run `./patchapp.sh info`
* Take the information from that and create a matching Provisioning Profile
* Save the Provisioning Profile somewhere on your computer, or add it to Xcode
* Edit Tweak.xm as necessary
* Run `make`
* Run `./patchapp.sh <command> <profile>`.
* Replace `<command>` with one of the following:
 * `install`: Inject the tweak into the .ipa and install it on your USB-connected device
 * `debug`: Like `install`, but also debug the app with LLDB
 * `patch`: Just inject the tweak into the .ipa (doesn't require `ios-deploy`)
* Replace `<profile>` with one of the following:
 * A path to a .mobileprovision file
 * A bundle ID for which you have a provisioning profile in Xcode
 * The `-w` flag to use Xcode's Wildcard App ID
