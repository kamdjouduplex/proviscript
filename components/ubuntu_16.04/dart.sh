#!/usr/bin/env bash
#>                           +-----------+
#>                           |  dart.sh  |
#>                           +-----------+
#-
#- SYNOPSIS
#-
#-    dart.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Dart you want to install?
#-                         Accept vaule: latest (stable), dev (unstable). 
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./dart.sh -v latest
#-    $ ./dart.sh --version=latest
#-    $ ./dart.sh
#+
#+ IMPLEMENTATION:
#+
#+    package    Proviscript
#+    copyright  https://github.com/Proviscript/
#+    license    GNU General Public License
#+    authors    Terry Lin (terrylinooo)
#+ 
#==============================================================================

#==============================================================================
# Part 1. Config
#==============================================================================

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="Dart"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_PM="apt-get"

# Default, you can overwrite this setting by assigning -v or --version option.
package_version="latest"

#==============================================================================
# Part 2. Option (DO NOT MODIFY)
#==============================================================================

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
            # Which version of Redis you want to install?
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
                _PM="aptitude"
                shift 1
            ;;
            # apt-get
            "--apt-get")
                _PM="apt-get"
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

#==============================================================================
# Part 3. Message (DO NOT MODIFY)
#==============================================================================

if [ "$(type -t INIT_PROVISCRIPT)" == function ]; then
    package_version=${PACKAGE_VERSION}
    func::component_welcome "redis" "${package_version}"
else
    # Bash color set
    readonly COLOR_EOF="\e[0m"
    readonly COLOR_BLUE="\e[34m"
    readonly COLOR_RED="\e[91m"
    readonly COLOR_GREEN="\e[92m"
    readonly COLOR_WHITE="\e[97m"
    readonly COLOR_DARK="\e[90m"
    readonly COLOR_BG_BLUE="\e[44m"
    readonly COLOR_BG_GREEN="\e[42m"
    readonly COLOR_BG_DARK="\e[100m"

    func::proviscript_msg() {
        case "$1" in
            "info")
                echo -e "[${COLOR_BLUE}###${COLOR_EOF}] ${COLOR_BLUE}${2}${COLOR_EOF}"
            ;;
            "warning")
                echo -e "[${COLOR_RED}###${COLOR_EOF}] ${COLOR_RED}${2}${COLOR_EOF}"
            ;;
            "success")
                echo -e "[${COLOR_GREEN}###${COLOR_EOF}] ${COLOR_GREEN}${2}${COLOR_EOF}"
            ;;
        esac
    }

    spaces=$(printf "%-80s" "*")
    echo -e
    echo -e "${COLOR_BG_GREEN}${spaces}${COLOR_EOF}"
    echo -e ${COLOR_WHITE}
    echo -e "   ____                   _     ";
    echo -e "  |  _ \    __ _   _ __  | |_   ";
    echo -e "  | | | |  / _\` | | '__| | __| ";
    echo -e "  | |_| | | (_| | | |    | |_   ";
    echo -e "  |____/   \__,_| |_|     \__|  ";
    echo -e "                                ";
    echo -e ${COLOR_EOF}
    echo -e " ${COLOR_GREEN}Provi${COLOR_BLUE}script${COLOR_EOF} Project"
    echo -e
    echo -e " Web:    https://proviscript.sh/"
    echo -e " GitHub: https://github.com/Proviscript/"
    echo -e
    echo -e "${COLOR_BG_BLUE}${spaces}${COLOR_EOF}"
    echo -e ${COLOR_EOF}
fi

echo
echo " @os:      ${os_name} ${os_version} "
echo " @package: ${package_name}          "
echo " @version: ${package_version}       "
echo

#==============================================================================
# Part 4. Core
#==============================================================================

sudo ${_PM} update

if [ "${_PM}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        func::proviscript_msg info "Package manager \"aptitude\" is not installed, installing..."
        sudo apt-get install aptitude
    fi
fi

# Check if Redis has been installed or not.
func::proviscript_msg info "Checking if Dart is installed, if not, proceed to install it."

is_dart_installed=$(dpkg-query -W --showformat='${Status}\n' dart | grep "install ok installed")

if [ "${is_dart_installed}" == "install ok installed" ]; then
    func::proviscript_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::proviscript_msg info "Try \"sudo ${_PM} purge dart\""
    exit 2
fi

if [ "${package_version}" == "latest" ]; then
    # Check if apt-transport-https installed or not.
    is_apt_transport_https=$(which apt-transport-https |  grep "apt-transport-https")

    # Check if is_apt_transport_https command is available to use or not.
    if [ "${is_apt_transport_https}" == "" ]; then
        func::proviscript_msg warning "Command \"is_apt_transport_https\" is not supprted, install \"is_apt_transport_https\" to use it."
        func::proviscript_msg info "Proceeding to install \"is_apt_transport_https\"."
        sudo ${_PM} install -y is_apt_transport_https
    fi

    # Add repository for Dart.
    sudo sh -c "curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -"
    sudo sh -c "curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list"

    # Update repository for Dart. 
    sudo ${_PM} update
fi

# Install Dart.
func::proviscript_msg info "Proceeding to install Dart SDK."
sudo ${_PM} install -y dart

dart_version="$(dart) -v 2>&1)"

if [[ "${dart_version}" = *"dart"* && "${dart_version}" != *"command not found"* ]]; then
    func::proviscript_msg success "Installation process is completed."
    func::proviscript_msg success "$(dart -v 2>&1)"
else
    func::proviscript_msg warning "Installation process is failed."
fi
