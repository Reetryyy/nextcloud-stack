#!/bin/bash

# Function to Install the Nextcloud container
install_nextcloud_container() {
    docker compose up -d

    # Add the cronjob to run every 5 minutes
    (sudo crontab -l ; echo "*/5 * * * * docker exec -u www-data nextcloud-stack-web php -f /var/www/html/cron.php") | sudo crontab -
    # Fix Onlyoffice volume permission
    onlyoffice_volume_path=$(sudo docker volume inspect nextcloud-stack_onlyoffice --format '{{.Mountpoint}}')
    chmod u+w "$onlyoffice_volume_path"
}


# Function to start the Nextcloud container
start_container() {
    sudo docker compose start
    sudo docker ps | grep nextcloud-stack
}

# Function to stop the Nextcloud container
stop_container() {
    sudo docker compose stop
    sudo docker ps | grep nextcloud-stack
}

# Function to restart the Nextcloud container
restart_container() {
    docker compose restart
    sudo docker ps | grep nextcloud-stack
}

remove_container() {
    docker compose stop
    docker compose rm --force
    sudo docker ps | grep nextcloud-stack
}


# Main menu
while true; do
    echo "0. Install Nextcloud"
    echo "1. Start Nextcloud container"
    echo "2. Stop Nextcloud container"
    echo "3. Restart Nextcloud container"
    echo "4. Remove Nextcloud container"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        0) install_nextcloud_container ;;
        1) start_container ;;
        2) stop_container ;;
        3) restart_container ;;
        4) remove_container ;;
        5) exit ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
done
