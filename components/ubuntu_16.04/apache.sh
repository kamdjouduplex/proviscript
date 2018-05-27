#!/usr/bin/env bash
#>                   +------------+
#>                   |  apache.sh  |   
#>                   +------------+
#-
#- SYNOPSIS
#-
#-    apache.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Apache you want to install?
#-                         Accept vaule: latest, default
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./apache.sh -v default
#-    $ ./apache.sh --version=latest
#-    $ ./apache.sh
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
#+    2018/05/27 terrylinooo First commit.
#+
#================================================================

#================================================================
# Part 1. Config
#================================================================

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="Apache"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_APT="apt-get"

# Default, you can overwrite this setting by assigning -v or --version option.
package_version="latest"

#================================================================
# Part 2. Option (DO NOT MODIFY)
#================================================================

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

# Receive arguments in slient mode.
if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
            # Which version of MariaDB you want to install?
            "-v") 
                package_version="${2}"
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
                shift 1
            ;;
            # apt-get
            "--apt-get")
                _APT="apt-get"
                shift 1
            ;;
            "-"*)
                echo "Unknown option: ${1}"
                exit 1
            ;;
            *)
                echo "Unknown option: ${1}"
                exit 1
            ;;
        esac
    done
fi

#================================================================
# Part 3. Message (DO NOT MODIFY)
#================================================================

if [ "$(type -t INIT_PROVISCRIPT)" == function ]; then 
    func_component_welcome "apache" "${package_version}"
else
    # Bash color set
    COLOR_EOF="\e[0m"
    COLOR_BLUE="\e[34m"
    COLOR_RED="\e[91m"
    COLOR_GREEN="\e[92m"
    COLOR_WHITE="\e[97m"
    COLOR_DARK="\e[90m"
    COLOR_BG_BLUE="\e[44m"
    COLOR_BG_GREEN="\e[42m"
    COLOR_BG_DARK="\e[100m"

    func_proviscript_msg() {
        case "$1" in
            "info")
                echo -e "[${COLOR_BLUE}O.o${COLOR_EOF}] ${COLOR_BLUE}${2}${COLOR_EOF}"
            ;;
            "warning")
                echo -e "[${COLOR_RED}O.o${COLOR_EOF}] ${COLOR_RED}${2}${COLOR_EOF}"
            ;;
            "success")
                echo -e "[${COLOR_GREEN}O.o${COLOR_EOF}] ${COLOR_GREEN}${2}${COLOR_EOF}"
            ;;
        esac
    }

    echo -e ${COLOR_WHITE}
    echo -e "      _                             _              "
    echo -e "     / \     _ __     __ _    ___  | |__     ___   "
    echo -e "    / _ \   | '_ \   / _  |  / __| | '_ \   / _ \  "
    echo -e "   / ___ \  | |_) | | (_| | | (__  | | | | |  __/  "
    echo -e "  /_/   \_\ | .__/   \__,_|  \___| |_| |_|  \___|  "
    echo -e "            |_|                                    "
    echo -e ${COLOR_EOF}
    echo -e " Automatic installation by ${COLOR_GREEN}Provi${COLOR_BLUE}script";
    echo -e " ${COLOR_BG_GREEN}  ${COLOR_BG_BLUE}  ${COLOR_BG_DARK}${COLOR_WHITE} https://github.com/Proviscript/ ${COLOR_EOF}"
    echo -e ${COLOR_EOF}
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version}                                                     ";
echo "----------------------------------------------------------------------------------";
echo

#================================================================
# Part 4. Core
#================================================================

if [ "${_APT}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        func_proviscript_msg info "Package manager \"aptitude\" is not installed, installing..."
        sudo apt-get install aptitude
    fi
fi

# Check if Apache has been installed or not.
func_proviscript_msg info "Checking if apache is installed, if not, proceed to install it."

is_apache_installed=$(dpkg-query -W --showformat='${Status}\n' apache | grep "install ok installed")

if [ "${is_apache_installed}" == "install ok installed" ]; then
    func_proviscript_msg warning "${package_name} is already installed, please remove it before executing this script."
    func_proviscript_msg info "Try \"sudo ${_APT} purge apache2\""
    exit 2
fi

if [ "${package_version}" == "latest" ]; then

    # Check if software-properties-common installed or not.
    is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

    # Check if add-apt-repository command is available to use or not.
    if [ "${is_add_apt_repository}" == "" ]; then
        func_proviscript_msg warning "Command \"add_apt_repository\" is not supprted, install \"software-properties-common\" to use it."
        func_proviscript_msg info "Proceeding to install \"software-properties-common\"."
        sudo ${_APT} install -y software-properties-common
    fi

    # Add repository for Apache.
    sudo add-apt-repository --yes ppa:ondrej/apache2

    # Update repository for Apache. 
    sudo ${_APT} update
fi

# Install Apache
func_proviscript_msg info "Proceeding to install apache server."
sudo ${_APT} install -y apache2

# To Enable Apache server in boot.
func_proviscript_msg notice "Enable service apache in boot."
sudo systemctl enable apache2

func_proviscript_msg info "Restart service apache."
sudo service apache2 restart

apache_version="$(apache2 -v 2>&1)"

if [[ "${apache_version}" = *"Apache"* ]]; then
    func_proviscript_msg success "Installation process is completed."
    func_proviscript_msg success "$(apache2 -v 2>&1)"
else
    func_proviscript_msg warning "Installation process is failed."
fi