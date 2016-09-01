PKG_NAME = pyload
PKG_VERS = 0.4.9
PKG_EXT = zip
PKG_DIST_NAME = $(PKG_NAME)-src-v$(PKG_VERS).$(PKG_EXT)
<<<<<<< HEAD
PKG_DIST_SITE = http://get.pyload.org/get/src
PKG_DIR = $(PKG_NAME)

DEPENDS = 

HOMEPAGE   = http://pyload.org/
COMMENT    = Fast, lightweight and full featured download manager for many One-Click-Hoster
LICENSE    = GPL
=======
PKG_DIST_SITE = https://github.com/pyload/pyload/releases/download/v$(PKG_VERS)
PKG_DIR = pyload

DEPENDS =

HOMEPAGE = http://pyload.org
COMMENT  = pyLoad is a fast, lightweight and full featured download manager for many One-Click-Hoster, container formats like DLC, video sites or just plain http/ftp links.
LICENSE  = GPLv3

>>>>>>> SynoCommunity/master

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = myInstall

include ../../mk/spksrc.cross-cc.mk

<<<<<<< HEAD
myInstall:
	mkdir -p $(STAGING_INSTALL_PREFIX)/share/pyLoad
	tar -cf - -C $(WORK_DIR)/$(PKG_DIR) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/share/pyLoad
=======
.PHONY: myInstall
myInstall:
	mkdir -p $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
	tar -cf - -C $(WORK_DIR)/$(PKG_DIR) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
>>>>>>> SynoCommunity/master
