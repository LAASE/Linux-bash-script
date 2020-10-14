#!/bin/bash
#----------------------------------------------
# All in one installer script by #LASE

# Vars
MACHINE_OS=$(uname -o)
MACHINE_TYPE=$(uname -m)
HOSTNAME=$(hostname -A)
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
MYIP2=$(hostname -i)

VERSION="1.0"
AUTHOR="#LASE"

# Message Color
function greenMSG() {
  echo -e "\\033[32;1m${*}\\033[0m"
}
function redMSG() {
  echo -e "\\033[31;1m${*}\\033[0m"
}
function purpleMSG() {
  echo -e "\\033[35;1m${*}\\033[0m"
}
function cyanMSG() {
  echo -e "\\033[36;1m${*}\\033[0m"
}
function yellowMSG() {
  echo -e "\\033[33;1m${*}\\033[0m"
}
function whiteMSG() {
  echo -e "\\033[37;1m${*}\\033[0m"
}
function errorMSG() {
  redMSG "${@}"
  exit 1
}
function exitMSG() {
  echo
  errorMSG "Bye,visit us again"
}
function errorContinue() {
  redMSG "Invalid option."
  return
}


################################################ Instalation ################################################
#############################################################################################################

clear

# Check if the script was run as root user. Otherwise exit the script
if [ "$(id -u)" != "0" ]; then
  errorMSG "Error - Change to root account!"
fi

sleep 1
greenMSG "	######## ##	##	 ## ##	    ##	  ######## ##	   ##	#######	"
greenMSG "	######## ##	##	 ## ###	    ##	  ######## ###	   ##	#######	"
greenMSG "	##    ## ##	##	 ## ####    ##	  ##	## ####	   ##	##	"
greenMSG "	##    ## ##	##	 ## ## ##   ##	  ##	## ## ##   ##	##	"	 
greenMSG "	######## ##	##	 ## ##  ##  ##	  ##	## ##  ##  ##	#######	"
greenMSG "	##    ## ##	##	 ## ##   ## ##	  ##	## ##   ## ##	##  	"
greenMSG "	##    ## ##     ##	 ## ##    ####	  ##	## ##    ####	##	"
greenMSG "	##    ## ###### #####    ## ##     ###	  ######## ##     ###	#######	"
greenMSG "	##    ## ######	#####    ## ##      ##    ######## ##      ##   #######	"
greenMSG "        ======================================================================= "
greenMSG "                          Version:$VERSION | Author:$AUTHOR"
greenMSG ""
############################################ [Selection menu]
redMSG "Pick your choise"
OPTIONS=("VPS Configuration" "VPS Info" "Program Install" "Program Configuration" "Exit")
select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 ) break;;
  5) exitMSG ;;
  *) errorContinue ;;
  esac
done

if [ "$OPTION" == "VPS Configuration" ]; then
  CONF="VPS"
elif [ "$OPTION" == "Program Install" ]; then
  INSTALL="APP"
elif [ "$OPTION" == "Program Configuration" ]; then
  CONF="APP"
elif [ "$OPTION" == "VPS Info" ]; then
  CONF="VPS_info"
fi

############################################ [VPS Config]
if [ "$CONF" == "VPS" ]; then
  clear
  redMSG "Pick your choise?"
  OPTIONS=("Server Update & Upgrade" "Change Root PW" "Enable Root Login" "Disable Root Login" "Change SSH Port" "Exit")
  select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 | 5 ) break ;;
  6) exitMSG ;;
  *) errorContinue ;;
  esac
  done 

  if [ "$OPTION" == "Server Update & Upgrade" ]; then
  clear
  yellowMSG "Please wait..."
  apt-get update
  apt-get upgrade -y
  yellowMSG "You update & upgrade your Server!"
  redMSG "You will be redirected to main menu in 2 seconds"
  sleep 2
  ./AIOS.sh
  fi

  if [ "$OPTION" == "Change Root PW" ]; then
  clear
  passwd
  yellowMSG "You change your root password!"
  redMSG "You will be redirected to main menu in 2 seconds"
  sleep 2
  ./AIOS.sh
  fi

  if [ "$OPTION" == "Enable Root Login" ]; then
  clear
  sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' proba.txt
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' proba.txt
  echo
  service ssh restart
  yellowMSG "You enable root login"
  redMSG "You will be redirected to main menu in 2 seconds"
  sleep 2
  ./AIOS.sh
  fi

  if [ "$OPTION" == "Disable Root Login" ]; then
  clear
  sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' proba.txt
  sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' proba.txt
  echo
  service ssh restart
  yellowMSG "You disable root login"
  redMSG "You will be redirected to main menu in 2 seconds"
  sleep 2
  ./AIOS.sh
  fi

  if [ "$OPTION" == "Change SSH Port" ]; then
  clear
  read -p "Type your new SSH port: " NEW_PORT
  sed -i "s/#Port.*/Port.*/g" proba.txt
  sed -i "s/Port.*/Port $NEW_PORT/g" proba.txt
  echo
  #service ssh restart
  yellowMSG "You change your SSH port to $NEW_PORT"
  redMSG "You will be redirected to main menu in 2 seconds"
  sleep 2
  ./AIOS.sh
  #echo "SSH PORT CHANGE" > log.txt
  fi

fi
############################################ [VPS Info]
if [ "$CONF" = "VPS_info" ]; then
  clear
  yellowMSG "---------- VPS INFO ----------"
  echo "Machine OS: " $MACHINE_OS
  echo "Machine type: " $MACHINE_TYPE
  echo "External IP: " $MYIP
  echo "Internal IP: " $MYIP2
  echo
  redMSG "You will be redirected to main menu in 5 seconds"
  sleep 5
  ./AIOS.sh
fi
############################################ [APP Install]
if [ "$INSTALL" == "APP" ]; then
  clear
  redMSG "Pick what program do you want to install?"
  OPTIONS=("LAMP" "Test1" "Test2" "Test3" "Exit")
  select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 ) break ;;
  5) exitMSG ;;
  *) errorContinue ;;
  esac
  done 
  
  if [ "$OPTION" == "LAMP" ]; then
  INSTALL="LAMP"
  fi

########### LAMP Install
  if [ "$INSTALL" == "LAMP" ]; then
	clear
	redMSG "Pick what program do you want to install?"
	OPTIONS=("Apache" "MySQL" "PHP" "Exit")
	select OPTION in "${OPTIONS[@]}"; do
	case "$REPLY" in
	1 | 2 | 3 ) break ;;
	4) exitMSG ;;
	*) errorContinue ;;
	esac
	done

	if [ "$OPTION" == "Apache" ]; then
	clear
	apt-get install apache2
	yellowMSG "Apache has been successfully installed"
	echo
	redMSG "You will be redirected to main menu in 2 seconds"
	sleep 2
	./AIOS.sh
	fi 

	if [ "$OPTION" == "MySQL" ]; then
	clear
	apt-get install mysql-server
	yellowMSG "MySQL has been successfully installed"
	echo
	sleep 1
	yellowMSG "Configuring MySQL"
	mysql_secure_installation
	echo
	redMSG "You will be redirected to main menu in 2 seconds"
	sleep 2
	./AIOS.sh
	fi 

	if [ "$OPTION" == "PHP" ]; then
	clear
	apt-get install php libapache2-mod-php
	systemctl restart apache2
	yellowMSG "Installing PHP extensions,please wait..."
	sleep 1
	apt-get install php-mcrypt php-curl php-gd php-common php-mysql php-cli
	yellowMSG "PHP has been successfully installed"
	echo
	redMSG "You will be redirected to main menu in 2 seconds"
	sleep 2
	./AIOS.sh
	fi 
	  
  fi
########### Test Install

fi
############################################ Program Configuration
if [ "$CONF" == "APP" ]; then
  clear
  redMSG "Pick what program do you want to install?"
  OPTIONS=("LAMP" "Test1" "Test2" "Test3" "Exit")
  select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 ) break ;;
  5) exitMSG ;;
  *) errorContinue ;;
  esac
  done 

  if [ "$OPTION" == "LAMP" ]; then
  CONF="LAMP"
  fi
############## LAMP Configuration
  if [ "$CONF" = "LAMP" ]; then
    clear
    redMSG "Pick what program do you want to install?"
    OPTIONS=("Apache" "MySQL" "Exit")
    select OPTION in "${OPTIONS[@]}"; do
    case "$REPLY" in
    1 | 2 ) break ;;
    3) exitMSG ;;
    *) errorContinue ;;
    esac
    done 
  fi

    if [ "$OPTION" == "Apache" ]; then
    clear
    read -p "Do you want to add your site? ([y]/n): "
    echo
    if [ "$REPLY" != "n" ]; then
    read -p "Enter your site name(example: domain.com): " SITE_NAME
    mkdir /var/www/$SITE_NAME
    touch index.html
    echo "This is blank page" > index.html
    mv index.html /var/www/$SITE_NAME
    yellowMSG "You create a folder in /var/www called $SITE_NAME"
    echo
    touch $SITE_NAME.conf
    echo "<VirtualHost *:80>" >> $SITE_NAME.conf
    echo "    ServerAdmin admin@mail.de" >> $SITE_NAME.conf
    echo "    ServerName $SITE_NAME" >> $SITE_NAME.conf 
    echo "    ServerAlias www.$SITE_NAME" >> $SITE_NAME.conf
    echo "    DocumentRoot /var/www/$SITE_NAME" >> $SITE_NAME.conf
    echo "    ErrorLog /var/www/$SITE_NAME/Logs/error.log" >> $SITE_NAME.conf
    echo "    CustomLog /var/www/$SITE_NAME/Logs/access.log combined" >> $SITE_NAME.conf
    echo "</VirtualHost>" >> $SITE_NAME.conf
    mv $SITE_NAME.conf /etc/apache2/sites-available
    echo
    read -p "Do you want to add your site? ([y]/n): "
    if [ "$REPLY" != "n" ]; then
    nano /etc/apache2/sites-available/$SITE_NAME.conf
    echo
    yellowMSG "Site has been successfully added"
    echo
    redMSG "You will be redirected to main menu in 2 seconds"
    sleep 2
    ./AIOS.sh
    fi 
    fi
    fi
############## MySQL Configuration
    if [ "$OPTION" == "MySQL" ]; then
    clear
    read -p "Do you want to change your MySQL password? ([y]/n): "
    echo
    if [ "$REPLY" != "n" ]; then
    read -s -p "Enter your MySQL password " MYSQL_PW
    echo
    read -s -p "Enter your new MySQL password" NEW_MYSQL_PW
    echo
    mysql -u root -p$MYSQL_PW -e " ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_MYSQL_PW';"
    echo
    yellowMSG "MySQL password has been successfully changed"
    echo
    redMSG "You will be redirected to main menu in 2 seconds"
    sleep 2
    ./AIOS.sh
    fi
    fi  
fi


