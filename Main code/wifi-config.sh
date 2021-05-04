#!/bin/bash


#adding help to guide through the process 
help() {
	echo
	echo '--------------------------------------------------------'
	echo
	echo 'this script adds wifi configuration to your raspberry pi '
	echo 
	echo '-h for ======> help'
	echo '-a for ======> adding wifi configuration'
	echo
	echo '--------------------------------------------------------'
	echo
}


#else condition for get opts 
elsey() {
	echo 
	echo "the command ${OPTION} you entered does not exist"
	echo
	echo 'type -h for help'
	exit 1
}


#adding wifi config whilst taking input from user 
getConfig() {
read -p 'enter the name of your wifi : ' WIFINAME

echo 

echo "The name of your wifi is ${WIFINAME}"

echo 

read -s -p 'enter the password for ' WIFIPASS 

echo

echo "password added successfully"

echo 

read -p 'enter the type of security mode your wifi has ' WIFIMODE

echo 

echo "your wifi has ${WIFIMODE} mode of security"

echo

sleep 2s

echo "adding details .. "

sleep 3s

echo 
echo "reboot your machine to check if wifi is connected successfully"

echo 'network={' 1>> write-file.txt

echo "	ssid="${WIFINAME}"" 1>> write-file.txt
echo " 	psk="${WIFIPASS}"" 1>> write-file.txt
echo " 	key_mgnt=${WIFIMODE}" 1>> write-file.txt

echo '}' 1>> write-file.txt

}


while getopts tha OPTION
do
	case "${OPTION}" in 
		t)
			echo 'testing'
			;;
		h)
			HELP='true' 
			;;
		a)	
			ADD='true'
			;;
		?)
			elsey 
esac
done



if [[ "${HELP}" = 'true' ]]
then 
	help
	exit 0
fi

if [[ "${ADD}" = 'true' ]]
then 
	getConfig
	exit 0
fi 