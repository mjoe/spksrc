<<<<<<< HEAD
SPK_NAME = pyLoad
SPK_VERS = 0.4.9
SPK_REV = 1
SPK_ICON = src/pyLoad.png

DEPENDS  = cross/js
ifdef ARCH
ifeq ($(filter $(ARCH),powerpc ppc824x),$(ARCH))
$(warning Architecture '$(ARCH)' uses gcc 3.3.4, which contains a bug in the STL which prevent tesseract to be built.)
else
DEPENDS += cross/tesseract
endif
endif # ifdef ARCH
DEPENDS += cross/pyload
DEPENDS += cross/busybox

MAINTAINER = SynoCommunity
COMMENT    = A fast, lightweight and full featured download manager for many One-Click-Hoster, container formats like DLC, video sites or just plain http/ftp links
ADMIN_PORT = 5555
RELOAD_UI = yes
DISPLAY_NAME = pyLoad

HOMEPAGE   = http://pyload.org/
LICENSE    = GPL

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
ADDITIONAL_SCRIPTS = 

PYTHON_VERS = 26

SPK_DEPENDS = "Python${PYTHON_VERS}>=2.6.6-5"

INSTALL_PREFIX = /usr/local/${SPK_NAME}

POST_STRIP_TARGET = xz-compress

include ../../mk/spksrc.spk.mk


.PHONY: xz-compress
xz-compress:
	#@$(MSG) "Patching SABnzbd files"
	#sed -i.orig $(STAGING_DIR)/share/SABnzbd/SABnzbd.py \
	#     -e 's#\(/usr\)\(/bin/python\)#\1/local/python${PYTHON_VERS}\2#'
	#sed -i.orig $(STAGING_DIR)/share/SABnzbd/SABHelper.py \
	#     -e 's#\(/usr\)\(/bin/python\)#\1/local/python${PYTHON_VERS}\2#'
	#sed -i.orig $(STAGING_DIR)/share/SABnzbd/sabnzbd/constants.py \
	#     -e "s#\(DEF_DOWNLOAD_DIR = '\)Downloads\(/incomplete'\)#\1/volume1/downloads\2#" \
	#     -e "s#\(DEF_COMPLETE_DIR = '\)Downloads\(/complete'\)#\1/volume1/downloads\2#"
	@$(MSG) "Adding files for DSM integration"
	install -m 755 -d $(STAGING_DIR)/share/synoman
	#install -m 644 src/config.json $(STAGING_DIR)/share/synoman/config
	#install -m 755 src/sabnzbd.cgi.py $(STAGING_DIR)/share/synoman/sabnzbd.cgi
	#for size in 16 24 32 48 ; \
	#do \
	#    convert $(SPK_ICON) -thumbnail $${size}x$${size} -transparent white \
	#            $(STAGING_DIR)/share/synoman/sab2-$${size}.png ; \
	#done
	@$(MSG) "Compressing with xz"
	(cd $(STAGING_DIR) && tar cpJf $(WORK_DIR)/package.txz *)
	rm -fr $(STAGING_DIR)
	mkdir $(STAGING_DIR)
	mv $(WORK_DIR)/package.txz $(STAGING_DIR)/
	install -m 755 -d $(STAGING_DIR)/var
	#install -m 644 src/config.ini $(STAGING_DIR)/var/ 
=======
SPK_NAME = pyload
SPK_VERS = 0.4.9
SPK_REV = 2
SPK_ICON = src/pyload.png
DSM_UI_DIR = app

BETA = 1

DEPENDS = cross/tesseract-ocr cross/tessdata-eng cross/js cross/$(SPK_NAME)
SPK_DEPENDS = "python>2.7.3-3"

MAINTAINER = SynoCommunity
DESCRIPTION = pyLoad is a fast, lightweight and full featured download manager for many One-Click-Hoster, container formats like DLC, video sites or just plain http/ftp links.
ADMIN_PORT = 8190
RELOAD_UI = yes
STARTABLE = yes
DISPLAY_NAME = pyLoad
CHANGELOG = Fix updatemanager

HOMEPAGE   = http://pyload.org
LICENSE    = GPLv3

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = pyload_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: pyload_extra_install
pyload_extra_install:
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 644 src/pyload.conf $(STAGING_DIR)/etc/pyload.conf
	install -m 644 src/pyload_init.sql $(STAGING_DIR)/etc/pyload_init.sql
	install -m 644 src/htaccess.example $(STAGING_DIR)/etc/htaccess.example
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 64 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done
>>>>>>> SynoCommunity/master
