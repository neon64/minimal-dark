#!/bin/bash

# Configurables
PLYMOUTH_DIR=/usr/share/plymouth/themes
PLYMOUTH_THEME=minimal-dark

# Sanity Checks
if [[ ! -r /sys/firmware/acpi/bgrt/image ]]; then
	echo "Sorry, I can't read /sys/firmware/acpi/bgrt/image"
	echo "Your system is not suitable for this theme"
	exit 1
fi

command -v convert >/dev/null 2>&1 || { echo >&2 "I require convert (from imagemagick) but it's not installed.  Aborting."; exit 1; }
command -v install >/dev/null 2>&1 || { echo >&2 "I require install (from coreutils) but it's not installed.  Aborting."; exit 1; }
command -v awk >/dev/null 2>&1 || { echo >&2 "I require awk but it's not installed.  Aborting."; exit 1; }

# OK. Convert the image to PNG
convert /sys/firmware/acpi/bgrt/image ./bgrt.png

# Replace the placeholders with the image offsets
< minimal-dark.script.in awk \
	-v BGRTLEFT=$(</sys/firmware/acpi/bgrt/xoffset) \
	-v BGRTTOP=$(</sys/firmware/acpi/bgrt/yoffset) \
	'{gsub (/\$BGRTLEFT\$/, BGRTLEFT);
	  gsub (/\$BGRTTOP\$/, BGRTTOP);
	  print}' > ./minimal-dark.script
