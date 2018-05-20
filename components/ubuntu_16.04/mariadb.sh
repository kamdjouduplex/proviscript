#!/usr/bin/env bash
#
# mariadb.sh
#

# Check if mariadb.sh is loaded by proviscript.sh
if [ -z "${PROVISCRIPT+x}" ]; then

    # Set up the variables to run this script in silent mode,
    # Or it will prompt you to submit those information.
    mysql_root_password="proviscript"
    mysql_secure="n"
    mysql_remote_access="n"

    # The following variables are not needed when mysql_remote_access="n"
    mysql_remote_user="proviscript"
    mysql_remote_password_="proviscript"

    # Default, you can modify it if you want other specific version.
    package_version="10.2"
fi

# Display package information, no need to change.
os_name="Ubuntu"
os_version="16.04"
package_name="MariaDB"

if [ "$(type -t func_component_welcome)" == function ]; then 
    func_component_welcome "mariadb" "${package_version}"
fi

echo
echo "----------------------------------------------------------------------------------";
echo " @os: ${os_name} ${os_version}                                                    ";
echo " @package: ${package_name}                                                        ";
echo " @version: ${package_version}                                                     ";
echo "----------------------------------------------------------------------------------";
echo

# Check if MariaDb has been installed or not.
is_mariadb_installed=$(dpkg-query -W --showformat='${Status}\n' mariadb-server | grep "install ok installed")

if [ "${is_mariadb_installed}" == "install ok installed" ]; then
    echo "${package_name} is already installed, please remove it before executing this script."
    echo "Try \"sudo apt-get purge mariadb-server\""
    exit 2
fi

# Check if software-properties-common installed or not.
is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

# Check if add-apt-repository command is available to use or not.
if [ "${is_add_apt_repository}" == "" ]; then
    sudo apt-get install -y software-properties-common
fi

# Add repository for MariaDB.
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository "deb [arch=amd64,i386,ppc64el] http://ftp.ubuntu-tw.org/mirror/mariadb/repo/${package_version}/ubuntu xenial main"

# Update repository for MariaDB. 
sudo apt-get update

# Install MariaDB without password prompt.
sudo apt-get install -y debconf-utils
sudo export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "maria-server-${package_version} mysql-server/root_password password DefaultPass"
sudo debconf-set-selections <<< "maria-server-${package_version} mysql-server/root_password_again password DefaultPass"
sudo apt-get purge -y debconf-utils

# Install MariaDB server
sudo apt-get install -y mariadb-server

# To Enable MariaDB server in boot.
sudo systemctl enable mariadb

# As same as secure_mysql_installation.
# --------------------------------------
# 1) Change the root password.
# 2) Disallow root login remotely.
# 3) Remove anonymous users.
# 4) Remove test database and access to it.
if [ "${mysql_secure}" == "y" ]; then
    sudo mysql -uroot -pDefaultPass << EOF
        UPDATE mysql.user SET Password=PASSWORD('${mysql_root_password}') WHERE User='root';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
        FLUSH PRIVILEGES;
EOF
fi

# This is an option,If you need remote access the MySQL server
# Allow remote access.
if [ "${mysql_remote_access}" == "y" ]; then
    sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

    # Setup an user account and access a MySQL server remotely.
    sudo mysql -uroot -p${mysql_root_password} << EOF
        CREATE USER '${mysql_remote_user}'@'%' IDENTIFIED BY '${mysql_remote_password}';
        GRANT ALL PRIVILEGES ON *.* TO '${mysql_remote_user}'@'%';
        FLUSH PRIVILEGES;
EOF
fi

sudo service mysql restart

