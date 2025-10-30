#!/bin/bash

# This will be used to create the Users

add_user(){
echo
echo "####### Welcome to User Creation Dashboard #######"
echo
read -p "Enter the User Name:  " USER_NAME

read -sp "Enter the Password: " PASSWORD
echo
#echo "You have typed the ${PASSWORD} for ${USER_NAME}"

EXIST_USER=$(cat /etc/passwd |grep ${USER_NAME} |cut -d":" -f1)

if [[ "${USER_NAME}" == "${EXIST_USER}" ]] 
then
        echo
        echo "######## This user already exists. Please chose another user ########"
        echo
        #exit 1
else
        echo
        echo "######## This user does not exists we are creating the user ########"
        echo
        useradd ${USER_NAME} >/dev/null
        echo ${PASSWORD} | passwd --stdin ${USER_NAME} >/dev/null
        usermod -aG wheel ${USER_NAME} >/dev/null
        passwd --expire ${USER_NAME} >/dev/null
        echo "Your ${USER_NAME} successfuly created"
fi
}

delete_user() {
echo 
echo "####### Welcome to User deletion Dashboard #######"
echo 
read -p "Enter the User Name: " USER_NAME
EXIST_USER=$(cat /etc/passwd |grep ${USER_NAME} |cut -d":" -f1)
USER_DIR=$(ls -d /home/${EXIST_USER})
if [[  "${USER_NAME}" == "${EXIST_USER}" ]]
then 
        echo
        echo "######## This user exists. We are deleteing. ########"
        userdel ${USER_NAME}
        #echo "user directory also exists: ${USER_DIR}"
        rm -rf ${USER_DIR}
        echo "User has been deleted"
else 
        echo
        echo "######## This user does not exists ########"
        echo
fi
}

echo
echo "To Create user Enter: 1"
echo "To Delete user Enter: 2"
echo
read -p "Select Your option: " option1

case "${option1}" in

1) add_user
;;

2) delete_user
;;
3|4|5|6|7|8|9|10|0) echo "you have entered an incorrect value"
;;
esac