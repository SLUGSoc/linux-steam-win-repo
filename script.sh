#!/bin/bash
#SLUGSoc.co.uk Steam Repo Generator - Tested under Ubuntu 14.04


#Change variables below to match
#AppID For steam game
appid="440"
#Installation Folder
folder="TF2"
#App Manifest Directory
appmandir="1c60c1021a8fb5d5f829b10a1b5b6c6879ebe521"
#SteamCMD directory
steamcmddir="/home/steam/steamcmd/"
#Your own custom zip script for the folder, a parallel version such as pbzip2 is a suggestion.
zipscript="/home/steam/www/zip.sh"
#Linux user this is running under
linuxuser="steam"
#Steam User this is running under, subscriptions are needed for some games. Login SteamCMD manually with the user then put username here and it will use cached details
steamuser="jimmezmoore"


#!!!!Don't edit below this line!!!!

#Check Last update time then execute a steamcmd update
lastupdatesteamcmd=$(cat $folder/$appmandir/appmanifest_$appid.acf | grep "LastUpdated" | sed -e 's/"LastUpdated"//' | sed 's/\"//g')

$steamcmddir/steamcmd.sh +@sSteamCmdForcePlatformType windows +login $steamuser +force_install_dir ../$folder +app_update $appid  +quit

#Get the update time after the update via steamcmd
updatedsteamcmd=$(cat $folder/$appmandir/appmanifest_$appid.acf | grep "LastUpdated" | sed -e 's/"LastUpdated"//' | sed 's/\"//g')

#If the two updatecheck times do not match, execute the zip script then stop. Else do nothing then stop.
if [ $lastupdatesteamcmd == $updatedsteamcmd ]
  then
echo "Would not have rezipped"
echo "Last Updated Time = $lastupdatesteamcmd"
echo "Last Updated Time after check = $updatedsteamcmd"
  else
$zipscript /home/$linuxuser/$folder
echo "Would have rezipped."
echo "Last Updated Time = $lastupdatesteamcmd"
echo "Last Updated Time after check = $updatedsteamcmd"

fi


#echo /home/steam/$folder
#echo $lastupdate
#echo $(date +%s)