#!/bin/bash 

#Run this function when wrong parameter is passed 

non_zero_exit() {
    echo
    echo "The paramter you entered is wrong" 
    echo "use --add while calling the script to add your wifi config"
    echo 'or'
    echo "use --help "
    echo
}

#Run this function when user wants to add wifi config

add_wifi() {
    read -p "Enter the name of your wifi : " WIFI_NAME

    read -s -p "Enter the password of your wifi" WIFI_PASS

    read -p "Enter the security mode of your wifi" WIFI_SEC

    touch /etc/wpa_supplicant/wpa_supplicant. conf

    echo 'network={' 1>>/etc/wpa_supplicant/wpa_supplicant.conf

    echo "  ssid="${WIFI_NAME}"" 1>>/etc/wpa_supplicant/wpa_supplicant.conf

    echo "  psk="${WIFI_PASS}"" 1>>/etc/wpa_supplicant/wpa_supplicant.conf

    echo "  key_mgnt="${WIFI_SEC}"" 1>>/etc/wpa_supplicant/wpa_supplicant.conf

    echo '}' 1>>/etc/wpa_supplicant/wpa_supplicant.conf 

}

#Run this code when user asks for help

help_func(){
    echo 'help'
}


case "${1}" in 
    --help)
        help_func
        ;;
    --add)
        add_wifi
        ;;
    *)
        non_zero_exit
        exit 1
        ;;
esac