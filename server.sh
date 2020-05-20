#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function InitServer () {
    echo -e "${GREEN}(Laravel) Copy .env.example to .env${NC}"
    cp .env.example .env
    echo -e "${GREEN}(Laravel) Give permissions${NC}"
    chmod -R 777 storage/ bootstrap/cache public/
    cd laradock/
    echo -e "${GREEN}(Laradock) Copy env-example .env${NC}"
    cp env-example .env
    echo -e "${GREEN}(Laradock) Initializing services${NC}"
    docker-compose up -d nginx workspace postgres
    echo -e "${GREEN}(Laravel) Instal dependences${NC}"
    docker-compose exec workspace composer install
    echo -e "${GREEN}(Laravel) Generate key${NC}"
    docker-compose exec workspace php artisan key:generate
    echo -e "${GREEN}(Laravel) Clean cache${NC}"
    docker-compose exec workspace php artisan config:cache
    echo -e "${GREEN}(Laravel) Run Migrations${NC}"
    docker-compose exec workspace php artisan migrate
    echo -e "${GREEN}(Laravel) Run Seeders${NC}"
    docker-compose exec workspace php artisan db:seed
    echo -e "${GREEN}Everything is ready${NC}"
}

function UpServer () {
    cd laradock/
    echo -e "${GREEN}Initializing services${NC}"
    docker-compose up -d nginx workspace postgres
}

function DownServer () {
    cd laradock/
    echo -e "${GREEN}Down services${NC}"
    docker-compose down
}

function RestartServer () {
    cd laradock/
    echo -e "${GREEN}Restarting services${NC}"
    docker-compose restart
}

function EnterTerminal () {
    cd laradock/
    echo -e "${GREEN}Entering the terminal${NC}"
    docker-compose exec workspace bash
}

function GetModule () {
    cd app/Console
    echo -e "${GREEN}Clone module generator${NC}"
    git clone https://github.com/EmersonBraun/laravel_module_generator.git Commands
    echo -e "${GREEN}New command added (generate:module)${NC}"
}

if [ $1 = "init" ]; then
    InitServer
elif [ $1 = "up" ]; then
    UpServer
elif [ $1 = "down" ]; then
    DownServer
elif [ $1 = "restart" ]; then
    RestartServer
elif [ $1 = "terminal" ]; then
    EnterTerminal
elif [ $1 = "module" ]; then
    GetModule
else
    echo -e "$1 ${RED}it's an invalid option${NC}"
    exit 1
fi