# rclone-radarr
A small script to automate rclone transfers and radarr library updates

I needed a script that would transfer any downloads with rclone and would then update mt Radarr library. 
This can be useful when used alongside - Unmonitor Deleted Movies - in Radarr. 
You must set your rclone command to move to utilise it though. 

When the script is activated it will move, or copy, the files located in the FROM directory to the TO directory while logging to the LOGFILE when it started. 
Once the move/copy is complete it will log the completion time and duration. 
It will then run the library update to Radarr and this is will unmonitor the movies that have been moved. 

If you want to go the extra step and delete the movies from Radarr you can add

`curl "http://$RADARRIP:$RADARRPORT/api/movie/$radarr_movie_id" -X GET -H "X-Api-Key: $RADARRAPIKEY"`
`curl "http://$RADARRIP:$RADARRPORT/api/movie/$radarr_movie_id" -X DELETE -H "X-Api-Key: $RADARRAPIKEY"`

beneath the original curl command on line 30
