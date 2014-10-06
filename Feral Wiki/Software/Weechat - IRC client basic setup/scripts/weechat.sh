#!/bin/bash
# weechat installation
scriptversion="1.1.0"
scriptname="install.weechat"
# randomessence
#
# wget -qO ~/install.weechat.sh http://git.io/L6oalA && bash ~/install.weechat.sh
#
############################
## Version History Starts ##
############################
#
#
############################
### Version History Ends ###
############################
#
############################
###### Variable Start ######
############################
#
weechat="http://weechat.org/files/src/weechat-1.0.1.tar.gz"
weechatfv="1.0.1"
scripturl="https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/Software/Weechat%20-%20IRC%20client%20basic%20setup/scripts/weechat.sh"
#
############################
####### Variable End #######
############################
#
############################
#### Self Updater Start ####
############################
#
mkdir -p "$HOME/bin"
#
if [[ ! -f "$HOME/$scriptname.sh" ]]
then
    wget -qO "$HOME/$scriptname.sh" "$scripturl"
fi
if [[ ! -f "$HOME/bin/$scriptname" ]]
then
    wget -qO "$HOME/bin/$scriptname" "$scripturl"
fi
#
wget -qO "$HOME/000$scriptname.sh" "$scripturl"
#
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/$scriptname.sh" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/111$scriptname.sh"
    bash "$HOME/111$scriptname.sh"
    exit 1
fi
if ! diff -q "$HOME/000$scriptname.sh" "$HOME/bin/$scriptname" > /dev/null 2>&1
then
    echo '#!/bin/bash
    scriptname="'"$scriptname"'"
    wget -qO "$HOME/$scriptname.sh" "'"$scripturl"'"
    wget -qO "$HOME/bin/$scriptname" "'"$scripturl"'"
    bash "$HOME/$scriptname.sh"
    exit 1' > "$HOME/222$scriptname.sh"
    bash "$HOME/222$scriptname.sh"
    exit 1
fi
cd && rm -f {000,111,222}"$scriptname.sh"
chmod -f 700 "$HOME/bin/$scriptname"
#
############################
##### Self Updater End #####
############################
#
############################
#### Core Script Starts ####
############################
#
echo
echo -e "Hello $(whoami), you have the latest version of the" "\033[36m""$scriptname""\e[0m" "script. This script version is:" "\033[31m""$scriptversion""\e[0m"
echo
read -ep "The scripts have been updated, do you wish to continue [y] or exit now [q] : " updatestatus
echo
if [[ "$updatestatus" =~ ^[Yy]$ ]]
then
#
############################
#### User Script Starts ####
############################
#
	if [[ -f "$HOME/bin/cmake" ]]
	then
		wget -qO ~/weechat.tar.gz "$weechat"
		tar xf ~/weechat.tar.gz
		cd ~/weechat-"$weechatfv"
		sed -i 's/set(CMAKE_SKIP_RPATH ON)//g' ~/weechat-"$weechatfv"/CMakeLists.txt
		"$HOME"/bin/cmake -DCMAKE_INSTALL_RPATH=/opt/curl/current/lib -DPREFIX="$HOME" -DCURL_LIBRARY=/opt/curl/current/lib/libcurl.so -DCURL_INCLUDE_DIR=/opt/curl/current/include
		make
		make install
		cd
		rm -rf ~/weechat.tar.gz ~/weechat-"$weechatfv"
		echo
		echo "Done. Continue with the rest of the FAQ to configure weechat"
		echo
	else
		echo "Cmake is not installed. Please Complete Step 1 of the FAQ before running this script"
		echo
	fi
#
############################
##### User Script End  #####
############################
#
else
    echo -e "You chose to exit after updating the scripts."
    echo
    cd && bash
    exit 1
fi
#
############################
##### Core Script Ends #####
############################
#