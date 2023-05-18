#!/bin/sh

LOG_FILE=/tmp/TopSAP_PostInstall.log

timenow=$(date)
echo "${timenow} Ready TopSAP" > ${LOG_FILE}

user=$(who|head -1|awk '{printf $1}')

echo "${timenow} Start TopCAImport" >> ${LOG_FILE}
su ${user} -c "mkdir -p /Users/'${user}'/Library/LaunchAgents" >> ${LOG_FILE} 2>&1
cp /Applications/TopSAP.app/Contents/Script/com.topsec.vpn.TopCAImport.plist /Users/${user}/Library/LaunchAgents/ 2>&1
su ${user} -c "launchctl load -w /Users/'${user}'/Library/LaunchAgents/com.topsec.vpn.TopCAImport.plist" >> ${LOG_FILE} 2>&1
if [ $? != 0 ] ; then
exit 1;
fi

echo "${timenow} cp user.js" >> ${LOG_FILE}
su ${user} -c "mkdir -p /Users/${user}/Library/Application\ Support/Firefox/Profiles/mu1pd6cq.default" >> ${LOG_FILE} 2>&1
cp /Applications/TopSAP.app/Contents/Script/user.js /Users/${user}/Library/Application\ Support/Firefox/Profiles/mu1pd6cq.default/
if [ $? != 0 ] ; then
echo "${timenow} Firefox dir is not exist!" >> ${LOG_FILE}
fi


echo "${timenow} Start topsrv" >> ${LOG_FILE}
cp /Applications/TopSAP.app/Contents/Script/com.topsec.vpn.TopServ.plist /Library/LaunchDaemons/ 2>&1
launchctl load -w /Library/LaunchDaemons/com.topsec.vpn.TopServ.plist >> ${LOG_FILE} 2>&1
if [ $? != 0 ] ; then
exit 1;
fi
