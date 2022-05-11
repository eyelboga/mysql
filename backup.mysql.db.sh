#!/bin/bash
echo "starting..."
timestamp=$(date +%Y%m%d-%H%M-%S)
sourcepath="/home/......./public_html"
dbuser="dbuser_here"
dbpass="dbpass_here"
dbname="dbname_here"
backuppath="/home/......./backups"
dbhost="localhost"
echo $timestamp
tar -czf $backuppath/backup-filesystem-$timestamp.tar.gz  $sourcepath
mysqldump --host=$dbhost --user=$dbuser --password=$dbpass --databases $dbname > $backuppath/backup-db-$timestamp.sql
echo "finished"
