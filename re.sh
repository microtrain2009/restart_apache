#!/bin/bash
CONFIG="$1"
COMMAND="$2"

if [ $# -ne 2 ]
then
    echo "ERROR: $0 requires two parameters {virtual-host} {restart|reload}"
    exit 1
fi

# only allow reload or restart.
if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
then


# Move the current execution state to the proper directory
cd /etc/apache2/sites-available

# Disable a vhost configuration
sudo a2dissite "$CONFIG"
sudo service apache2 "$COMMAND"

# Enable a vhost configuration
sudo a2ensite "$CONFIG"
sudo service apache2 "$COMMAND"

else
    echo "ERROR: $COMMAND is an invalid service command {restart|reload}"
    exit 1
fi
