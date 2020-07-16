#!/usr/bin/env bash

# Finally, install the theme

# Configurables
PLYMOUTH_DIR=/usr/share/plymouth/themes
PLYMOUTH_THEME=minimal-dark-bgrt

install -d ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}
install -m644 ./minimal-dark-bgrt.{plymouth,script} ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/
# install -m644 theme/bgrt.{plymouth,script} ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/
install -m644 ./*.png ${PLYMOUTH_DIR}/${PLYMOUTH_THEME}/

echo "Install complete."
echo "To use this theme, run as root:"
echo "	plymouth-set-default-theme -R ${PLYMOUTH_THEME}"
