#!/usr/bin/env bash
#>                   +------------+
#>                   |  nginx.sh  |   
#>                   +------------+
#-
#- SYNOPSIS
#-
#-    nginx.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Nginx you want to install?
#-                         Accept vaule: stable, mainline
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-
#- EXAMPLES
#-
#-    $ ./nginx.sh -v stable
#-    $ ./nginx.sh --version=mainline
#-    $ ./nginx.sh
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
#+    2018/05/20 terrylinooo Add arguments, see nginx.sh -h
#+
#================================================================

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="Nginx"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_APT="apt-get"

# Default, you can overwrite this setting by assigning -v or --version option.
package_version="stable"

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
    echo "---[proviscript]------------------------------------------------------------------";
    echo " $1"
    echo "----------------------------------------------------------------------------------";
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
                package_version="${1#*=}"; 
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
            # aptitude
            "--aptitude")
                _APT="aptitude"
            ;;
            # apt-get
            "--apt-get")
                _APT="apt-get"
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

if [ "$(type -t func_component_welcome)" == function ]; then 
    func_component_welcome "nginx" "${package_version}"
else
    echo "  _   _           _                       ";
    echo " | \ | |   __ _  (_)  _ __   __  __       ";
    echo " |  \| |  / _\` | | | | '_ \  \ \/ /      ";
    echo " | |\  | | (_| | | | | | | |  >  <        ";
    echo " |_| \_|  \__, | |_| |_| |_| /_/\_\       ";
    echo "          |___/                           ";
    echo "                                          ";
    echo " Automatic installation by Proviscript.   ";
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version} (latest)                                            ";
echo "----------------------------------------------------------------------------------";
echo

if [ "${_APT}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        sudo apt-get install aptitude
    fi
fi

# Check if Nginx has been installed or not.
echo "Checking if nginx is installed, if not proceed to install it."

is_nginx_installed=$(dpkg-query -W --showformat='${Status}\n' nginx | grep "install ok installed")

if [ "${is_nginx_installed}" == "install ok installed" ]; then
    echo "${package_name} is already installed, please remove it before executing this script."
    echo "Try \"sudo ${_APT} purge nginx\""
    exit 2
fi

# Check if software-properties-common installed or not.
is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

# Check if add-apt-repository command is available to use or not.
if [ "${is_add_apt_repository}" == "" ]; then
    sudo ${_APT} install -y software-properties-common
fi

# Add repository for Nginx.
sudo add-apt-repository --yes ppa:nginx/${package_version}

# Update repository for Nginx. 
sudo ${_APT} update

# Install Nginx
show_notice "Proceeding to install nginx."
sudo ${_APT} install -y nginx

# To Enable Nginx server in boot.
show_notice "Proceeding to enable service nginx in boot."
sudo systemctl enable nginx

show_notice "Restart service nginx."
sudo service nginx restart