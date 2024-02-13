#!/bin/bash

# Function to Install the hpb containers
install_hpb_container() {
  docker compose up -d
  echo "Please wait, fixing caddy formating..."
  sleep 10
  # Fix Caddy formating
  docker exec hpb_proxy caddy fmt --overwrite /etc/caddy/Caddyfile
  echo "Done!"
  exit
}
# Function to start the hpb containers
start_container() {
    sudo docker compose start
    sudo docker ps | grep hpb
}

# Function to stop the hpb containers
stop_container() {
    sudo docker compose stop
    sudo docker ps | grep hpb
}

# Function to restart the hpb containers
restart_container() {
    docker compose restart
    sudo docker ps | grep hpb
}

remove_container() {
    docker compose stop
    docker compose rm --force
    sudo docker ps | grep hpb
}
build() {
    docker compose build
}


# Main menu
while true; do
    echo "0. Install HPB "
    echo "1. Build HPB contaienrs"
    echo "2. Start HPB containers"
    echo "3. Stop HPB containers"
    echo "4. Restart HPB containers"
    echo "5. Remove HPB containers"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        0) install_hpb_container ;;
	1) build;;
        2) start_container ;;
        3) stop_container ;;
        4) restart_container ;;
        5) remove_container ;;
        6) exit ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
done
