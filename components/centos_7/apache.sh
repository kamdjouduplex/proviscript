#!/usr/bin/env bash
#>                           +-------------+
#>                           |  apache.sh  |
#>                           +-------------+
#-
#- SYNOPSIS
#-
#-    apache.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Apache you want to install?
#-                         Accept vaule: latest, system
#-    -o ?, --repo=?       Repository source.
#-                         Accept value: ius, codeit
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-
#- EXAMPLES
#-
#-    $ ./apache.sh -v system
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
#==============================================================================

#==============================================================================
# Part 1. Config
#==============================================================================

# Display package information, no need to change.
os_name="CentOS"
os_version="7"
package_name="Apache"

# Package manager: yum
_PM="yum"

# Default, you can overwrite this setting by assigning -v or --version option.
package_version="latest"

# Default repository source
repo_source="ius"

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
            # Which version of Apache you want to install?
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
            # Repository source
            "-o")
                repo_source="${2}"
                shift 2
            ;;
            "--repo="*)
                repo_source="${1#*=}"; 
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
    func::component_welcome "apache" "${package_version}"
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
    echo -e "      _                             _              "
    echo -e "     / \     _ __     __ _    ___  | |__     ___   "
    echo -e "    / _ \   | '_ \   / _  |  / __| | '_ \   / _ \  "
    echo -e "   / ___ \  | |_) | | (_| | | (__  | | | | |  __/  "
    echo -e "  /_/   \_\ | .__/   \__,_|  \___| |_| |_|  \___|  "
    echo -e "            |_|                                    "
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

# Check if Apache has been installed or not.
func::proviscript_msg info "Checking if apache is installed, if not, proceed to install it."

is_apache_installed=$(${_PM} list installed httpd 2>&1 | grep -o "httpd")

if [ "${is_apache_installed}" == "httpd" ]; then
    func::proviscript_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::proviscript_msg info "Try \"sudo ${_PM} remove httpd\""
    exit 2
fi

if [ "${package_version}" == "latest" ]; then

    # Install CodeIT repository
    if [ "${repo_source}" == "codeit" ]; then
        # We use CodeIT repository the get the latest Apache 2 (HTTP/2 ready).
        # More information please visit => https://codeit.guru/en_US/
        is_epel_installed=$(${_PM} list installed epel-release 2>&1 | grep -o "No matching")
        if [ "${is_epel_installed}" == "No matching" ]; then
            func::proviscript_msg info "CentOS 7 EPEL repository is not installed, installing..."
            sudo ${_PM} install -y epel-release
        fi

        # Add CodeIT repository.
        func::proviscript_msg info "Add CodeIT repository."
        sudo rm -rf /etc/yum.repos.d/codeit.el7.repo
        sudo bash -c "echo '[CodeIT]' >> /etc/yum.repos.d/codeit.el7.repo"
        sudo bash -c "echo 'name=CodeIT repo' >> /etc/yum.repos.d/codeit.el7.repo"
        sudo bash -c "echo 'baseurl=https://repo.codeit.guru/packages/centos/7/\$basearch/' >> /etc/yum.repos.d/codeit.el7.repo"
        sudo bash -c "echo 'gpgkey=https://repo.codeit.guru/RPM-GPG-KEY-codeit' >> /etc/yum.repos.d/codeit.el7.repo"
        sudo bash -c "echo 'gpgcheck=1' >> /etc/yum.repos.d/codeit.el7.repo"
        sudo bash -c "echo 'enabled=1' >> /etc/yum.repos.d/codeit.el7.repo"
    fi

    # Install IUS repository.
    if [ "${repo_source}" == "ius" ]; then
        sudo ${_PM} install https://centos${os_version}.iuscommunity.org/ius-release.rpm
    fi
fi

# Install Apache.
func::proviscript_msg info "Proceeding to install apache server."

# Install latest version.
if [ "${package_version}" == "latest" ]; then
    func::proviscript_msg warning "Apache http2 module no longer supports prefork mpm from version 2.4.27."
    func::proviscript_msg warning "Please use worker mpm instead of prefork mpm if you want to use http2 module."

    if [ "${repo_source}" == "codeit" ]; then
        sudo ${_PM} install -y httpd
    fi

    if [ "${repo_source}" == "ius" ]; then
        sudo ${_PM} --enablerepo=ius install -y httpd24u
    fi
else
    # Install system default version.
    sudo ${_PM} install -y httpd
fi

# To enable Apache server in boot.
func::proviscript_msg info "Enable service apache in boot."
sudo systemctl enable httpd

# To restart Apache service.
func::proviscript_msg info "Restart service apache."
sudo service httpd restart

# Work with SELinux
sudo setsebool -P httpd_execmem=1

# Check if FirewallD is enable or not
is_firewalld_active=$(systemctl status firewalld 2>&1 | grep -o "Active: active")

if [ "${is_firewalld_active}" == "Active: active" ]; then
    func::proviscript_msg info "Allow HTTP traffic to Apache in FirewallD."
    sudo firewall-cmd --permanent --zone=public --add-service=http 
    func::proviscript_msg info "Allow HTTPS traffic to Apache in FirewallD."
    sudo firewall-cmd --permanent --zone=public --add-service=https
    func::proviscript_msg info "Reload FirewallD to take effect."
    sudo firewall-cmd --reload
fi

apache_version="$(httpd -v 2>&1)"

if [[ "${apache_version}" = *"Apache"* && "${apache_version}" != *"command not found"* ]]; then
    func::proviscript_msg success "Installation process is completed."
    func::proviscript_msg success "$(httpd -v 2>&1)"
else
    func::proviscript_msg warning "Installation process is failed."
fi