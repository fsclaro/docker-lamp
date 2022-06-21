#!/usr/bin/bash

sudo rm -rf app data logs

mkdir -p app logs/apache2 logs/xdebug data/mysql logs/mysql data/phpmyadmin/sessions data/redis

touch app/.gitkeep
touch logs/.gitkeep
touch logs/apache2/.gitkeep
touch logs/xdebug/.gitkeep
touch logs/mysql/.gitkeep

touch data/.gitkeep
touch data/mysql/.gitkeep
touch data/phpmyadmin/.gitkeep
touch data/phpmyadmin/sessions/.gitkeep
touch data/redis/.gitkeep
