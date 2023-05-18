#!/bin/sh

LOG_FILE=/tmp/TopSAP_PreInstall.log

timenow=$(date)
echo "${timenow} Ready to Stop TopSAP" > ${LOG_FILE}

user=$(who|head -1|awk '{printf $1}')
echo "${timenow} launchctl unload com.topsec.vpn.TopCAImport" >> ${LOG_FILE}
su ${user} -c "launchctl unload -w /Users/'${user}'/Library/LaunchAgents/com.topsec.vpn.TopCAImport.plist" >> ${LOG_FILE} 2>&1

echo "${timenow} rm com.topsec.vpn.TopCAImport.plist" >> ${LOG_FILE}
rm /Users/${user}/Library/LaunchAgents/com.topsec.vpn.TopCAImport.plist >> ${LOG_FILE} 2>&1

echo "${timenow} launchctl unload -w com.topsec.vpn.TopServ" >> ${LOG_FILE}
sudo launchctl unload -w /Library/LaunchDaemons/com.topsec.vpn.TopServ.plist >> ${LOG_FILE} 2>&1

echo "${timenow} rm com.topsec.vpn.TopServ.plist" >> ${LOG_FILE}
sudo rm /Library/LaunchDaemons/com.topsec.vpn.TopServ.plist >> ${LOG_FILE} 2>&1

echo "${timenow} launchctl unload -w com.topsec.vpn.topsrv" >> ${LOG_FILE}
sudo launchctl unload /Library/LaunchDaemons/com.topsec.vpn.topsrv.plist >> ${LOG_FILE} 2>&1

echo "${timenow} rm com.topsec.vpn.topsrv.plist" >> ${LOG_FILE}
sudo rm /Library/LaunchDaemons/com.topsec.vpn.topsrv.plist >> ${LOG_FILE} 2>&1

echo "${timenow} pkill TopCAImport" >> ${LOG_FILE}
sudo pkill -9 TopCAImport >> ${LOG_FILE} 2>&1

echo "${timenow} pkill TopSAP" >> ${LOG_FILE}
sudo pkill -9 TopSAP >> ${LOG_FILE} 2>&1

echo "${timenow} pkill TopServ" >> ${LOG_FILE}
sudo pkill -9 TopServ >> ${LOG_FILE} 2>&1

echo "${timenow} pkill TopTray" >> ${LOG_FILE}
sudo pkill -9 TopTray >> ${LOG_FILE} 2>&1

sudo spctl --master-disable

echo "${timenow} rm -rf TopSAP.app" >> ${LOG_FILE}
rm -rf /Applications/TopSAP.app >> ${LOG_FILE} 2>&1

echo "${timenow} clear log" >> ${LOG_FILE}
rm -rf /tmp/TopSAP.log* >> ${LOG_FILE} 2>&1

