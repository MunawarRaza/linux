#!/bin/bash

CURRENT_DATE=$(date +%Y%m%d)
ORIGINAL_FOLDER_PATH="/opt"
FOLDER_NAME="onezapp"
NEW_FOLDER_PATH="/home/munawar/${FOLDER_NAME}-${CURRENT_DATE}"
DEPLOYMENTS_FOLDER="deployments"
PROFILES_PATH="config/profiles"
IP_MAPPINGS=(
        "10.20.30.28=192.168.30.28"
        "10.20.20.21=192.168.20.21"
        "10.20.20.22=192.168.20.22"
        "10.20.20.23=192.168.20.23"
        "10.20.20.24=192.168.20.24"
        "10.20.20.25=192.168.20.25"
        "10.20.20.26=192.168.20.26"
    )

backup_folder() {
    echo "######### Folder Backup Function #########"
    cp -r "${ORIGINAL_FOLDER_PATH}/${FOLDER_NAME}" "${NEW_FOLDER_PATH}"
}

delete_extra_files() {
    echo "######### Deleting Extra Files #########"

    # Remove extra files in deployments folder
    find "${NEW_FOLDER_PATH}/${DEPLOYMENTS_FOLDER}" -type f \( -name "*.jar-*" -o -name "*.out*" \) -delete

    # Remove extra files in profiles folder
    find "${NEW_FOLDER_PATH}/${PROFILES_PATH}" -type f \( -name "*.properties.*" -o -name "*.properties-*" -o -name "*.yml.*" -o -name "*.yml-*" \) -delete

    echo "## All extra files have been deleted ##"
}

change_profile_in_start_sh() {
    echo "######### Changing Profile in Start.sh #########"
    find "${NEW_FOLDER_PATH}/${DEPLOYMENTS_FOLDER}" -type f -name "start.sh" -exec sed -i \
        -e 's/application-prod.properties/application.properties/g' \
        -e 's/application-prod.properties/application.yml/g' {} +
}

change_property_file_name() {
    echo "######### Change Property File Name #########"

    find "${NEW_FOLDER_PATH}/${PROFILES_PATH}" -type f -name "*-prod.properties" | while read -r file; do
        mv "$file" "${file/-prod/}"
    done
}

change_active_profile_in_properties() {
    echo "######### Change Active Profile #########"

    find "${NEW_FOLDER_PATH}/${DEPLOYMENTS_FOLDER}" -type f \( -name "application.properties" -o -name "application.yml" \) -exec sed -i 's/preprod/prod/g' {} +
}

change_ip() {
    echo "####### Changing IPs #######"

    for folder in "${NEW_FOLDER_PATH}/${PROFILES_PATH}" "${NEW_FOLDER_PATH}/${PROFILES_PATH}/all-profiles"; do
        for mapping in "${IP_MAPPINGS[@]}"; do
            OLD_IP="${mapping%=*}"
            NEW_IP="${mapping#*=}"
            find "$folder" -type f \( -name "*.properties" -o -name "*.yml" \) -exec sed -i "s/$OLD_IP/$NEW_IP/g" {} +
        done
    done
}

# Execute all functions
backup_folder
delete_extra_files
change_profile_in_start_sh
change_property_file_name
change_active_profile_in_properties
change_ip
