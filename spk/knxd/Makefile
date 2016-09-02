SPK_NAME = knxd
SPK_VERS = 0.10.1
SPK_REV = 1
SPK_ICON = src/knxd.png

DEPENDS = cross/busybox cross/pthsem cross/libusb cross/knxd

MAINTAINER   = mjoe
DESCRIPTION  = "A Communication Stack for EIB/KNX (Config: /var/packages/knxd/etc/knxd.cfg)"
RELOAD_UI    = no
DISPLAY_NAME = knxd
CHANGELOG    = "First release for SynoCommunity"
HELPURL      = https://github.com/knxd/knxd
HOMEPAGE     = https://github.com/knxd/knxd
LICENSE      = GPL

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = knxd_extra_install

BUSYBOX_CONFIG = usrmng
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: bcusdk_extra_install
knxd_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 644 src/knxd.cfg $(STAGING_DIR)/var/knxd.cfg
