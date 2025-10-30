#!/bin/bash

set -e

###################################################
####                                           ####
####      POSTGRES DATABASE BACKUP SCRIPT      ####
####                                           ####
###################################################
#
#
#==================================================
# Author: 1-Platform DevOps Team
# Description: 
#       1. Dump the postgres databases which are running in container at defined folder.
#       2. Copy dumped folder from container to local machine
#       3. Remove newly created folder from container
#       4. Copy docker volume which is attached with database container to newly created folder
#       5. Create tar file
#       6. Monitor Disk Space
#       7. Send alert to MS Team channel
#
#==================================================

#==================> VARIABLES <===================#

### CLIENT DETAILS ###
CLIENT_NAME="KHDA"
SERVER_IP="10.13.0.11"

### SCRIPT DETAILS ###
SCRIPT_START_TIME=$(date +"%Y%m%d %T")
CURRENT_DATE=$(date +"%Y%m%d")

### BACKUP LOCATION AND FILES DETAILS ###
#BACKUP_FOLDER_PATH="/opt/oneplatform/backups"
BACKUP_FOLDER_PATH="$(dirname "$(realpath "$0")")"
BACKUP_FOLDER_NAME="onep-database-backup-folder"
NEW_BACKUP_FOLDER_NAME="onep-database-backup-${CURRENT_DATE}"
LOGS_PATH="$(dirname "$(realpath "$0")")/onep-database-backup-script.log"

### CONTAINER DETAILS ###
CONTAINER_NAME="onep-postgres-service"
CONTAINER_VOLUME_NAME="docker_postgres-data"
CONTAINER_VOLUME_LOCATION="/var/lib/docker/volumes/docker_postgres-data"

### DATABASES DETAILS ###
DB_USER_NAME="postgres"

DATABASES_NAME=( "onep_khda_prod" )

### ALET DETAILS ###
WEBHOOK_URL="https://nuevezo.webhook.office.com/webhookb2/e6cf483d-8072-4952-a3ed-31ee22f0488d@9248124e-1e60-45ea-af53-5866f5460227/IncomingWebhook/cabd17e8afcd49b8946b22bd31f96e25/aece39ab-a484-4eb2-8a4e-13c77f224008/V2hqDVC0Mu6eB8G4BQ7VSDzqj_HfYXHAJgmxGvNoJ-V7A1"


#==================> FUNCTIONS <===================#

echo "################## Backup Script Started: ${SCRIPT_START_TIME} ################## "  | tee -a ${LOGS_PATH}

# Create folder to store backup file, if does not exist.
if [ ! -d ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME} ];then
    echo "${BACKUP_FOLDER_NAME} does not exist. Creating ..." | tee -a ${LOGS_PATH}
    mkdir ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME} 2>&1 | tee -a ${LOGS_PATH}
fi

function database_dump {

echo "Invoking (database_dump) function." | tee -a ${LOGS_PATH}
# This function will take dump and copy that from containers to local

# echo "${#DATABASES_NAME[@]}"

# create folder inside the container where dump will be stored 
docker exec ${CONTAINER_NAME} sh -c "mkdir ${NEW_BACKUP_FOLDER_NAME}" 2>&1 | tee -a ${LOGS_PATH}

for i in ${DATABASES_NAME[@]}
do
    echo "Create backup of database: $i" | tee -a ${LOGS_PATH}
    docker exec ${CONTAINER_NAME} sh -c "pg_dump -U '${DB_USER_NAME}' ${i} >${NEW_BACKUP_FOLDER_NAME}/${i}_${CURRENT_DATE}.sql" 2>&1 | tee -a ${LOGS_PATH}
done

    echo "Copy backup data from container to local." | tee -a ${LOGS_PATH}
    docker cp ${CONTAINER_NAME}:/${NEW_BACKUP_FOLDER_NAME} ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}

    echo "Remove extra folder, created in the start of this function, from container." | tee -a ${LOGS_PATH}
    docker exec ${CONTAINER_NAME} sh -c "rm -rf ${NEW_BACKUP_FOLDER_NAME}*"
}

function copy_docker_volume_db_data {

echo "Invoking (copy_docker_volume_db_data) function" | tee -a ${LOGS_PATH}
# This function will copy container's volume data to new path and create tar file of that data

if [ ! -d ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/${NEW_BACKUP_FOLDER_NAME}/${CONTAINER_VOLUME_NAME} ];then
    echo "Create folder for container's volume if does not exist." | tee -a ${LOGS_PATH}
    mkdir ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/${NEW_BACKUP_FOLDER_NAME}/${CONTAINER_VOLUME_NAME} 2>&1 | tee -a ${LOGS_PATH}
fi
    echo "Copy data from docker container to local folder." | tee -a ${LOGS_PATH}
    cp -r ${CONTAINER_VOLUME_LOCATION}/* ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/${NEW_BACKUP_FOLDER_NAME}/${CONTAINER_VOLUME_NAME}/ 2>&1 | tee -a ${LOGS_PATH}
}

function zip_folder {
    echo "Invoking (zip_folder) function" | tee -a ${LOGS_PATH}
#    tar -cvf "$BACKUP_FOLDER_PATH/$BACKUP_FOLDER_NAME/${NEW_BACKUP_FOLDER_NAME}.tar" -C "$BACKUP_FOLDER_PATH/$BACKUP_FOLDER_NAME" "$NEW_BACKUP_FOLDER_NAME"

    cd ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/
    echo "Create tar file of the newly created backup folder" | tee -a ${LOGS_PATH}
    tar -cf ${NEW_BACKUP_FOLDER_NAME}.tar ${NEW_BACKUP_FOLDER_NAME} 2>&1 | tee -a ${LOGS_PATH}
#    sleep 30
    rm -rf ${NEW_BACKUP_FOLDER_NAME}
    FILE_SIZE=$(du -sh ${NEW_BACKUP_FOLDER_NAME}.tar |awk '{print $1}' )
    #cd - 
}

function verification {
  echo "This function will be used to verify whether database backedup or not"
  cd ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/
  FILE_SIZE=$(du -sh ${NEW_BACKUP_FOLDER_NAME}.tar |awk '{print $1}' |tr -d 'G' )
  echo $FILE_SIZE
  if (( $(echo "$FILE_SIZE >= 2" | bc -l) )); then
    echo "Your backup file is is ${FILE_SIZE}G"
  fi
}

# disk monitoring function
function disk_monitoring {
        echo "This function will monitor the disk space of server"
        USED_DISK=$(df -h / --output=used |awk 'FNR == 2 {print $1}')
        AVAILABLE_DISK=$(df -h / --output=avail |awk 'FNR == 2 {print $1}')
        echo "USED DISK: ${USED_DISK}"
        echo "AVAIL DISK: ${AVAILABLE_DISK}"
        echo ${USED_DISK}
        echo ${AVAILABLE_DISK}
}

# Delete previous files
function delete_previous_file {
        echo "This function will delete the previous files of given time"
        find ${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}/ -type f -ctime +20 -exec rm -f {} \; 2>&1 | tee -a ${LOGS_PATH}
        echo "Files which were created 20 days ago are deleted"

}
# Alert Function
function send_alert {
echo "Invoking (send_alert) function" | tee -a ${LOGS_PATH}
SCRIPT_END_TIME=$(date +"%Y%m%d %T")
# echo "Backup Ended: ${SCRIPT_END_TIME}"  | tee -a ${LOGS_PATH}
payload=$(cat <<EOF
{
  "title": "Database Backup Notification",
  "text": "Backup Details",
  "sections": [
    {
      "facts": [
        {
          "name": "Client Name:",
          "value": "${CLIENT_NAME}"
        },
        {
          "name": "DB Server IP",
          "value": "${SERVER_IP}"
        },
        {
          "name": "DB Backup Started At:",
          "value": "${SCRIPT_START_TIME}"
        },
        {
          "name": "DB Backup Ended At:",
          "value": "${SCRIPT_END_TIME}"
        },
        {
          "name": "DB Archived File Path",
          "value": "${BACKUP_FOLDER_PATH}/${BACKUP_FOLDER_NAME}"
        },
        {
          "name": "DB Archived File Name:",
          "value": "${NEW_BACKUP_FOLDER_NAME}.tar"
        },
        {
          "name": "DB Archived File Size:",
          "value": "${FILE_SIZE}"
        },
                {
                  "name": "Server Disk Used:",
                  "value": "${USED_DISK}"
                },
                {
                  "name": "Server Disk Available:",
                  "value": "${AVAILABLE_DISK}"
                }
      ]
    }
  ]
}
EOF
)

echo "Sendingg alert to webhook" | tee -a ${LOGS_PATH}
curl -X POST "$WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "$payload" | tee -a ${LOGS_PATH}
}

# Invoking functions
database_dump
copy_docker_volume_db_data
zip_folder
verification
delete_previous_file
disk_monitoring
send_alert
SCRIPT_END_TIME=$(date +"%Y%m%d %T")
echo "################## Backup Script Ended: ${SCRIPT_END_TIME} ################## "  | tee -a ${LOGS_PATH}