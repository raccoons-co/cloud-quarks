#!/bin/sh
# This script is meant for quick & easy install.sh via:
#   $ curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-cdk/install.sh | sudo sh

# Sets shell option "Exit immediately if a command exits with a non-zero status."
set -e

# Returns Linux distribution name String
linuxDistributionName() {
  lsb_dist=""
  if [ -r /etc/os-release ]; then
    # shellcheck disable=SC1091
	  lsb_dist=$(. /etc/os-release && echo "$ID")
  fi
  echo "$lsb_dist"
}

# Returns same String with all letters in lowercase
toLowerCase() {
  tr '[:upper:]' '[:lower:]'
}

# Installs AWS CDK and Maven to AmazonLinux, Debian, macOS.
do_install(){

    currentOsName=$( uname -s | toLowerCase )
    case $currentOsName in
	    linux)
	      lsb_dist=$( linuxDistributionName | toLowerCase )
	      if [ "$lsb_dist" = "ubuntu" ] || [ "$lsb_dist" = "debian" ]; then
	        npm install -g aws-cdk
		      sudo apt-get update
		      sudo apt install maven
		    fi
		    if [ "$lsb_dist" = "amzn" ]; then
		      npm install -g aws-cdk
		      sudo yum -y install maven
		    fi
	      ;;
      darwin)
        brew install aws-cdk maven
	      ;;
    esac
}

# Run installation process.
# Last line in script file to protect during "curl | sh".
do_install
