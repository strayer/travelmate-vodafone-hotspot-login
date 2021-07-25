# Vodafone Hotspot Captive Portal Auto-login

This a is a script used to automatically login into Vodafone Hotspot captive portals. It is intended to be used with [Travelmate](https://forum.openwrt.org/t/travelmate-support-thread/5155) in OpenWRT routers.

## Requirements

Due to lazyness this script requires `jq` which can be installed with `opkg install jq` in OpenWRT. Apart from that it assumes `curl` and travelmate are installed.

The script was tested on OpenWRT 21.02.0-rc3 with Travelmate 2.0.3-2.

## Usage

Put the [vodafone-hotspot.login](vodafone-hotspot.login) file into `/etc/travelmate/` and activate it as a Auto Login Script in the Travelmate Settings of the "Vodafone Hotspot" Wireless Station in Travelmate.

## Caveats

At least in case of the Vodafone Hotspot this script was developed for, there was an automatic Wifi disconnect every 30 minutes by deauth from the hotspot AP. I resorted to only having the 2.4 Ghz radio as an AP and used the 5 Ghz radio only for connecting to the hotspot, otherwise clients would frequently be kicked out of the Wifi because it had to scan for the Hotspot again, disabling the AP master until it reconnected.
