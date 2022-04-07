#!/bin/bash

set -o pipefail

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo
echo -e "${GREEN}dismod and pecl/apt smbclient uninstall${NC}"
echo

phpdismod smbclient
echo '' | pecl uninstall smbclient
apt -y purge smbclient

echo
echo -e "${GREEN}load bootstrap${NC}"
echo

../bootstrap.sh

echo
echo -e "${GREEN}prepare environment${NC}"
echo

# apt install build-essential
# apt install libc6=2.31-0ubuntu9.2
apt -y install php7.4-dev

echo
echo -e "${GREEN}samba compile${NC}"
echo

../compile_samba.sh

echo
echo -e "${GREEN}samba make${NC}"
echo

"$(make -j 4)"

echo
echo -e "${GREEN}samba install${NC}"
echo

"$(make install -j 4)"

echo
echo -e "${GREEN}install pecl smbclient${NC}"
echo

"$(pecl channel-update pecl.php.net)"
echo '' | pecl install smbclient

echo
echo -e "${GREEN}enmod smbclient${NC}"
echo

phpenmod smbclient
