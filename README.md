# proviscript.sh

Proviscript means **P**rovisioning **s**hell **scripts**, to do fully automatic installations of most popular packages for Linux servers.

Document is currently under construction.

Coming soon.

## Components

Proviscript Components are well-tested shell scripts that can help you install packages to just fire and forget. 

| Package name  | Supported versions | Vagrant box | Docker image |
|---|---|---|---|
|  Nginx |  *stable: 1.14 *<br />mainline: 1.13.12 | ubuntu/xenial64 | not tested yet |
|  MariaDB |  *10.2* | ubuntu/xenial64 | not tested yet |
|  PHP-FPM |  *7.2*, 7.1, 7.0, 5.6 | ubuntu/xenial64 | not tested yet |


## How to use proviscript

1. Dialog mode
2. Standalone Mode

### Dialog mode

Coming soon.

### Standalone Mode

Ubuntu 16.04 LTS (Xenial Xerus)

<small>Last updated: 2018/05/23</small>

In schedule:

Ubuntu 14.04
CentOS 7
Debian 9
Fedora 28
FreeBSD 11

---

Getting started with standalone mode. Standalone mode means you can execute the script alone without proviscript.sh (Actually proviscript.sh is desgned as an launcher to call them when neeeded). 

You can just simply change your current dictionary to `components/ubuntu_16.04` and then execute the command below. 

#### Nginx

By default, this script will install the latest stable version of Nginx.
Check out <a href="https://nginx.org/en/download.html">Nginx download page</a> for more details.

```
./nginx.sh
```


```
 SYNOPSIS

    nginx.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Nginx you want to install?
                         Accept vaule: stable, mainline
    -h, --help           Print this help.
    -i, --info           Print script information.

 EXAMPLES

    $ ./nginx.sh -v stable
    $ ./nginx.sh --version=mainline
    $ ./nginx.sh
```

#### MariaDB

Just simply install MariaDB 10.2.
```
./mariadb.sh --version=10.2
```
Default root password is `proviscript`.

You can also do a secure mysql installation without password prompt.

```
./mariadb.sh --version=10.2 --password=yourpassword --secure=y
```
Add an user who can access Mysql remotely.
```
./mariadb.sh --version=10.2 --password=yourpassword --secure=y --remote==y --remote-user=test_user --remote-password=12345678
```

```
 SYNOPSIS

    mariadb.sh [-h] [-p [password]] [-s [y|n]] [...]

 OPTIONS

    -p ?, --password=?            Set mysql root password.
    -s ?, --secure=?              Enable mysql secure configuration.
                                  Accept vaule: y, n
    -r ?, --remote=?              Enable access mysql remotely.
                                  Accept vaule: y, n
    -ru ?, --remote-user=?        Remote user.
    -rp ?, --remote-password=?    Remote user's password.
    -v ?, --version=?             Which version of MariaDB you want to install?
                                  Accept vaule: version number
    -h, --help                    Print this help.
    -i, --info                    Print script information.

 EXAMPLES

    $ ./mariadb.sh -v 10.2 -s y -r y -ru test_user -rp 12345678
    $ ./mariadb.sh --version=10.2 --secure=y --remote==y --remote-user=test_user --remote-password=12345678

```
#### PHP-FPM

```
 SYNOPSIS

    php-fpm.sh [-h] [-i] [-l] [-v [version]] [-m [modules]]

 OPTIONS

    -v ?, --version=?    Which version of PHP-FPM you want to install?
                         Accept vaule: 5.6, 7.0, 7,1, 7.2
    -m ?, --modules=?    Which modules of PHP-FPM you want to install?
                         Accept vaule: A comma-separated list of module names.
                         See "./php-fpm.sh --module-list"
    -h, --help           Print this help.
    -i, --info           Print script information.
    -l, --module-list    Print module list of PHP-FPM.

 EXAMPLES

    $ ./php-fpm.sh -v 7.2
    $ ./php-fpm.sh --version=7.2
    $ ./php-fpm.sh
```
