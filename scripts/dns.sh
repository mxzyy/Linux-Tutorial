#!/bin/bash

# Created by
#    ____
#   / __ \ _ __ ___ __  __ _____   _ _   _
#  / / _` | '_ ` _ \\ \/ /|_  / | | | | | |
# | | (_| | | | | | |>  <  / /| |_| | |_| |
#  \ \__,_|_| |_| |_/_/\_\/___|\__, |\__, |
#   \____/                      __/ | __/ |
#                              |___/ |___/


# Global Variable
dir=hilmy # Directory on Bind File
name=hilmy # Name of your domain without TLD
domain=hilmy.com # Domain aja
ip=192.168.2.1 # IP of Main Domain

pkg="bind dnsutils"
pkg_true=$(dpkg-query -W --showformat='${Status}\n' $pkg | grep "install ok installed")
echo Checking for $pkg: $pkg_true
if [ "" = "$pkg_true" ]; then
  echo "No $pkg. Setting up $pkg."
  sudo apt-get --yes install $pkg
fi


# Creating a Directory for Forward n Reverse DNS File
if mkdir /etc/bind/$dir; then
  echo "$dir Created in Bind9 Directory.."
  sleep 0.5
else
  echo "$dir is Created or I dont know.."
  sleep 0.5
fi


# Copy Forward Zone File
if cp -R /etc/bind/db.local /etc/bind/$dir/db.$name; then
  echo "DB Local has been copied.."
  sleep 0.5
else
  echo "File exist or i dont know"
  sleep 0.5
fi


# Copy Reverse Zone File
if cp -R /etc/bind/db.127 /etc/bind/$dir/$name.rev; then
  echo "DB Rev has been copied.."
  sleep 0.5
else
  echo "File exist or i dont know"
  sleep 0.5
fi


# Change Localhost to Domain
if sed -i s/localhost/$domain/g /etc/bind/$dir/db.$name; then
  echo "Forward File Localhost Changed to $domain .."
  sleep 0.5
else
  echo "Error, Check your db.$name"
  sleep 0.5
fi

if sed -i s/localhost/$domain/g /etc/bind/$dir/$name.rev; then
  echo "Reverse File Localhost Changed to $domain .."
  sleep 0.5
else
  echo "Error, Check your $name.rev"
  sleep 0.5
fi


# Change Forward Zone IP Address
if sed -i s/127.0.0.1/$ip/g /etc/bind/$dir/db.$name; then
  echo "Localhost Changed to $domain .."
  sleep 0.5
else
  echo "Error, Check your db.$name"
  sleep 0.5
fi
