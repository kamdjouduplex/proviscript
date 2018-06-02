# proviscript.sh

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

| Package name  | Supported versions | Vagrant box |
|---|---|---|
|  Nginx | **stable: 1.14**<br />mainline: 1.13.12 | ubuntu/xenial64 | 
|  MariaDB |  **10.2** | ubuntu/xenial64 |
|  MySQL |  **latest: 8.0**<br />default: 5.7.18 | ubuntu/xenial64 |
|  PHP-FPM |  **7.2**, 7.1, 7.0, 5.6 | ubuntu/xenial64 |
|  Apache |  **latest: 2.4.33**<br />default: 2.4.18 | ubuntu/xenial64 |
|  Redis |  **latest: 4.0.9**<br />default: 3.0.6 | ubuntu/xenial64 |

Each component script can be executed as standalone mode, in standalone mode, you can just simply change your current dictionary to `components/ubuntu_16.04` and then execute the scripts to install packages, see example below.

### Examples

#### MariaDB
```shell
./mariadb.sh --version=10.2 --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

#### Nginx
```shell
./nginx.sh
```

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
    s.path = "https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh"
    s.privileged: "false"
    s.args = ["--version=10.2 --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678"]
  end
end
```

### Install a package

```shell
wget https://cdn.proviscript.sh/components/ubuntu_16.04/mariadb.sh
```
```shell
chmod 755 ./mariadb.sh
```
```shell
./mariadb.sh --version=10.2 --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

