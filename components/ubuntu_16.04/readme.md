# Proviscript Standalone Mode

Ubuntu 16.04 LTS (Xenial Xerus)

<small>Last updated: 2018/05/28</small>



| Package name  | Supported versions | Vagrant box |
|---|---|---|
|  Nginx | **stable: 1.14**<br />mainline: 1.13.12 | ubuntu/xenial64 | 
|  MariaDB |  **10.2** | ubuntu/xenial64 |
|  PHP-FPM |  **7.2**, 7.1, 7.0, 5.6 | ubuntu/xenial64 |
|  Apache |  **latest: 2.4.33**<br />default: 2.4.18 | ubuntu/xenial64 |
|  Redis |  **latest: 4.0.9**<br />default: 3.0.6 | ubuntu/xenial64 |

Getting started with standalone mode. In standalone mode, you can just simply change your current dictionary to `components/ubuntu_16.04` and then execute the command below.

### Vargrant Provisioning

It's highly recommended to use Proviscript's CDN service to quick provison your Vagrant machine.

```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/nginx.sh", privileged: "false"
  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/php-fpm.sh", privileged: "false"
  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh", privileged: "false"
  
end
```

With script arguments:

```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell" do |s|
    s.path = "https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/mariadb.sh"
	s.privileged: "false"
    s.args = ["--version=10.2 --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678"]
  end
end
```

### Install Packages

```shell
wget https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/mariadb.sh
```
```shell
chmod 755 ./mariadb.sh
```
```shell
./mariadb.sh --version=10.2 --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

---

## Components

### Nginx

Download:
https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/nginx.sh

```
 SYNOPSIS

    nginx.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Nginx you want to install?
                         Accept vaule: stable, mainline
                         
    -h, --help           Print this help.
    -i, --info           Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./nginx.sh -v stable
    $ ./nginx.sh --version=mainline
    $ ./nginx.sh
```

### MariaDB

Download:
https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/mariadb.sh


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

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./mariadb.sh -v 10.2 -s y -r y -ru test_user -rp 12345678
    $ ./mariadb.sh --version=10.2 --secure=y --remote==y --remote-user=test_user --remote-password=12345678

```
### PHP-FPM

Download:
https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/php-fpm.sh

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

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./php-fpm.sh -v 7.2
    $ ./php-fpm.sh --version=7.2
    $ ./php-fpm.sh
```

### Apache

Download:
https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/apache.sh

```
 SYNOPSIS

    apache.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Apache you want to install?
                         Accept vaule: latest, default
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./apache.sh -v default
    $ ./apache.sh --version=latest
    $ ./apache.sh

```

### Redis

Download:
https://cdn.proviscript.sh/cdn/components/ubuntu_16.04/redis.sh

```
 SYNOPSIS

    redis.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Redis you want to install?
                         Accept vaule: latest
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./redis.sh -v latest
    $ ./redis.sh --version=latest
    $ ./redis.sh

```

More component scripts will be added..
