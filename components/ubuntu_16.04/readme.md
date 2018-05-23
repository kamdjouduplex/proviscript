# Proviscript Standalone Mode

Ubuntu 16.04 LTS (Xenial Xerus)

<small>Last updated: 2018/05/23</small>

---

## Components

Proviscript Components are well-tested shell scripts that can help you install packages to just fire and forget. 

| name  | default version | supported versions | 
|---|---|---|
|  Nginx |  1.14 | stable: 1.14 <br />mainline: 1.13.12 | 
|  MariaDB |  10.2 | 10.2
|  PHP-FPM |  7.2 * | 5.6, 7.0, 7.1, 7.2

Getting started with standalone mode. In standalone mode, you can just simply change your current dictionary to `components/ubuntu_16.04` and then execute the command below.


### Nginx

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

### MariaDB

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
### PHP-FPM

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