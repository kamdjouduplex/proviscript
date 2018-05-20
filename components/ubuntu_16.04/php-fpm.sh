#!/usr/bin/env bash
#
# php-fpm.sh
#

# PHP
# only allow 5.6, 7.0, 7,1, 7.2
package_version="7.2"

case  ${package_version} in
    "5.6") ;;           
    "7.0") ;;
    "7.1") ;;
    "7.2") ;;
    *)
        echo "Invalid PHP version: ${package_version} is not supported."
        echo "Try \"5.6, 7.0, 7.1 or 7.2\" (recommended version: 7.2)."
        exit 1
        ;;
esac

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="PHP-FPM"

if [ "$(type -t func_component_welcome)" == function ]; then 
    func_component_welcome "php-fpm" "${package_version}"
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version}                                                     ";
echo "----------------------------------------------------------------------------------";
echo

# Check if Nginx has been installed or not.
is_phpfpm_installed=$(dpkg-query -W --showformat='${Status}\n' php${package_version}-fpm | grep "install ok installed")

if [ "${is_phpfpm_installed}" == "install ok installed" ]; then
    echo "php${package_version}-fpm is already installed, please remove it before executing this script."
    echo "Try \"sudo apt-get purge php${package_version}-fpm\""
    exit 2
fi

# Check if software-properties-common installed or not.
is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

# Check if add-apt-repository command is available to use or not.
if [ "${is_add_apt_repository}" == "" ]; then
    sudo apt-get install -y software-properties-common
fi

# Add repository for PHP.
sudo add-apt-repository --yes ppa:ondrej/php

# Update repository for PHP.
sudo apt-get update

# Comment out the package you don't want.
# Default: install them all.
sudo apt-get install -y php-pear
sudo apt-get install -y php${package_version}-bcmath
sudo apt-get install -y php${package_version}-bz2
sudo apt-get install -y php${package_version}-cgi
sudo apt-get install -y php${package_version}-cli
sudo apt-get install -y php${package_version}-common
sudo apt-get install -y php${package_version}-curl
sudo apt-get install -y php${package_version}-dba
sudo apt-get install -y php${package_version}-dev
sudo apt-get install -y php${package_version}-enchant
sudo apt-get install -y php${package_version}-fpm
sudo apt-get install -y php${package_version}-gd
sudo apt-get install -y php${package_version}-gmp
sudo apt-get install -y php${package_version}-imap
sudo apt-get install -y php${package_version}-interbase
sudo apt-get install -y php${package_version}-intl
sudo apt-get install -y php${package_version}-json
sudo apt-get install -y php${package_version}-ldap
sudo apt-get install -y php${package_version}-mbstring
sudo apt-get install -y php${package_version}-mysql
sudo apt-get install -y php${package_version}-odbc
sudo apt-get install -y php${package_version}-opcache
sudo apt-get install -y php${package_version}-pgsql
sudo apt-get install -y php${package_version}-phpdbg
sudo apt-get install -y php${package_version}-pspell
sudo apt-get install -y php${package_version}-readline
sudo apt-get install -y php${package_version}-recode
sudo apt-get install -y php${package_version}-snmp
sudo apt-get install -y php${package_version}-soap
sudo apt-get install -y php${package_version}-sqlite3
sudo apt-get install -y php${package_version}-sybase
sudo apt-get install -y php${package_version}-tidy
sudo apt-get install -y php${package_version}-xml
sudo apt-get install -y php${package_version}-xmlrpc
sudo apt-get install -y php${package_version}-xsl
sudo apt-get install -y php${package_version}-zip

# There are virtual packages
# php-redis
sudo apt-get install -y php${package_version}-redis 

# To Enable php-fpm in boot.
sudo systemctl enable php${package_version}-fpm

# To restart php-fpm service.
sudo service php${package_version}-fpm restart
