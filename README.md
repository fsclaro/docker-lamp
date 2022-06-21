#  LAMP stack built with Docker Compose

A basic LAMP stack environment built using Docker Compose. It consists of the following:

* PHP 7.4.X / 8.0.X / 8.1.X
* Apache 2.4.X
* MySQL 8.X / MariaDB 10.7
* phpMyAdmin
* Redis
* Memcached
* Mailhog

##  Installation

* Clone this repository on your local computer
* Copy env.example to .env
* Configure .env as needed
* Run the `docker-compose up -d`.

```shell
git clone https://github.com/fsclaro/docker-lamp.git
cd docker-lamp/
cp env.example .env
// modify sample.env as needed
docker-compose up -d
// visit localhost
```

Your LAMP stack is now ready!! You can access it via `http://localhost`.

##  Configuration and Usage

### General Information
This Docker Stack is build for local development and not for production usage.

### Configuration
This package comes with default configuration options. You can modify them by creating `.env` file in your root directory.
To make it easy, just copy the content from `env.example` file and update the environment variable values as per your need.

### Configuration Variables
There are following configuration variables available and you can customize them by overwritting in your own `.env` file.

---
#### PROJECT
---

_**COMPOSE_PROJECT_NAME**_ - Define the name prefix for images and containers

---
#### Apache
---

_**DOCUMENT_ROOT**_ - It is a document root for Apache server. The default value for this is `./www`. All your sites will go here and will be synced automatically.

_**APACHE_DOCUMENT_ROOT**_ - Apache config file value. The default value for this is /var/www/html.

_**VHOSTS_DIR**_ - This is for virtual hosts. The default value for this is `./config/vhosts`. You can place your virtual hosts conf files here.

> Make sure you add an entry to your system's `hosts` file for each virtual host.

_**APACHE_LOG_DIR**_ - This will be used to store Apache logs. The default value for this is `./logs/apache2`.

_**HOST_MACHINE_UNSEGURE_HOST_PORT**_ - Define the port for http:// connections.

_**HOST_MACHINE_SEGURE_HOST_PORT**_ - Define the port for https:// connections.

---
#### PHP
---

_**PHPVERSION**_ - Define version for PHP. The possible values are: **php74**, **php80** and **php81**.

_**PHP_INI**_ - Define your custom `php.ini` modification to meet your requirments.

---
#### PHPMyAdmin
---

_**UPLOAD_LIMIT**_ and _**MEMORY_LIMIT**_ - Define limits memory usage.

_**HOST_MACHINE_PMA_PORT**_ - Define the port to access phpmyadmin.

---
#### XDEBUG
---

_**XDEBUG_LOG_DIR**_ - This is will be used to store que log of xdebug.

_**XDEBUG_PORT**_ - Define the port number for xdebug.


---
#### Database
---

> For Apple Silicon Users:
Please select Mariadb as Database. Oracle doesn't build their SQL Containers for the arm Architecure.

_**DATABASE**_ - Define which MySQL or MariaDB Version you would like to use.

_**MYSQL_INITDB_DIR**_ - When a container is started for the first time files in this directory with the extensions `.sh`, `.sql`, `.sql.gz` and `.sql.xz` will be executed in alphabetical order. `.sh` files without file execute permission are sourced rather than executed. The default value for this is `./config/initdb`.

_**MYSQL_DATA_DIR**_ - This is MySQL data directory. The default value for this is `./data/mysql`. All your MySQL data files will be stored here.

_**MYSQL_LOG_DIR**_ - This will be used to store Apache logs. The default value for this is `./logs/mysql`.

_**MYSQL_DATABASE**_ - Name of database will be created.

_**MYSQL_ROOT_PASSWORD**_ - Define the password for root user.

_**MYSQL_USER**_ - User name that will be created to access database.

_**MYSQL_PASSWORD**_ - Password for user.

_**HOST_MACHINE_MYSQL_PORT**_ - Port that will be used to connecto to mysql database.

## Web Server

Apache is configured to run on port 80. So, you can access it via `http://localhost`.

#### Apache Modules

By default following modules are enabled.

* rewrite
* headers

> If you want to enable more modules, just update `./bin/phpX/Dockerfile`. You can also generate a PR and we will merge if seems good for general purpose.
> You have to rebuild the docker image by running `docker-compose build` and restart the docker containers.

#### Connect via SSH

You can connect to web server using `docker-compose exec` command to perform various operation on it. Use below command to login to container via ssh.

```shell
docker-compose exec webserver bash
```

## PHP

The installed version of php depends on your `.env`file.

#### Extensions

By default following extensions are installed.

* bcmath
* calendar
* Core
* ctype
* curl
* date
* dom
* exif
* fileinfo
* filter
* ftp
* gd
* gettext
* hash
* iconv
* imagick
* intl
* json
* libxml
* mbstring
* mysqli
* mysqlnd
* openssl
* pcntl
* pcre
* PDO
* pdo_mysql
* pdo_sqlite
* Phar
* posix
* readline
* redis
* Reflection
* session
* SimpleXML
* soap
* sockets
* sodium
* SPL
* sqlite3
* standard
* tokenizer
* xdebug
* xml
* xmlreader
* xmlwriter
* Zend OPcache
* zip
* zlib

> If you want to install more extension, just update `./bin/webserver/Dockerfile`. You can also generate a PR and we will merge if it seems good for general purpose.
> You have to rebuild the docker image by running `docker-compose build` and restart the docker containers.

## phpMyAdmin

phpMyAdmin is configured to run on port 8080. Use following default credentials.

http://localhost:8080/
username: root
password: developer

## Xdebug

Xdebug version 3.X.X comes installed by default and it's version depends on the PHP version chosen in the `".env"` file.

To use Xdebug you need to enable the settings in the `./config/php/php.ini` file according to the chosen version PHP.

Example:

```
# Xdebug 3
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_host=host.docker.internal
xdebug.client_port=9003
xdebug.idekey=VSCODE
```

Xdebug VS Code: you have to install the Xdebug extension "PHP Debug". After installed, go to Debug and create the launch file so that your IDE can listen and work properly.

Example:

**VERY IMPORTANT:** the `pathMappings` depends on how you have opened the folder in VS Code. Each folder has your own configurations launch, that you can view in `.vscode/launch.json`

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                // "/var/www/html": "${workspaceFolder}/www" // if you have opened VSCODE in root folder
                "/var/www/html": "${workspaceFolder}" // if you have opened VSCODE in ./www folder
            }
        }
    ]
}
```

Now, make a breakpoint and run debug.

**Tip!** After theses configurations, you may need to restart container.

## Redis

It comes with Redis. It runs on default port `6379`.

---

Thanks You

References: https://github.com/sprintcube/docker-compose-lamp
