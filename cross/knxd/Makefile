PKG_NAME = knxd
PKG_VERS = 0.10.1
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/knxd/knxd/archive
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/pthsem cross/libusb

HOMEPAGE = https://github.com/knxd/knxd
COMMENT  = A free development environment for BCU1 and BCU2
LICENSE  = GNU GPL

PRE_CONFIGURE_TARGET = myBootstrap
INSTALL_TARGET = myInstall

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --enable-shared=no --with-pth=$(STAGING_INSTALL_PREFIX) --without-pth-test --enable-eibnetip --enable-eibnetiptunnel --enable-eibnetipserver --enable-usb

include ../../mk/spksrc.cross-cc.mk

.PHONY: myBootstrap
myBootstrap:
	$(RUN) ./bootstrap.sh

.PHONY: myInstall
myInstall:
	$(RUN) make install DESTDIR=$(INSTALL_DIR)
