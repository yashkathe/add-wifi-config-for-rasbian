import os
import subprocess
import sys
import tempfile
import time
import argparse

# don't allow user to run as sudo
if os.geteuid == 0:
    print('Don\'t run the script as sudo')

# check if wpa_supplicant.conf exists
conf_path = '/etc/wpa_supplicant/wpa_supplicant.conf'
conf_file = os.path.basename(conf_path)

# if it exists take a backup of the original file
if os.path.isfile(conf_path):
    print('backup of original {} is stored in \'/home/{}\''.format(conf_file, os.getlogin()))
    
    src = conf_path
    dst = '/home/{}/copy_of_{}'.format(os.getlogin(), conf_file)

    try:
        with open(src, 'r') as rf:
            with open(dst, 'w') as wf:
                for line in rf:
                    wf.write(line)
    
    except Exception as e:
        print('Encountered an error\n {}'.format(e))
        sys.exit(1)

    else:
        print('successfully saved a backup of {} file\n'.format(conf_file))

# if it doesn't exist, create a new wpa_supplicant.conf
else:
    print('{} does not exist\n'.format(conf_file))    
    print('creating new config file')
    try:
        os.chdir((os.path.dirname(conf_path)))
        touch = subprocess.run('sudo touch {}'.format(os.path.basename(conf_path)) ,shell=True, check=True, text=True, capture_output=True)

        if touch.returncode != 0:
            raise Exception(touch.stderr)

    except Exception as e:
        print('Encountered an error\n {}'.format(e))
        sys.exit(1)

    else:
        print('successully created a new blank file\n')


# take user inputs - change this to use argparse
country_code = 'US'
wifi_name = 'abcd'
wifi_psk = 'psk'

# start writing to file - use either of the conf file
lines = [
    'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev',
    'update_config=1',
    'country={}'.format(country_code.strip()),
    'network={',
    'ssid="{}".'.format(wifi_name),
    'psk="{}"'.format(wifi_psk),
    '}'
]

lines_2 = [
    'country={}'.format(country_code.strip()),
    'update_config=1',
    'ctrl_interface=/var/run/wpa_supplicant',
    'network={',
    'scan_ssid=1',
    'ssid="{}".'.format(wifi_name),
    'psk="{}"'.format(wifi_psk),
    '}'
]

try:

    os.chdir('/home/{}'.format(os.getlogin()))

    with open('wpa_supplicant.conf', 'w') as wf:

        for line in lines:
            wf.write(line + '\n')
        
    cmd = subprocess.run('sudo mv /home/{}/wpa_supplicant.conf {}'.format(os.getlogin(), os.path.dirname(conf_path)), shell=True, check=True, text=True)
    
    if cmd.returncode != 0:
       raise Exception(cmd.stderr)

except Exception as e:
    print('Encountered an error\n {}'.format(e))
    sys.exit(1)

else:
    print('successfully wrote new wifi configuration\n')

# reload the network service
try:
    cmd = subprocess.run( 'sudo wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0', shell=True, capture_output=True, text=True, check=True)
    print(cmd.stdout)

    if cmd.returncode != 0:
        raise Exception(cmd.stderr)

except Exception as e:
    print('Encountered an error\n {}'.format(e))
    sys.exit(1)

else:
    print('Successfully reloaded the network serice')
    print('WiFi should be connected now\n')