# proviscript.sh

Document Transations: [English](./README_en_US.md) | [繁體中文](.README_zh_TW.md) | [简体中文](./README_zh_CN.md)

Proviscript means **Provi**sioning Shell **Script**s, to do fully automatic installations of most popular packages for Linux servers.

![Provisctipt Introdction](https://i.imgur.com/6s3YiiE.pngg)

Document is currently under construction.

Coming soon.

Quick start: https://cdn.proviscript.sh/

## How to use proviscript

#### Download
```
wget https://cdn.proviscript.sh/proviscript.tar.gz
tar -zxvf proviscript.tar.gz
cd proviscript-latest
```
#### Configure

Edit `config.yml` to see what packages you want to install.
```
vi config.yml
```
#### Run
```
./proviscript.sh install
```

That's it. Proviscript will install packages which defined in `install` section in `config.yml`

## Components

[Proviscript Components](https://github.com/Proviscript/proviscript/tree/master/components/ubuntu_16.04) are well-tested shell scripts that can help you install packages to just fire and forget. 

Ubuntu 16.04 LTS

| Package name  | Supported versions | Tested Vagrant box |
|---|---|---|
|  Nginx | **latest: 1.14**<br />mainline: 1.13.12<br />default | ubuntu/xenial64 | 
|  MariaDB |  **latest: 10.3**<br />default: 10.0 | ubuntu/xenial64 |
|  MySQL |  **latest: 8.0**<br />default: 5.7.18 | ubuntu/xenial64 |
|  PHP-FPM |  **7.2**, 7.1, 7.0, 5.6 | ubuntu/xenial64 |
|  Apache |  **latest: 2.4.33**<br />default: 2.4.18 | ubuntu/xenial64 |
|  Redis |  **latest: 4.0.9**<br />default: 3.0.6 | ubuntu/xenial64 |

Ubuntu 18.04 LTS

| Package name  | Supported versions | Tested Vagrant box |
|---|---|---|
|  Nginx | **latest: 1.14**<br />mainline: 1.13.12<br />default: 1.14 | ubuntu/bionic64 | 
|  MariaDB |  **latest: 10.3**<br />default: 10.1.29 | ubuntu/bionic64 |
|  MySQL |  **latest: 8.0**<br />default: 5.7.22 | ubuntu/bionic64 |
|  PHP-FPM |  **7.2**, 7.1, 7.0, 5.6 | ubuntu/bionic64 |
|  Apache |  **latest: 2.4.33**<br />default: 2.4.29 | ubuntu/bionic64 |
|  Redis |  **latest: 4.0.9**<br />default: 4.0.9 | ubuntu/bionic64 |

Each component script can be executed as standalone mode, in standalone mode, you can just simply change your current dictionary to `components/ubuntu_16.04` and then execute the scripts to install packages, see example below.

---

### Nginx

Download
https://cdn.proviscript.sh/components/ubuntu_16.04/nginx.sh

```
 SYNOPSIS

    nginx.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Nginx you want to install?
                         Accept vaule: stable, mainline, default
                         
    -h, --help           Print this help.
    -i, --info           Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./nginx.sh -v stable
    $ ./nginx.sh --version=mainline
    $ ./nginx.sh
```

### MariaDB

Download
https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh


Manual
```
 SYNOPSIS

    mysql.sh [-h] [-p [password]] [-s [y|n]] [...]

 OPTIONS

    -p ?, --password=?            Set mysql root password.
    -s ?, --secure=?              Enable mysql secure configuration.
                                  Accept vaule: y, n
    -r ?, --remote=?              Enable access mysql remotely.
                                  Accept vaule: y, n
    -ru ?, --remote-user=?        Remote user.
    -rp ?, --remote-password=?    Remote user's password.
    -v ?, --version=?             Which version of MariaDB you want to install?
                                  Accept vaule: latest, default
    -h, --help                    Print this help.
    -i, --info                    Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./mariadb.sh -v latest -s y -r y -ru test_user -rp 12345678
    $ ./mariadb.sh --version=default --secure=y --remote==y --remote-user=test_user --remote-password=12345678

```

### MySQL

Download
https://cdn.proviscript.sh/components/ubuntu_16.04/mysql.sh

Example
```shell
./mariadb.sh --version=default --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```
Manual:
```
 SYNOPSIS

    mysql.sh [-h] [-p [password]] [-s [y|n]] [...]

 OPTIONS

    -p ?, --password=?            Set mysql root password.
    -s ?, --secure=?              Enable mysql secure configuration.
                                  Accept vaule: y, n
    -r ?, --remote=?              Enable access mysql remotely.
                                  Accept vaule: y, n
    -ru ?, --remote-user=?        Remote user.
    -rp ?, --remote-password=?    Remote user's password.
    -v ?, --version=?             Which version of MySQL you want to install?
                                  Accept vaule: latest, default
    -h, --help                    Print this help.
    -i, --info                    Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./mysql.sh -v latest -s y -r y -ru test_user -rp 12345678
    $ ./mysql.sh --version=default --secure=y --remote==y --remote-user=test_user --remote-password=12345678

```

### PHP-FPM

Download
https://cdn.proviscript.sh/components/ubuntu_16.04/php-fpm.sh

Manual
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
https://cdn.proviscript.sh/components/ubuntu_16.04/apache.sh

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
https://cdn.proviscript.sh/components/ubuntu_16.04/redis.sh

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



### Vagrant Provisioning

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
    s.path = "https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh"
    s.privileged: "false"
    s.args = ["--version=latest --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678"]
  end
end
```

### Install a package

Let's take MariaDB as an example.

```shell
wget https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh
```
```shell
chmod 755 ./mariadb.sh
```
```shell
./mariadb.sh --version=latest --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

## Authors

Meet the authors:
https://github.com/Proviscript/proviscript/graphs/contributors

## License

MIT

<small>
Copyright (C) 2018 proviscript.sh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</small>

