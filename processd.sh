#!/usr/bin/env bash

echo "Process monitoring and auto-healing script"

# if [ -f "/var/run/nginx.pid" ]; then 
#     echo "nginx is running"
# else 
#     echo "nginx is NOT running, attempting healing"
#     sudo apt install nginx -y
#     sudo systemctl start nginx
#     if [ $? -eq 0 ]; then 
#         echo "service healed sucessfully"
#     else 
#         echo "failed to heal service"
#     fi
# fi

MONITORING_TARGETS="$HOME/Desktop/monitoring_targets.txt"
touch "$MONITORING_TARGETS"




monitor() {
    # echo "monitoring: $1"
    # systemctl is-active "$1"
    # echo $?

    
}

demonitor() {
    echo "demonitoring: $1"
}


case "$1" in
    "monitor")
        # some commands
        monitor "$2"
        ;;
    "demonitor")
        # some commands 
        demonitor "$2"
        ;;
    *)
        # some commands 
        ;;
esac