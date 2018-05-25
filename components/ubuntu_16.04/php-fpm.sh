#!/usr/bin/env bash
#>                   +--------------+
#>                   |  php-fpm.sh  |   
#>                   +--------------+
#-
#- SYNOPSIS
#-
#-    php-fpm.sh [-h] [-i] [-l] [-v [version]] [-m [modules]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of PHP-FPM you want to install?
#-                         Accept vaule: 5.6, 7.0, 7,1, 7.2
#-    -m ?, --modules=?    Which modules of PHP-FPM you want to install?
#-                         Accept vaule: A comma-separated list of module names.
#-                         See "./php-fpm.sh --module-list"
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    -l, --module-list    Print module list of PHP-FPM.
#-
#- EXAMPLES
#-
#-    $ ./php-fpm.sh -v 7.2
#-    $ ./php-fpm.sh --version=7.2
#-    $ ./php-fpm.sh
#+
#+ IMPLEMENTATION:
#+
#+    version    1.01
#+    copyright  https://github.com/Proviscript/
#+    license    GNU General Public License
#+    authors    Terry Lin (terrylinooo)
#+ 
#+ CHANGELOGS:
#+
#+    2018/05/19 terrylinooo First commit.
#+    2018/05/22 terrylinooo Add arguments, see php-fpm.sh -h
#+
#================================================================

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="PHP-FPM"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_APT="apt-get"

# Only allow 5.6, 7.0, 7,1, 7.2
package_version="7.2"

php_modules=(
    'bcmath'  'bz2'       'cgi'        'cli'       'common' 
    'curl'    'dba'       'dev'        'enchant'   'gd'       
    'gmp'     'imap'      'interbase'  'intl'      'json'
    'ldap'    'mbstring'  'mysql'      'odbc'      'opcache'  
    'pgsql'   'phpdbg'    'pspell'     'readline'  'recode'   
    'redis'   'snmp'      'soap'       'sqlite3'   'sybase' 
    'tidy'    'xml'       'xmlrpc'     'xsl'       'zip' 
)

# Default
install_modules="ALL"

# Print script help
show_script_help() {
    echo 
    head -50 ${0} | grep -e "^#[-|>]" | sed -e "s/^#[-|>]*/ /g"
    echo 
}

# Print script info
show_script_information() {
    echo 
    head -50 ${0} | grep -e "^#[+|>]" | sed -e "s/^#[+|>]*/ /g"
    echo 
}

# Print notice text
show_notice() {
    echo
    echo "---[proviscript]------------------------------------------------------------------";
    echo " $1"
    echo "----------------------------------------------------------------------------------";
    echo
}

# Receive arguments in slient mode.
if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
            # Which version of MariaDB you want to install?
            "-v") 
                package_version="$2"
                shift 2
            ;;
            "--version="*) 
                package_version="${1#*=}"
                shift 1
            ;;
            "-m") 
                install_modules="$2"
                shift 2
            ;;
            "--modules="*) 
                install_modules="${1#*=}"
                shift 1
            ;;
            # Help
            "-h"|"--help")
                show_script_help
                exit 1
            ;;
            # Info
            "-i"|"--information")
                show_script_information
                exit 1
            ;;
            # Info
            "-l"|"--module-list")
                for module_name in ${php_modules[@]}; do
                    echo ${module_name}
                done
                echo "ALL (default)"
                exit 1
            ;;
            # aptitude
            "--aptitude")
                _APT="aptitude"
                shift 1
            ;;
            # apt-get
            "--apt-get")
                _APT="apt-get"
                shift 1
            ;;
            "-"*)
                echo "Unknown option: $1"
                exit 1
            ;;
            *)
                echo "Unknown option: $1"
                exit 1
            ;;
        esac
    done
fi

case  ${package_version} in
    "5.6") ;;           
    "7.0") ;;
    "7.1") ;;
    "7.2") ;;
    "*")
        echo "Invalid PHP version: ${package_version} is not supported."
        echo "Try \"5.6, 7.0, 7.1 or 7.2\" (recommended version: 7.2)."
        exit 1
        ;;
esac

if [ "$(type -t func_component_welcome)" == function ]; then 
    func_component_welcome "php-fpm" "${package_version}"
else
    echo "  ____    _   _   ____            _____   ____    __  __  ";
    echo " |  _ \  | | | | |  _ \          |  ___| |  _ \  |  \/  | ";
    echo " | |_) | | |_| | | |_) |  _____  | |_    | |_) | | |\/| | ";
    echo " |  __/  |  _  | |  __/  |_____| |  _|   |  __/  | |  | | ";
    echo " |_|     |_| |_| |_|             |_|     |_|     |_|  |_| ";
    echo "                                                          ";
    echo "         Automatic installation by Proviscript.           ";
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version}                                                     ";
echo "----------------------------------------------------------------------------------";
echo

if [ "${_APT}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        show_notice "Package manager \"aptitude\" is not installed, installing..."
        sudo apt-get install aptitude
    fi
fi

# Check if PHP-FPM has been installed or not.
echo "Checking if php${package_version}-fpm is installed, if not proceed to install it."

is_phpfpm_installed=$(dpkg-query -W --showformat='${Status}\n' php${package_version}-fpm | grep "install ok installed")

if [ "${is_phpfpm_installed}" == "install ok installed" ]; then
    echo "php${package_version}-fpm is already installed, please remove it before executing this script."
    echo "Try \"sudo ${_APT} purge php${package_version}-fpm\""
    exit 2
fi

# Check if software-properties-common installed or not.
is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

# Check if add-apt-repository command is available to use or not.
if [ "${is_add_apt_repository}" == "" ]; then
    sudo ${_APT} install -y software-properties-common
fi

# Add repository for PHP.
sudo add-apt-repository --yes ppa:ondrej/php

# Update repository for PHP.
sudo ${_APT} update

# Comment out the package you don't want.
# Default: install them "ALL"
show_notice "Proceeding to install php${package_version}-fpm ..."
sudo ${_APT} install -y php${package_version}-fpm
sudo ${_APT} install -y php-pear

# Install PHP modules
if [ "${install_modules}" == "ALL" ]; then
    for module in ${php_modules[@]}; do
        show_notice "Proceeding to install PHP module ${module} ..."
        sudo ${_APT} install -y php${package_version}-${module}
    done
else
    # Only install the modules what you want
    OLD_IFS=${IFS}
    IFS=',' read -r -a array_install_modules <<< "$install_modules"
    IFS=${OLD_IFS}

    for module in ${array_install_modules[@]}; do
        if [[ "${php_modules[@]}" =~ "${module}" ]]; then
            show_notice "Proceeding to install PHP module ${module} ..."
            sudo ${_APT} install -y php${package_version}-${module}
        fi
    done
fi

# To Enable php-fpm in boot.
show_notice "Proceeding to enable service php${package_version}-fpm in boot."
sudo systemctl enable php${package_version}-fpm

# To restart php-fpm service.
show_notice "Restart service php${package_version}-fpm."
sudo service php${package_version}-fpm restart