#!/usr/bin/bash

cd app
docker compose exec webserver composer create-project --prefer-dist laravel/laravel .
