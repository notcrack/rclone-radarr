#!/bin/bash
# RCLONE UPLOAD & RADARR LIBRARY UPDATE CRON TAB SCRIPT
# chmod a+x rclone-radarr.sh
# */30 * * * * /home/rclone-radarr.sh >/dev/null 2>&1 (you can run script as often as you like, but every 30 minutes is ample for me)
# if you use custom config path add line bellow in line 27 after --log-file=$LOGFILE 
# --config=/path/rclone.conf (config file location)
# change copy to move depending on desired results - Line 27
# you may need to add rclone location (line 27) - to find run "which rclone" for path for something like /usr/bin/rclone 

if pidof -o %PPID -x "$0"; then
   exit 1
fi

LOGFILE="/home/user/scripts/rclone-upload.log"
FROM="/mnt/media/"
TO="gdrive:/media"
RADARRURL="Add URL without http://"
RADARRPORT="Add port"
RADARRAPIKEY="Add apikey"

# CHECK FOR FILES IN FROM FOLDER THAT ARE OLDER THAN 15 MINUTES
if find $FROM* -type f -mmin +15 | read
  then
  start=$(date +'%s')
  echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD STARTED" | tee -a $LOGFILE
  # copy FILES OLDER THAN 15 MINUTES 
  rclone copy "$FROM" "$TO" --transfers=20 --checkers=20 --min-age 15m --log-file=$LOGFILE
  echo "$(date "+%d.%m.%Y %T") RCLONE UPLOAD FINISHED IN $(($(date +'%s') - $start)) SECONDS" | tee -a $LOGFILE
fi
curl "http://$RADARRURL:$RADARRPORT/api/command" -X POST -d "{'name': 'RescanMovie'}" --header "X-Api-Key:$RADARRAPIKEY"
exit
