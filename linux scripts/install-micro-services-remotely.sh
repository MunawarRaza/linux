#!/bin/bash
#
#
echo '############ Welcome to MicroService deployment section ############'
echo


#Backup Paths
BD_BACKUP=/home/oneload/jar_backups/oneload-billpayment-discovery/
BG_BACKUP=/home/oneload/jar_backups/oneload-billpayment-gateway/
ZIP_BACKUP=/home/oneload/jar_backups/zipkin-server/
BCS_BACKUP=/home/oneload/jar_backups/billpayment-config-server/
#ZIP_BACKUP
#GS_BACKUP
US_BACKUP=/home/oneload/jar_backups/usermanagement-service/
OTSM_BACKUP=/home/oneload/jar_backups/onelink-token-service-mockservice/
OBSM_BACKUP=/home/oneload/jar_backups/onelink-billpayment-service-mockservice/
NADRA_BACKUP=/home/oneload/jar_backups/nadra-integration-service/
NADRA_BACKUP=/home/oneload/jar_backups/nadra-integration-service/
OBS_BACKUP=/home/oneload/jar_backups/oneload-billpayment-service/
CDS_BACKUP=/home/oneload/jar_backups/commission-and-discount-service/
AS_BACKUP=/home/oneload/jar_backups/accounts_service/
CMS_BACKUP=/home/oneload/jar_backups/customer_management/
ALERT_BACKUP=/home/oneload/jar_backups/onezapp-alert-service/
IBFT_MOCK_BACKUP=/home/oneload/jar_backups/onelink-ibft-service-mock/
IBFT_INTE_BACKUP=/home/oneload/jar_backups/onelink-ibft-integration-service/
IBFT_SRV_BACKUP=/home/oneload/jar_backups/onelink-ibft-service/
LOGIN_BACKUP=/home/oneload/jar_backups/login-service/
EMI_BACKUP=/home/oneload/jar_backups/account-limits-service/
SCS_BACKUP=/home/oneload/jar_backups/support-complaints/
GS_BACKUP=/home/oneload/jar_backups/global-service/
TOKEN_BACKUP=/home/oneload/jar_backups/token-service-mock/


#New Build path
BD_NEW=/home/oneload/MS_Jars/oneload-billpayment-discovery/*.jar
US_NEW=/home/oneload/MS_Jars/oneload-billpayment-gateway/
BG_NEW=/home/oneload/MS_Jars/usermanagement-service/
ZIP_NEW=/home/oneload/MS_Jars/zipkin-server/
BCS_NEW=/home/oneload/MS_Jars/billpayment-config-server/
OTSM_NEW=/home/oneload/MS_Jars/onelink-token-service-mockservice/
OBSM_NEW=/home/oneload/MS_Jars/onelink-billpayment-service-mockservice/
NADRA_NEW=/home/oneload/MS_Jars/nadra-integration-service/
OBS_NEW=/home/oneload/MS_Jars/oneload-billpayment-service/
CDS_NEW=/home/oneload/MS_Jars/commission-and-discount-service/
AS_NEW=/home/oneload/MS_Jars/accounts_service/
CMS_NEW=/home/oneload/MS_Jars/customer_management/
ALERT_NEW=/home/oneload/MS_Jars/onezapp-alert-service/
IBFT_MOCK_NEW=/home/oneload/MS_Jars/onelink-ibft-service-mock/
IBFT_INTE_NEW=/home/oneload/MS_Jars/onelink-ibft-integration-service/
IBFT_SRV_NEW=/home/oneload/MS_Jars/onelink-ibft-service/
LOGIN_NEW=/home/oneload/MS_Jars/login-service/
EMI_NEW=/home/oneload/MS_Jars/account-limits-service/
SCS_NEW=/home/oneload/MS_Jars/support-complaints/
GS_NEW=/home/oneload/MS_Jars/global-service/
TOKEN_NEW=/home/oneload/MS_Jars/token-service-mock/

#Deployed service path
BD=/opt/oneload/microservice_build/deployed_jars/oneload-billpayment-discovery/
BG_CURRENT=/opt/oneload/microservice_build/deployed_jars/oneload-billpayment-gateway/
US_CURRENT=/opt/oneload/microservice_build/deployed_jars/usermanagement-service/
ZIP_CURRENT=/opt/oneload/microservice_build/deployed_jars/zipkin-server/
BCS_CURRENT=/opt/oneload/microservice_build/deployed_jars/billpayment-config-server/
OTSM_CURRENT=/opt/oneload/microservice_build/deployed_jars/onelink-token-service-mockservice/
OBSM_CURRENT=/opt/oneload/microservice_build/deployed_jars/onelink-billpayment-service-mockservice/
NADRA_CURRENT=/opt/oneload/microservice_build/deployed_jars/nadra-integration-service/
OBS_CURRENT=/opt/oneload/microservice_build/deployed_jars/oneload-billpayment-service/
CDS_CURRENT=/opt/oneload/microservice_build/deployed_jars/commission-and-discount-service/
AS_CURRENT=/opt/oneload/microservice_build/deployed_jars/accounts_service/
CMS_CURRENT=/opt/oneload/microservice_build/deployed_jars/customer_management/
ALERT_CURRENT=/opt/oneload/microservice_build/deployed_jars/onezapp-alert-service/
IBFT_MOCK_CURRENT=/opt/oneload/microservice_build/deployed_jars/onelink-ibft-service-mock/
IBFT_INTE_CURRENT=/opt/oneload/microservice_build/deployed_jars/onelink-ibft-integration-service/
IBFT_SRV_CURRENT=/opt/oneload/microservice_build/deployed_jars/onelink-ibft-service/
LOGIN_CURRENT=/opt/oneload/microservice_build/deployed_jars/login-service/
EMI_CURRENT=/opt/oneload/microservice_build/deployed_jars/account-limits-service/
SCS_CURRENT=/opt/oneload/microservice_build/deployed_jars/support-complaints/
GS_CURRENT=/opt/oneload/microservice_build/deployed_jars/global-service/
TOKEN_CURRENT=/opt/oneload/microservice_build/deployed_jars/token-service-mock/


global-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep global-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $GS_CURRENT/global-service.jar $GS_BACKUP/global-service.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $GS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $GS_NEW/*.jar $GS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $GS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}

token-service-mock(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep token-service-mock-0.0.1-SNAPSHOT |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $TOKEN_CURRENT/token-service-mock-0.0.1-SNAPSHOT.jar $TOKEN_BACKUP/token-service-mock-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $TOKEN_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $TOKEN_NEW/*.jar $TOKEN_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $TOKEN_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"
fi	
}

support-complaints(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep support-complaints |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $SCS_CURRENT/support-complaints-service-1.0.0.jar $SCS_BACKUP/support-complaints-service-1.0.0.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $SCS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $SCS_NEW/*.jar $SCS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $SCS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


emi-balance-consumption(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep emi-balance-consumption |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $EMI_CURRENT/emi-balance-consumption-limit-service-1.0.0.jar $EMI_BACKUP/emi-balance-consumption-limit-service-1.0.0.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $EMI_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $EMI_NEW/*.jar $EMI_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $EMI_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



OnezappLoggingService(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep OnezappLoggingService |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $LOGIN_CURRENT/OnezappLoggingService-1.0.0.jar $LOGIN_BACKUP/OnezappLoggingService-1.0.0.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $LOGIN_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $LOGIN_NEW/*.jar $LOGIN_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $LOGIN_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


onelink-ibft-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onelink-ibft-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $IBFT_SRV_CURRENT/onelink-ibft-service.jar $IBFT_SRV_BACKUP/onelink-ibft-service.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $IBFT_SRV_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $IBFT_SRV_NEW/*.jar $IBFT_SRV_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $IBFT_SRV_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



onelink-ibft-integration(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onelink-ibft-integration-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $IBFT_INTE_CURRENT/onelink-ibft-integration-service.jar $IBFT_INTE_BACKUP/onelink-ibft-integration-service.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $IBFT_INTE_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $IBFT_INTE_NEW/*.jar $IBFT_INTE_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $IBFT_INTE_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}

onelink-ibft-service-mock(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onelink-ibft-service-mock |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $IBFT_MOCK_CURRENT/onelink-ibft-service-mock-0.0.1-SNAPSHOT.jar $IBFT_MOCK_BACKUP/onelink-ibft-service-mock-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $IBFT_MOCK_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $IBFT_MOCK_NEW/*.jar $IBFT_MOCK_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $IBFT_MOCK_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



onezapp-alert-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onezapp-alert-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $ALERT_CURRENT/conezapp-alert-service-0.0.1-SNAPSHOT.jar $ALERT_BACKUP/onezapp-alert-service-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $ALERT_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $ALERT_NEW/*.jar $ALERT_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $ALERT_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


customermanagement(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep customermanagement-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $CMS_CURRENT/customermanagement-service-0.0.1-SNAPSHOT.jar $CMS_BACKUP/customermanagement-service-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $CMS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $CMS_NEW/*.jar $CMS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $CMS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



accounts-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep accounts-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $AS_CURRENT/accounts-service-0.0.1-SNAPSHOT.jar $AS_BACKUP/accounts-service-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $AS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $AS_NEW/*.jar $AS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $AS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}

commissiondiscountservice(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep commissiondiscountservice |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $CDS_CURRENT/commissiondiscountservice-1.0.0.jar $CDS_BACKUP/commissiondiscountservice-1.0.0.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $CDS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $CDS_NEW/*.jar $CDS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $CDS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



oneload-billpayment-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep oneload-billpayment-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $OBS_CURRENT/oneload-billpayment-service.jar $OBS_BACKUP/oneload-billpayment-service.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $OBS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $OBS_NEW/*.jar $OBS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $OBS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



nadra-integration-service(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep nadra-integration-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $NADRA_CURRENT/nadra-integration-service.jar $NADRA_BACKUP/nadra-integration-service.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $NADRA_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $NADRA_NEW/*.jar $NADRA_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $NADRA_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


onlink-billpayment-service-mockservice(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onlink-token-service-mockservice |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $OBSM_CURRENT/onlink-billpayment-service-mockservice-0.0.1-SNAPSHOT.jar $OBSM_BACKUP/onlink-billpayment-service-mockservice-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $OBSM_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $OTSM_NEW/*.jar $OBSM_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $OBSM_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



onlink-token-service-mockservice(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep onlink-token-service-mockservice |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $OTSM_CURRENT/onlink-token-service-mockservice-0.0.1-SNAPSHOT.jar $OTSM_BACKUP/onlink-token-service-mockservice-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $OTSM_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $OTSM_NEW/*.jar $OTSM_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $OTSM_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


billpayment-config-server(){
echo "############################## Welcome to Billpayment Config Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep billpayment-config-server |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $BCS_CURRENT/billpayment-config-server.jar $BCS_BACKUP/billpayment-config-server.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $BCS_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $BCS_NEW/*.jar $BCS_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $BCS_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


zipkin(){
echo "############################## Welcome to ZIPKIN Server Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep zipkin-server |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $ZIP_CURRENT/zipkin-server-0.0.1-SNAPSHOT.jar $ZIP_BACKUP/zipkin-server-0.0.1-SNAPSHOT.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $ZIP_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $ZIP_NEW/*.jar $ZIP_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $ZIP_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



billpayment-gateway(){
echo "############################## Welcome to Billpayment Gateway Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep oneload-billpayment-gateway |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			kill -9 $P_ID
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $BG_CURRENT/oneload-billpayment-gateway.jar $BG_BACKUP/oneload-billpayment-gateway.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $BG_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $BG_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $BG_NEW/*.jar $BG_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $BG_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}



usermanagement-service(){
echo "############################## Welcome to Usermanagement Service Deployment ##############################"
echo
	P_ID=$(ps -ef |grep java |grep usermanagement-service |awk '{print $2}')
	
	if [[ -n $P_ID  ]];
	then
			echo "############################## Your service is running with process ID: "$P_ID
			KILLING=$(kill -9 $P_ID)
		#	echo "############################## Taking backup of your current directory ##############################"
			mv $US_CURRENT/usermanagement-service-1.0.0.jar $US_BACKUP/usermanagement-service-1.0.0.jar_$(date "+%Y.%m.%d-%H.%M.%S")
		#	rm -rf $US_CURRENT/*.jar
			echo "############################## Changing permissions of build ##############################"
			chown -R root:root $US_NEW/*.jar
			echo "############################## Copying new build ##############################"
			cp $US_NEW/*.jar $US_CURRENT
			echo "############################## Starting deployed service ##############################"
			cd $US_CURRENT && nohup ./start.sh & 
			echo "############################## Service deployed successfully. Please wait 20 seconds ##############################"
			#sleep 20
			#tail -n200 $US_CURRENT/nohup.out
			#sleep 5
	else 
			echo "This service does not exists. Please deploy manually"

fi	
}


echo '############ Kindly select your service to be deployed ############'
echo
echo "1)-------billpayment-discovery"
echo "2)       billpayment-gateway"
echo "3)       billpayment-discovery"
echo "4)       zipkin"
echo "5)       billpayment-config-server"
echo "6)       global-service"
echo "7)       token-service-mock"
echo "8)       onlink-token-service-mockservice"
echo "9)       onlink-billpayment-service-mockservice"
echo "10)      nadra-integration-service"
echo "11)      oneload-billpayment-service"
echo "12)      commissiondiscountservice"
echo "13)      accounts-service"
echo "14)      customermanagement"
echo "15)      onezapp-alert-service"
echo "16)      onelink-ibft-service-mock"
echo "17)      onelink-ibft-integration"
echo "18)      onelink-ibft-service"
echo "19)      OnezappLoggingService"
echo "20)      emi-balance-consumption"
echo "21)      usermanagement-service"
echo "22)      accounts-service"
echo "23)      support-complaints"
echo

read -p "Enter Service Number:  " SERVICE_NUMBER
#FRUIT="kiwi"

case "${SERVICE_NUMBER}" in

1) billpayment-discovery
;;
2) billpayment-gateway
;;
3) billpayment-discovery
;;
4) zipkin
;;
5) billpayment-config-server
;;
6) global-service
;;
7) token-service-mock
;;
8) onlink-token-service-mockservice
;;
9) onlink-billpayment-service-mockservice
;;
10) nadra-integration-service
;;
11) oneload-billpayment-service
;;
12) commissiondiscountservice
;;
13) accounts-service
;;
14) customermanagement
;;
15) onezapp-alert-service
;;
16) onelink-ibft-service-mock
;;
17) onelink-ibft-integration
;;
18) onelink-ibft-service
;;
19) OnezappLoggingService
;;
20) emi-balance-consumption
;;
21) usermanagement-service
;;
22) support-complaints
;;

esac


