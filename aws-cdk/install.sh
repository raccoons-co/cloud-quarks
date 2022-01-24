#!/bin/sh
set -e

# This script is meant for quick & easy install.sh via:
#   $ curl -fsSL https://raw.githubusercontent.com/raccoons-co/cloud-quarks/main/aws-cdk/install | sudo sh
get_distribution() {
  lsb_dist=""
  if [ -r /etc/os-release ]; then
	  lsb_dist=$(. /etc/os-release && echo "$ID")
  fi
    echo $lsb_dist
}

toLowerCase() {
  tr '[:upper:]' '[:lower:]'
}

do_install(){

    os=$( uname -s | toLowerCase )
    case $os in
	    linux)
	      lsb_dist=$( get_distribution | toLowerCase )
	      if [ "$lsb_dist" = "ubuntu" ] || [ "$lsb_dist" = "debian" ]; then
	        npm install -g aws-cdk
		      sudo apt-get update
		      sudo apt install maven
		    fi
		    if [ "$lsb_dist" = "amzn"]; then
		      sudo yum -y install maven
		    fi
	      ;;
      darwin)
        brew install aws-cdk maven
	      ;;
    esac
    sh_c='sh -c'
}

do_install
