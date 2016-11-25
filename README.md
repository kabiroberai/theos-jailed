Theos and Cycript for non-jailbroken iOS devices
================================================
This is a module for Theos designed to work with apps on non-jailbroken iOS devices. For the original (iOS 8/9) theos-jailed, see https://github.com/BishopFox/theos-jailed.

* You use it just as you would for a regular tweak (edit Tweak.xm and then `make package install`)
* It patches App Store apps (.ipa files) to load your tweak, Cycript, etc
* It re-signs the patched app using your Apple iOS Developer certificate
* You can then easily (re)install the patched app to your jailed device
* You can remotely attach to Cycript using `cycript -r hostname:31337`

Requirements
============
* iOS device
* Apple Developer account
* Xcode with iPhone SDK
* [**optool**](https://github.com/alexzielenski/optool/releases/latest) and [**ios-deploy**](https://github.com/phonegap/ios-deploy#installation)
* Patience and luck

Usage
=====
1. [Install and configure Theos](https://github.com/theos/theos/wiki/Installation)
* Extract and decrypt your target app. Save as a .ipa
* Clone this project to your computer (use `git clone --recursive` because the repository has submodules)
* Install the module and template by runnning `./install`
* Install [**optool**](https://github.com/alexzielenski/optool/releases/latest) and [**ios-deploy**](https://github.com/phonegap/ios-deploy#installation) in any directory in your PATH
* Change to the base directory for your new tweak (eg. `cd ~/Desktop`)
* Run `nic.pl` and choose the **jailed** template
* Enter a name for your tweak
* Enter an absolute or relative path to your decrypted .ipa file
* Change into your new tweak directory (eg. `cd ~/Desktop/mytweak`)
* Edit Tweak.xm as necessary
* Run `make info` and follow the instructions to create a Provisioning Profile
* Run `make package install`
    * Set the `PROFILE` makefile variable to a .mobileprovision file or bundle id if you don't want to use Xcode's Wildcard App ID
    * Set `USE_CYCRIPT=1` to be able to remotely attach to Cycript using `cycript -r hostname:31337`
    * Set `USE_FISHHOOK=1` to use [fishhook](https://github.com/facebook/fishhook) (remember to `#import <fishhook.h>` as well)
