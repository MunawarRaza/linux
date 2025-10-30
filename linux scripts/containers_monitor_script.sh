#!/bin/bash

#==================> VARIABLES <===================#

### CLIENT DETAILS ###
CLIENT_NAME="AAAID"
SERVER_IP="172.16.140.211"

### ALERT DETAILS ###
WEBHOOK_URL="https://nuevezo.webhook.office.com/webhookb2/e6cf483d-8072-4952-a3ed-31ee22f0488d@9248124e-1e60-45ea-af53-5866f5460227/IncomingWebhook/de6f523eb1344dd6bbe962dad1cb3314/aece39ab-a484-4eb2-8a4e-13c77f224008/V22E9W-ZYvm1-AzExxvsAwX9FbluVlNLkvxjJ6MYR4l3g1"

# Initialize variables
CURRENT_TIME=$(date +%s)  # Current time in seconds since the epoch
TIME_PERIOD=$((CURRENT_TIME - 300))
CONTAINER_ALERTS=""

# Logs path
LOGS_PATH="$(dirname "$(realpath "$0")")/onep-containers-monitoring-script.log"

echo "########### Script Has been started at ${CURRENT_TIME} ###########" | tee -a ${LOGS_PATH}

check_container_restart_time(){
# Loop through all running containers
while read -r CONTAINER_NAME; do

    # Get the container's restart count and last restart time
    RESTART_COUNT=$(docker inspect --format='{{.RestartCount}}' "$CONTAINER_NAME" 2>/dev/null || echo "0") 
    LAST_RESTART=$(docker inspect --format='{{.State.StartedAt}}' "$CONTAINER_NAME" 2>/dev/null || echo "") 

    # Convert last restart time to a Unix timestamp in local time
    if [[ -n "$LAST_RESTART" ]]; then
        LAST_RESTART_TIMESTAMP=$(date -d "$LAST_RESTART" +%s 2>/dev/null || echo "0") 
    else
        LAST_RESTART_TIMESTAMP=0
    fi

    # Check if the restart happened within the last 5 minutes
    if [[ $LAST_RESTART_TIMESTAMP -ge $TIME_PERIOD ]]; then
        # Convert the timestamp to a human-readable local time format
        LAST_RESTART_LOCAL=$(date -d "@$LAST_RESTART_TIMESTAMP" +"%Y-%m-%d %T")
        CONTAINER_ALERTS+="- $CONTAINER_NAME (Restarts: $RESTART_COUNT) (Last Restart at: ${LAST_RESTART_LOCAL})\n" 
    fi
    echo "${CONTAINER_ALERTS}"

done < <(docker ps --format "{{.Names}}")

}

send_alert(){
# Send alert if there are any restarted containers
if [[ -n "$CONTAINER_ALERTS" ]]; then
    payload=$(cat <<EOF
{
  "title": "Container Restart Alert",
  "text": "The following containers have restarted within the last 5 minutes:",
  "sections": [
    {
      "facts": [
        {
          "name": "Client Name",
          "value": "${CLIENT_NAME}"
        },
        {
          "name": "Server IP",
          "value": "${SERVER_IP}"
        },
        {
          "name": "Restarted Containers",
          "value": "$(echo -e "$CONTAINER_ALERTS")"
        }
      ]
    }
  ]
}
EOF
)

    # Send the alert to the webhook
    echo "Sending alert to webhook"
    curl -X POST "$WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$payload" | tee -a ${LOGS_PATH}
else
    echo "No containers restarted in the last 5 minutes." | tee -a ${LOGS_PATH}
fi

}

check_container_restart_time
send_alert