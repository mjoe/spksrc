#!/bin/sh

<<<<<<< HEAD
#########################################
# A few variables to make things readable

# Package specific variables
PACKAGE="pyLoad"
DNAME="pyLoad"
PYTHON_DIR="/usr/local/python26"

# Common variables
INSTALL_DIR="/usr/local/${PACKAGE}"
VAR_DIR="/usr/local/var/${PACKAGE}"
UPGRADE="/tmp/${PACKAGE}.upgrade"
PATH="${INSTALL_DIR}/bin:${PYTHON_DIR}/bin:/bin:/usr/bin:/usr/syno/bin" # Avoid ipkg commands

SYNO3APP="/usr/syno/synoman/webman/3rdparty"

# Quote the wizard variables
echo $pyLoadUser > $$
pyLoadUser=`sed 's/"/\\"/gp' $$`
echo $pyLoadPasswd > $$
pyLoadPasswd=`sed 's/"/\\"/gp' $$`
echo $pyLoadPasswd2 > $$
pyLoadPasswd2=`sed 's/"/\\"/gp' $$`
/bin/rm -f $$

#########################################
# DSM package manager functions

preinst ()
{
    checkPassword ||exit 1
=======
# Package
PACKAGE="pyload"
DNAME="pyLoad"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
PYTHON_DIR="/usr/local/python"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/env/bin:${PYTHON_DIR}/bin:${PATH}"
USER="pyload"
GROUP="users"
VIRTUALENV="${PYTHON_DIR}/bin/virtualenv"
CFG_FILE="${INSTALL_DIR}/etc/pyload.conf"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"

SYNO_GROUP="sc-download"
SYNO_GROUP_DESC="SynoCommunity's download related group"

lng2iso()
{
	# changes 3-character Synology language code to ISO 639-1 code.
        case $1 in
            eng|deu|fre|ita|nld|sve|rus|plk|csy)
                echo "${1%?}"
                ;;
            spn)
                echo "es"
                ;;
            *)
		echo "en"
		;;
        esac
}

syno_group_create ()
{
    # Create syno group (Does nothing when group already exists)
    synogroup --add ${SYNO_GROUP} ${USER} > /dev/null
    # Set description of the syno group
    synogroup --descset ${SYNO_GROUP} "${SYNO_GROUP_DESC}"

    # Add user to syno group (Does nothing when user already in the group)
    addgroup ${USER} ${SYNO_GROUP}
}

syno_group_remove ()
{
    # Remove user from syno group
    delgroup ${USER} ${SYNO_GROUP}

    # Check if syno group is empty
    if ! synogroup --get ${SYNO_GROUP} | grep -q "0:"; then
        # Remove syno group
        synogroup --del ${SYNO_GROUP} > /dev/null
    fi
}


preinst ()
{
    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Check directory
        if [ ! -d ${wizard_download_dir:=/volume1/downloads} ]; then
            echo "Download directory ${wizard_download_dir:=/volume1/downloads} does not exist."
            exit 1
        fi
    fi
>>>>>>> SynoCommunity/master
    exit 0
}

postinst ()
{
<<<<<<< HEAD
    # Installation directories
    mkdir -p ${INSTALL_DIR}
    mkdir -p ${VAR_DIR}
    mkdir -p /usr/local/bin


    # Extract the files to the installation directory
    ${PYTHON_DIR}/bin/xzdec -c ${SYNOPKG_PKGDEST}/package.txz | \
        tar xpf - -C ${INSTALL_DIR}
    # Remove the installer archive to save space
    rm ${SYNOPKG_PKGDEST}/package.txz

    ln -s /var/packages/${PACKAGE}/scripts/start-stop-status /usr/local/bin/${PACKAGE}-ctl

    # Install the application in the main interface.
    if [ -d ${SYNO3APP} ]
    then
        rm -f ${SYNO3APP}/${PACKAGE}
        ln -s ${INSTALL_DIR}/share/synoman ${SYNO3APP}/${PACKAGE}
    fi
    # Create the configuration file
    if [ -f ${VAR_DIR}/pyload.conf ]
    then
        true # Keep current settings
    else
        # Create the default config
        PATH=$PATH:${INSTALL_DIR}/bin ${INSTALL_DIR}/share/pyLoad/pyLoadCore.py \
            --configdir=${VAR_DIR} --autosetup "${pyLoadUser}" "${pyLoadPasswd}" >${VAR_DIR}/install.log
        echo "You can now log in pyLoad with previously entered username and password." >> ${SYNOPKG_TEMP_LOGFILE}
    fi

    # Create the service user if needed
    if grep "^${PACKAGE}:" /etc/passwd >/dev/null
    then
        true
    else
        adduser -h ${VAR_DIR} -g "${DNAME} User" -G users -D -H ${UID_PARAM} -s /bin/sh ${PACKAGE}
    fi

    # Correct the files ownership
    chown -Rh ${PACKAGE}:users ${INSTALL_DIR} ${VAR_DIR}
=======
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    # Create a Python virtualenv
    ${VIRTUALENV} --system-site-packages ${INSTALL_DIR}/env > /dev/null

    # Create user
    adduser -h ${INSTALL_DIR}/etc -g "${DNAME} User" -G ${GROUP} -s /bin/sh -S -D ${USER}

    # Set cfg location
    echo "${INSTALL_DIR}/etc" > "${INSTALL_DIR}/share/pyload/module/config/configdir"

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Set group and permissions on download dir for DSM5
        if [ `/bin/get_key_value /etc.defaults/VERSION buildnumber` -ge "4418" ]; then
            chgrp users "${wizard_download_dir:=/volume1/downloads}"
            chmod g+rwx "${wizard_download_dir:=/volume1/downloads}"
        fi

        # Edit the configuration according to the wizard
        sed -i -e "s|@W_DOWNLOAD_DIR@|${wizard_download_dir:=/volume1/downloads}|" \
               -e "s|@LNG@|$(lng2iso ${SYNOPKG_DSM_LANGUAGE})|" \
               "${CFG_FILE}"

        # hash password
        SALT=$((RANDOM%99999+10000))
        SALTED_PW_HASH=${SALT}$(echo -n "${SALT}${wizard_password}" | openssl dgst -sha1 2>/dev/null | cut -d" " -f2)

        # init DB & add 'admin' user
        echo -n "4" > "${INSTALL_DIR}/etc/files.version"
        sqlite3 "${INSTALL_DIR}/etc/files.db" < "${INSTALL_DIR}/etc/pyload_init.sql" || exit 1
        sqlite3 "${INSTALL_DIR}/etc/files.db" "INSERT INTO users (name, password) VALUES ('admin', '${SALTED_PW_HASH}')" || exit 1
    fi

    syno_group_create

    # Correct the files ownership
    chown -R ${USER}:root ${SYNOPKG_PKGDEST}

    # Add firewall config
    ${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null
>>>>>>> SynoCommunity/master

    exit 0
}

preuninst ()
{
<<<<<<< HEAD
    # Make sure the package is not running while we are removing it.
    /usr/local/bin/${PACKAGE}-ctl stop

    exit 0
}

postuninst ()
{
    # Keep the user data and settings during the upgrade
    if [ -f ${UPGRADE} ]
    then
        true 
    else
        deluser ${PACKAGE}
        rm -fr ${VAR_DIR}
    fi

    # Remove the application from the main interface if it was previously added.
    if [ -h ${SYNO3APP}/${PACKAGE} ]
    then
        rm ${SYNO3APP}/${PACKAGE}
    fi

    # Remove symlinks to utils
    rm /usr/local/bin/${PACKAGE}-ctl

    # Remove the installation directory
    rm -fr ${INSTALL_DIR}
    exit 0
}

preupgrade ()
{
    touch $isUpgrade
    exit 0
}

postupgrade ()
{
    rm -f $isUpgrade
=======
    # Stop the package
    ${SSS} stop > /dev/null

    # Remove the user (if not upgrading)
    if [ "${SYNOPKG_PKG_STATUS}" != "UPGRADE" ]; then
        syno_group_remove

        delgroup ${USER} ${GROUP}
        deluser ${USER}
    fi

    # Remove firewall config
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" ]; then
        ${SERVICETOOL} --remove-configure-file --package ${PACKAGE}.sc >> /dev/null
    fi

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}

    exit 0
}

preupgrade ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${INSTALL_DIR}/etc ${TMP_DIR}/${PACKAGE}/
>>>>>>> SynoCommunity/master

    exit 0
}

<<<<<<< HEAD
#########################################
# Local functions
checkPassword ()
{
  if [ "${pyLoadPasswd}" = "${pyLoadPasswd2}" ]
  then
      true
  else
        cat >> ${SYNOPKG_TEMP_LOGFILE} << EOM
The entered passwords don't match, please retry to install.
EOM
        return 1
  fi
 
  return 0
=======
postupgrade ()
{
    # Restore some stuff
    rm -fr ${INSTALL_DIR}/etc
    mv ${TMP_DIR}/${PACKAGE}/etc ${INSTALL_DIR}/
    rm -fr ${TMP_DIR}/${PACKAGE}

    exit 0
>>>>>>> SynoCommunity/master
}
