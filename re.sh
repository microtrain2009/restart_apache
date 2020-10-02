#!/bin/bash

CONFIG="$1"
COMMAND="$2"

# Does the first parameter an actual virtual-host
FILEMATCH=false

# A concatenated string of virtual hosts
VALID_VHOSTS=''

# Grab a list of all virtual-host files
VHOSTS=/etc/apache2/sites-available/*.conf

if [ $# -ne 2 ]
then
    echo -e "\e[31mERROR:${0} requires \e[1m\e[33mtwo\e[0m \e[31mparamters\e[0m  \n * a virtual-host configuration \n * a service command"
    exit 1
fi

# Loop through the all files in the sites-avaliable directory
# Build a list of filenames to display in the error message
# If we find a match set $FILEMATCH to true and stop build the list
for FILENAME in $VHOSTS
do

  VHOST="${FILENAME:29:-5}"
  # Add each virtual-host in the sites-available directory to 
  # the VHOSTS string. This will provide user feedback if there
  # is an error
  if [ -z  "$VALID_VHOSTS" ]
    then
      VALID_VHOSTS="\n * $VHOST"
    else
      VALID_VHOSTS="${VALID_VHOSTS}\n * $VHOST"
    fi

  if [ "$FILENAME" == "/etc/apache2/sites-available/${CONFIG}.conf" ]
  then
    # Set $FILEMATCH to true if one of those files matches an actual
    # virtual-host configuration and break the loop
    FILEMATCH=true
    break
  fi
done
