#!/bin/bash


#adding help to guide through the process 
help() {
	echo '--------------------------------------------------------'
	echo
	echo 'this script adds wifi configuration to your raspberry pi '
	echo 
	echo '-h for ======> help'
	echo '-a for ======> adding wifi configuration'
	echo
	echo '--------------------------------------------------------'
}

#else condition for get opts 
elsey() {
	echo 
	echo "the command ${OPTION} you entered does not exist"
	echo
	echo 'type -h for help'
}

#adding wifi config whilst taking input from user 


while getopts tha: OPTION
do
case "${OPTION}" in 
	t)
		echo 'testing'
		;;
	h)
		help 
		;;
	a)	
		echo 'skeleton --'
		;;
	?)
		elsey 
esac
done