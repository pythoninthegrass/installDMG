#/bin/sh

# SOURCE:
# http://stackoverflow.com/a/21428907
# Originally created by user zmo
# USAGE:
# $ installDMG.sh ~/Downloads/myApp.dmg
# TODO:
# Error handling for when app already exists in /Applications

loggedInUser=$(ls -l /dev/console | cut -d " " -f 4)
scriptDir=$(cd "$(dirname "$0")" && pwd)
#echo $scriptDir
installLog="/tmp/volume-dmg-install.log"

# volumeMount=$(hdiutil attach "$1" | grep Volumes | awk '{print $3}') #Original
volumeMount=$(hdiutil attach "$1" | ls | grep *.app)
cp -rf "$volumeMount/*.app" /Applications
hdiutil detach $volumeMount

exit 0
