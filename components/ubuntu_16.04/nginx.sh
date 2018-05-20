#!/usr/bin/env bash
#
# nginx.sh
#

# Nginx
package_version=stable

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="Nginx"

if [ "$(type -t func_component_welcome)" == function ]; then 
    func_component_welcome "nginx" "${package_version}"
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version} (latest)                                            ";
echo "----------------------------------------------------------------------------------";
echo

# Check if Nginx has been installed or not.
is_nginx_installed=$(dpkg-query -W --showformat='${Status}\n' nginx | grep "install ok installed")

if [ "${is_nginx_installed}" == "install ok installed" ]; then
    echo "${package_name} is already installed, please remove it before executing this script."
    echo "Try \"sudo apt-get purge nginx\""
    exit 2
fi

# Check if software-properties-common installed or not.
is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

# Check if add-apt-repository command is available to use or not.
if [ "${is_add_apt_repository}" == "" ]; then
    sudo apt-get install -y software-properties-common
fi

# Add repository for Nginx.
sudo add-apt-repository --yes ppa:nginx/${package_version}

# Update repository for Nginx. 
sudo apt-get update

# Install Nginx
sudo apt-get install -y nginx

# To Enable Nginx server in boot.
sudo systemctl enable nginx

sudo service nginx restart