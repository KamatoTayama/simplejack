#!/bin/bash

# This script is made to run in the root directory.
# There are no 'sudo' prefixes as this was tested in Kali Linux.
# For other distro's the script might need to be modified.


GRN='\033[0;32m'
NC='\033[0m'
YEL='\x1B[33m'

printf "${GRN}--This is a simple MouseJack setup script--\n"


printf "${GRN}Making MouseJack/ dir...\n${NC}"
mkdir test/
cd test/

printf "${GRN}Cloning mouejack GitHub...\n${NC}"
git clone https://github.com/BastilleResearch/mousejack.git

printf "${GRN}Installing additional packages...\n${NC}"
apt install sdcc binutils python python-pip -y
pip install -U pip
pip install -U -I pyusb
pip install -U platformio

printf "${GRN}Init git submodule...\n${NC}"
cd mousejack/
git submodule init
git submodule update

printf "${GRN}Building firmware...\n${NC}"
cd nrf-research-firmware/
make
ls -l

printf "${GRN}You should be able to run the scripts under mousejack/tools/\n ${NC}"

printf "${GRN}Downloading and setting up Jackit........... \n ${NC}"
cd
cd test/
git clone https://github.com/insecurityofthings/jackit.git
cd jackit/
pip install -e .

printf "${GRN}To flash the device: go to mousejack/nrf-research-firmware/ and use 'make install' \n ${NC}"

printf "${GRN}To launch Jackit type 'jackit --script your-ducky-script.txt'\n ${NC}"
printf "${YEL}--------------If you get an error while launching Jackit, please re-insert your flashed device!----------------\n ${NC}"
