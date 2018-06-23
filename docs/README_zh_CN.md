# proviscript.sh

Document Transations: [English](./README_en_US.md) | [繁體中文](./README_zh_TW.md) | [简体中文](./README_zh_CN.md)

Proviscript字面上意思源自 **Provi**sioning Shell **Script**s，（预装设置命令脚本）为的是化繁为简，一只指令就能进行静默安装各种在Linux服务器上受欢迎的软体套件。

## 支持的作业系统

| 作业系统 | - |  套件 | 测试的 Vagrant box 
|---|---| --- | --- |
|  CentOS 6 | ![CentOS Logo](https://i.imgur.com/JQW7wvE.png) |  | centos/6
|  CentOS 7 | ![CentOS Logo](https://i.imgur.com/JQW7wvE.png) | `Nginx` | centos/7
|  Debian 9 | ![Debian Logo](https://i.imgur.com/Eokf4Pz.png) |
|  Fedora 28 | ![Fedora Logo](https://i.imgur.com/upBNWL5.png) |
|  Ubuntu 16.04 | ![Ubuntu Logo](https://i.imgur.com/kf8Oeno.png)|  `Apache` `MairaDB` `MySQL` `Nginx` `PHP-FPM` `Redis` | ubuntu/xenial64
|  Ubuntu 18.04 | ![Ubuntu Logo](https://i.imgur.com/kf8Oeno.png)|  `Apache` `MairaDB` `MySQL` `Nginx` `PHP-FPM` `Redis` | ubuntu/bionic64

更多的软件包将被添加到 Proviscript 项目中，请订阅我们获取最新的更新。

## 如何使用

- 启动器模式
- 独立模式

![Provisctipt Introdction](https://i.imgur.com/6s3YiiE.png)

#### 下载
```
wget https://cdn.proviscript.sh/proviscript.tar.gz
tar -zxvf proviscript.tar.gz
cd proviscript-latest
```
#### 设定

編輯 `config.yml` 查看要安裝的套件
```
vi config.yml
```
#### 执行
```
./proviscript.sh install
```

就只有這樣。Proviscript 會安裝在 `config.yml` 中有被設定在 `install` 區塊內的套件。

## 组件

[Proviscript 組件](https://github.com/Proviscript/proviscript/tree/master/components/ubuntu_16.04) 是经过测试的命令脚本，帮你在安装时可以设后不理。然后就装好了。

Ubuntu 16.04 LTS

| 套件名称  | 支援版本 | 测试的 Vagrant 盒子 |
|---|---|---|
|  Nginx | **latest: 1.14**<br />mainline: 1.13.12<br />default: 1.10.3 | ubuntu/xenial64 | 
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

每一支组件脚本可以独立执行。独立执行模式的方法很简单，切换到  `components / ubuntu_16.04` 然后执行脚本安装套件，看以下的使用范例。

---

### Nginx

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/nginx.sh

手册

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

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh

手册

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

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/mysql.sh

手冊

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

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/php-fpm.sh

手冊

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

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/apache.sh

手冊

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

下载

https://cdn.proviscript.sh/components/ubuntu_16.04/redis.sh

手冊

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

更多组件会陆续加入...



### Vargrant 預裝

强烈建议使用 Proviscript 的 CDN 服务，快速部属您的 Vargeant 机器。


```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/nginx.sh", privileged: "false"
  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/php-fpm.sh", privileged: "false"
  config.vm.provision "shell", path: "https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh", privileged: "false"
  
end
```

带参数：

```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell" do |s|
    s.path = "https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh"
    s.privileged = "false"
    s.args = ["--version=latest", "--password=12345678", "--secure=y",  "--remote=y", "--remote-user=testuser", "--remote-password=12345678"]
  end
end
```

### 安装一个套件

在此我们用MariaDB当作范例。


```shell
wget https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh
```
```shell
chmod 755 ./mariadb.sh
```
```shell
./mariadb.sh --version=latest --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

## 作者

拜访作者：

https://github.com/Proviscript/proviscript/graphs/contributors

## 授权

MIT

<small>
Copyright (C) 2018 proviscript.sh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
</small>

