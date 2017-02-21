#!/usr/bin/env bash


# Exit upon failed command
# set -e

# Install log
logTime=$(date +%Y-%m-%d:%H:%M:%S)
installLog="/tmp/pkg_install_$logTime.log"
exec &> >(tee -a "$installLog")

# Current user
loggedInUser=$(ls -l /dev/console | cut -d " " -f 4)

# Working directory
scriptDir=$(cd "$(dirname "$0")" && pwd)

# Check for root privileges
if [ $(whoami) != "root" ]; then
    echo "Sorry, you need super user privileges to run this script."
    exit 1
fi

# Set $IFS to eliminate whitespace in pathnames
IFS="$(printf '\n\t')"

# DMG list to iterate through below
dmgArray=($(find "$scriptDir" -maxdepth 1 -name "*.dmg" | awk -F/ '{print $NF}'))
# echo "${dmgArray[@]}"

# Mount DMGs
for a in "${dmgArray[@]}"; do
    yes | /usr/bin/hdiutil attach -noautoopen $a
    echo "$a was mounted successfully."
done

# List mounted volume directories
volumeMount=($(hdiutil info | grep Volumes | cut -f 3))
# echo ${volumeMount[@]}

# List app name
volumeApp=($(find /Volumes/ -maxdepth 2 -name "*.app" | awk -F/ '{print $NF}'))
# echo ${volumeApp[@]}

# Loop through app installs # one dmg works
for APP in "${volumeApp[@]}"; do
    # echo $APP
    [ ! -f /Applications/"$APP" ] && cp -rf /Volumes/*/"$APP" /Applications/
done

# Unmount all DMGs via AppleScript
osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'
osascript -e 'tell application "Finder" to close window 1'

unset IFS

exit 0
