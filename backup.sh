#! /bin/bash

#Dir with the passwords
BACKUP_DIR="/var/secure/passwords"
#Dir where the backup will be stored
DEST_DIR="/backups"

#Verify that the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR does not exist."
    exit 1
fi
#Verify that the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    echo "Destination directory $DEST_DIR does not exist."
    exit 1
fi

#Time stamp for the backup
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

#Search for files in the backup directory
FILES_TO_BACKUP=$(find "$BACKUP_DIR" -type f -name "*.enc" -mtime -1)

#Verify that there are files to backup
if [ -z "$FILES_TO_BACKUP" ]; then
    echo "No files to backup."
    exit 0
fi
#Create the compressed tar file 

tar -czvf "$DEST_DIR/backup-$TIMESTAMP.tar.gz" $FILES_TO_BACKUP

#Verify that the tar file was created
if [ $? -ne 0 ]; then
    echo "Error creating backup file."
    exit 1
fi